% ATC_Demo1 demonstrates Analytical Target Cascading (ATC), a method for
% solving large-scale engineering design problems, by solving a simple
% analytical optimization problem. The purpose is not to demonstrate the
% benefits of ATC, but to illustrate its implementation clearly. The
% optimization problem is solved first using the standard (undecomposed)
% approach. The ATC implementation is then demonstrated, and the results of
% the two approaches are shown to be identical (within specified precision).
%
% To execute the example, type ATC_Demo1 at the Matlab command prompt.
%
% Author: James T. Allison


clc

%% Solve using AiO (single optimization problem)

x0 = [0.03, 0.002, 0.004, 1000, 0.2, 1586, 0.01, 0.0005, 0.004, 0.02];
lb=[0.03, 0.001, 0.001, 890, 0.117, 1386,0.01,0.0005,0.005,2]; 
ub=[100,200,200,1310,0.461,1881,0.08,0.1,0.05,10];
A =[1,1,1,0,0,0,0,0,0,0;
    -1,-1,-1,0,0,0,0,0,0,0;
    0,0,0,0,0,0,-0.08,1,0,0;
    0,0,0,0,0,0,-0.5,0,1,0;
    -1,-1,-1,0,0,0,1,0,0,0]; 

b=[0.037;-0.0125;0;0;0];
disp('----------------------------')
disp('Solving using AiO:')
disp('----------------------------')

options = optimoptions('fmincon','Display','iter', 'MaxIterations', 100);
[x,fopt] = fmincon(@AiOobj,x0,A,b,[],[],lb,ub,@nonlcon,options);
disp(['x*=[' num2str(x(1)) ', ' num2str(x(2)) ',' num2str(x(3)) ',' num2str(x(4)) ',' num2str(x(5)) ',' num2str(x(6)) ',' num2str(x(7)) ',' num2str(x(8)) ',' num2str(x(9)) ',' num2str(x(10)) '], f(x*)=' num2str(fopt)])

%% AIO FUNCTIONS:

function f = AiOobj(x)
beta=[-634.283694971208
-1137.95569535442
-32051.9192040854
62964.0758309271
8.67559868959550e-07
-2.59007619657034
0.140417294843048
0.00210985552244592
-1818.50887533129
-0.0171863394853307
-118.340410810833
31752.7535896412
12311.4132131939
-0.0652488678974873
60795.8424217339
-0.284938476424967
137.777512399987
-0.0671929909172967];
   t =(2*pi*x(7))/((3.6/(x(7).*x(9)))-(1054).*x(8).*x(7))/((x(10)*10^3).*x(9).*x(8).*(x(7).^2));
   m=beta(1)*x(2)+beta(2)*x(3)+beta(3)*x(2)^2+beta(4)*x(3).^2+beta(5).*x(4)^2+beta(6)*x(5)^2+beta(7)/x(1)+beta(8)/x(2)+beta(9)/x(4)+beta(10)/x(5)+beta(11)/x(6)+beta(12)*x(1)*x(2)+beta(13)*x(1)*x(3)+beta(14)*x(1)*x(4)+beta(15)*x(2)*x(3)+beta(16)*x(4)*x(2)+beta(17)*x(5)*x(2)+beta(18)*x(3)*x(6);
   t=1000*t;
   f=(0.00092096/m)*t.^2-(0.00085466/m)*t-0.01201/m;
end

function [c, ceq] = nonlcon(x)
   g1 = x(4)*(pi*0.05*(((x(1)+x(2)+x(3))^2)-(x(1)+x(2)^2)))-0.1;
   g2 = x(8)-0.15*x(7);     
   g3 = x(9)-0.5*x(7);
   g4 = (1/3)*(x(10)*10^3)*x(9)*x(8)*x(7)*(x(7)^2)-860;
   c = [g1 g2 g3 g4];
    ceq=[];
end


