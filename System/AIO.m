% Based on ATC_Demo1.m by Author: James T. Allison

%% Optimize blender system using AiO (single optimization problem)

%x= [Rm, Da, Dc, d1, k , Cc, l, h, b, d2]
x0 = [0.035, 0.002, 0.004, 1000, 0.25, 1586, 0.05, 0.001, 0.008, 5];
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
[x_sys,fopt] = fmincon(@AiOobj,x0,A,b,[],[],lb,ub,@nonlcon,options);
f1opt=f1(x_sys);
f2opt=f2(x_sys);

disp('=====System optimisation results=====')
disp(table(fopt,x_sys(1),x_sys(2),x_sys(3),x_sys(4),x_sys(5),x_sys(6),x_sys(7),x_sys(8),x_sys(9),x_sys(10),'VariableNames',{'f','rm', 'Da', 'Dc', 'd1', 'k','Cc','l','h','b','d2'}))
disp("Subsystem 1 Objective: "+f1opt)
disp("Subsystem 2 Objective: "+f2opt)

% AIO FUNCTION:
function f = AiOobj(x)
   t =f2(x);
   m=f1(x);
   t=1000*t;
   f=(0.00092096/m)*t.^2-(0.00085466/m)*t-0.01201/m;
end
function f=f1(x)
global beta_coeff
beta=beta_coeff;
% beta=[-634.283694971208
% -1137.95569535442
% -32051.9192040854
% 62964.0758309271
% 8.67559868959550e-07
% -2.59007619657034
% 0.140417294843048
% 0.00210985552244592
% -1818.50887533129
% -0.0171863394853307
% -118.340410810833
% 31752.7535896412
% 12311.4132131939
% -0.0652488678974873
% 60795.8424217339
% -0.284938476424967
% 137.777512399987
% -0.0671929909172967];
f=beta(1)*x(2)+beta(2)*x(3)+beta(3)*x(2)^2+beta(4)*x(3).^2+beta(5).*x(4)^2+beta(6)*x(5)^2+beta(7)/x(1)+beta(8)/x(2)+beta(9)/x(4)+beta(10)/x(5)+beta(11)/x(6)+beta(12)*x(1)*x(2)+beta(13)*x(1)*x(3)+beta(14)*x(1)*x(4)+beta(15)*x(2)*x(3)+beta(16)*x(4)*x(2)+beta(17)*x(5)*x(2)+beta(18)*x(3)*x(6);
end

function f=f2(x)
   f =(2*pi*x(7))/((3.6/(x(7).*x(9)))-(1054).*x(8).*x(7))/((x(10)*10^3).*x(9).*x(8).*(x(7).^2));
end
%Nonlinear constraints
function [c, ceq] = nonlcon(x)
   g1 = x(4)*(pi*0.05*(((x(1)+x(2)+x(3))^2)-(x(1)+x(2)^2)))-0.1;
   g2 = x(8)-0.15*x(7);     
   g3 = x(9)-0.5*x(7);
   g4 = (1/3)*(x(10)*10^3)*x(9)*x(8)*x(7)*(x(7)^2)-860;
   c = [g1 g2 g3 g4];
    ceq=[];
end


