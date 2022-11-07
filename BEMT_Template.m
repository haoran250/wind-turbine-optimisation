function [Cp] = BEMT_Template(B, radiusLimits, lambda, chordProfile, AoAProfile, noElements, V, kinematicViscosity, convergenceTolerance, iterationLimit)
% Clear Command Window

% Clear figures
close all

%% Notes on model inputs
% Input 1: number of blades

% Input 2: start and end radius for blade in metres e.g. [0.2, 0.5]

% Input 3: tip-speed ratio

% Input 4: chord lengths at root and tip in metres e.g [0.08, 0.038] for
%          TSR of 5

%Input 5: Angle of Attack profile at root and tip in metres e.g [5, 8] 
%Input 6: number of blade elements (at least 10)

% Input 7: velocity of free-stream in m/s

% Input 8: kinematic viscosity of the air e.g. 1.5e-5

% Input 9: the maximum allowable fluctuation in a and aPrime to conclude
%          convergence

% Input 10: The limit on the number of iterations for the iterative solve.


%% Introductory matter

% Load previously created lookup table for S822 airfoil CL values
load('S822_CL_Lookup.mat');
load('S822_CD_Lookup.mat');
load('S822_Alpha_Values.mat');
load('S822_Re_Values.mat');
rho=1.225;

% Array of radii for each blade element
r = linspace(radiusLimits(1), radiusLimits(2), noElements);

%Omega
omega = V*lambda/radiusLimits(2);


% Chord length
if length(chordProfile) == 2;
    c = linspace(chordProfile(1), chordProfile(2), noElements);
end

% Gamma Profile
if length(AoAProfile) == 2;
    AoA = deg2rad(linspace(AoAProfile(1), AoAProfile(2), noElements));
end


%% Iterative BEMT Solution
  for i = 1:noElements;
     if i==1;
       a = 1/3;
       aprime = 0;
     end
     sigr=(B*c(i)/(2*pi*r(i)));
     deltaA=inf;
     deltaAprime =inf;
     lambda_r=lambda*(r(i)/radiusLimits(2));
    iter=0 ;
    
    while (abs(deltaA)>convergenceTolerance|| abs(deltaAprime)>convergenceTolerance) && (abs(deltaA)>convergenceTolerance && abs(deltaA)>convergenceTolerance)
      
        phi = atan((1-a)/(lambda_r*(1+aprime)));
        %angle between blade and rotor hook
        gamma(i)=phi - AoA(i);
        Vrel = (V*(1-a)) / (sin(phi));
        Re = (Vrel*c(i)) /kinematicViscosity;
       
        CL = griddata(S822_Alpha_Values, S822_Re_Values, S822_CL_Lookup', rad2deg(AoA(i)), Re);
        CD = griddata(S822_Alpha_Values, S822_Re_Values, S822_CD_Lookup', rad2deg(AoA(i)), Re);
        CT=(CL*sin(phi))-(CD*cos(phi));
        CX=(CL*cos(phi))+(CD*sin(phi));
        
        %a=1/(((4*(sin(phi)^2)/(sigr*CX))+1))
        %aprime=1/((((4*sin(phi)*cos(phi))/sigr*CT))-1)
        aNew = 1/(4*sin(phi)^2/(sigr*CX) + 1);

        aprimeNew = 1/(4*sin(phi)*cos(phi)/(sigr*CT)) ;
        deltaA=aNew-a;
        deltaAprime=aprimeNew-aprime;
       a=aNew;
       aprime=aprimeNew;
      iter=iter+1;
      

    end
  
dT(i)=0.5*1.225*(Vrel^2*c(i)*r(i)*CT);
dT(isnan(dT))=0;
gammaStore(i)=gamma(i);
ReStore(i) = Re;
CLStore(i) =CL;

%plotOutputPoints(c(i),gammaStore(i),r,i,noElements);
end

%% Perform numerical integration across blade elements

T=trapz(r,dT);
P = omega*T*B;
Cp=P/(0.5*rho*(V^3)*(pi*((radiusLimits(2))^2)));

end



