function [chord1,chord2, TSR, angle] = algorithmtest(xx1,xx2,xx3,xx4)

%%%%% 4-D Nelder Mead Algorithm%%%%%%%%%
% xx1=0.18
% xx2=0.18
% xx3=3
% xx4=9


% prompt = 'input iteration number? ';
% maxIter = input(prompt)
% prompt1 ='input intial guess 1 (recommended value = 4): '
% xx1=input(prompt1)
% prompt2 ='input intial guess 2 (recommended value = 4): '
% xx2=input(prompt2)
tic
x0 = [xx1,xx2,xx3,xx4];
maxIter=60;

%NM parameters for reflection, contractions and shrink
alpha = 1;
beta = 0.5;
gamma = 2;
delta = 0.5;
lambda= 1;
%dimension of cost function
dim = 4;


%*********** initilises simplex around guess, x0 *********%

% c = 1; %simplex size parameter
% b = (c/(dim*sqrt(2)))*(sqrt(dim+1) - 1);
% a = b + c/(sqrt(2));
% 
% x_sort = zeros(dim,dim+1);
% for i = 1:dim
%     add = [b; b];
%     add(i) = a;
%     x_sort(:,i) = x0' + add;
% end
% x_sort(:,end) = x0';
D1=lambda*(sqrt(dim+1)+dim-1)/sqrt(2)*dim;
    D2=lambda*(sqrt(dim+1)-1)/sqrt(2)*dim;
    x=zeros(dim,dim+1);
    x(:,1)=x0;
    for k=2:dim+1
        for i=1:dim
            if i==k
                x(i,k)=x0(i)+D1;
            else
                x(i,k)=x0(i)+D2;
            end
        end
    end
    x_sort = x
    
%%% *********************************************** %%%      
%       figure(1);
%       hold on
% view(3)
% temp = plot3([x_sort(1,:) x_sort(1,1)], [x_sort(2,:) x_sort(2,1)], [x_sort(3,:) x_sort(3,1)],'k-o', 'LineWidth',2);
iter = 1; 


 
%%%% ********* evaluate and order elements ********* %%%%%
[y_sort,I] = sort(callalgo(x_sort)); %callFun is a separate function script
x_sort = x_sort(:,I);


%initialises iteration count

 while iter < maxIter    
%%%%% ********* calc. and order elements ********* %%%%%
[y_sort,I]=sort(y_sort);
x_sort=x_sort(:,I);

%%%%% ********* calc centroid (exclude x(end) [worst point]) ********* %%%%%

XL2=x_sort(:,[2]);
XL1=x_sort(:,[3]);
XW=x_sort(:,end);
XB=x_sort(:,[1]);
XL=x_sort(:,end-1);
xb1=x_sort(1,[1]);
xb2=x_sort(2,[1]);
xb3=x_sort(3,[1]);
xb4=x_sort(4,[1]);
xc1=x_sort(1,[2]);
xc2=x_sort(2,[2]);
xc3=x_sort(3,[2]);
xc4=x_sort(4,[2]);
xd1=x_sort(1,[end-1]);
xd2=x_sort(2,[end-1]);
xd3=x_sort(3,[end-1]);
xd4=x_sort(4,[end-1]);
xa1=x_sort(1,3);
xa2=x_sort(2,3);
xa3=x_sort(3,3);
xa4=x_sort(4,3);

XA=[((xb1+xc1+xd1+xa1)/4);((xb2+xc2+xd2+xa2)/4);((xb3+xc3+xd3+xa3)/4);((xb4+xc4+xd4+xa4)/4)];
XR= XA+XA-XW;
Fr=callalgo(XR);
Fb=callalgo(XB);
Fl=callalgo(XL);
Fl1=callalgo(XL1);
Fl2=callalgo(XL2);
Fw=callalgo(XW);
%%%% ********* reflection, contraction or shrink ********* %%%%%
   if Fr < Fb;
    %expansion
    XE= XA + 2* (XR-XA);
    Fe=callalgo(XE);
    if Fe < Fb;
          XW=XE;
    else XW=XR;
        FW=Fr;
    end
   else
       if Fr <= Fl && Fr> Fb
        XW=XR;
        Fb=Fr;
      else 
      if Fr>Fw;
          %inside contraction
          XC1=XA-0.5*(XA-XW);
          Fc1=callalgo(XC1);
          if Fc1<Fw;
              XW=XC1;
              Fw = Fc1;
          else
              XL=XB+0.5*(XL-XB);
               XL1=XB+0.5*(XL1-XB);
                XL2=XB+0.5*(XL2-XB);
              XW=XB+0.5*(XW-XB);
               Fl=callalgo(XL);
           Fl1=callalgo(XL1);
           Fl2=callalgo(XL2);
            Fw=callalgo(XW);
          end
      else
          if Fr<=Fw && Fr>Fl; 
          XC=XA+0.5*(XA-XW);
          Fc=callalgo(XC);
           if Fc<=Fr;
               XW=XC;
               Fw=Fc;
           else
          XL=XB+0.5*(XL-XB);
          XL1=XB+0.5*(XL1-XB);
          XL2=XB+0.5*(XL2-XB);
          XW=XB+0.5*(XW-XB);
          Fl=callalgo(XL);
          Fl1=callalgo(XL1);
           Fl2=callalgo(XL2);
          Fw=callalgo(XW);
           end
          end
      end
       end  
   
 end 
 x_sort=[XB,XL2,XL1,XL,XW];
y_sort=[Fb,Fl2, Fl1,Fl,Fw];
% delete(temp)
% view(3)
% temp = plot3([x_sort(1,:) x_sort(1,1)], [x_sort(2,:) x_sort(2,1)], [x_sort(3,:) x_sort(3,1)],'k-o', 'LineWidth',2);

%termination function based on tolerance



%update iteration no.
iter = iter + 1;

end


toc
x_mean = mean(x_sort,2)

chord1=x_mean(1)
chord2=x_mean(2)
TSR=x_mean(3)
angle=x_mean(4)

