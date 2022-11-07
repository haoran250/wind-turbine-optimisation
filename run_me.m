clear all
%randomised initial guesses
xx1=0.15+(0.2-0.15)*rand(20,1)
xx2=0.15+(0.2-0.15)*rand(20,1)
xx3=2+(4-2)*rand(20,1)
xx4=7+(11-7)*rand(20,1)

tic;
parfor i=1:20  %loop through all intial guesses
[chord1,chord2,TSR,angle]=algorithmtest(xx1(i),xx2(i),xx3(i),xx4(i));
xxx1(i)=chord1
xxx2(i)=chord2
xxx3(i)=TSR
xxx4(i)=angle
cpnew(i)=BEMT_Template(3, [0.12  0.5],xxx3(i), [xxx2(i) xxx1(i)], [xxx4(i) 5], 30, 3, 1.5e-5, 0.001, 30)
end
[cp,I]=max(cpnew)
chord1= xxx1(I)
chord2=xxx2(I)
TSR=xxx3(I)
AoA=xxx4(I)
toc;

optimised_cp=BEMT_Templateplot(3, [0.12 0.5],TSR, [chord2 chord1], [AoA,5], 30, 3, 1.5e-5, 0.001, 30)
% chord_length=xx1
% Tip_Speed_Ratio=xx2
% Angle_of_Attack=xx3

