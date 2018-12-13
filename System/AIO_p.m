% Based on ATC_Demo1.m by Author: James T. Allison

%% Optimize blender system using AiO (single optimization problem)

%x= [Rm, Da, Dc, l, h, b, d2]
x0 = [0.035, 0.004, 0.03, 0.05, 0.001, 0.01, 5];
lb=[0.03, 0.001, 0.001, 0.01,0.0005,0.005,2]; 
ub=[100,200,200,0.08,0.1,0.05,10];
A =[1,1,1,0,0,0,0;
    -1,-1,-1,0,0,0,0;
    0,0,0,-0.08,1,0,0;
    0,0,0,-0.5,0,1,0;
    -1,-1,-1,1,0,0,0]; 

b=[0.037;-0.0125;0;0;0];
disp('----------------------------')
disp('Solving using AiO:')
disp('----------------------------')

options = optimoptions('fmincon','Display','iter', 'MaxIterations', 100);
[x_sys,fopt] = fmincon(@AiOobj,x0,A,b,[],[],lb,ub,@nonlcon,options);

f1opt=f1(x_sys)
f2opt=f2(x_sys)

disp('=====System optimisation results=====')
disp(table(fopt,x_sys(1),x_sys(2),x_sys(3),917,	0.332,	1847,x_sys(4),x_sys(5),x_sys(6),x_sys(7),'VariableNames',{'f','rm', 'Da', 'Dc', 'd1', 'k','Cc','l','h','b','d2'}))
disp("Subsystem 1 Objective: "+f1opt)
disp("Subsystem 2 Objective: "+f2opt)

% AIO FUNCTION:
function f = AiOobj(x)
   t =f2(x)
   m=f1(x)
   t=1000*t;
   f=(0.00092096/m)*t.^2-(0.00085466/m)*t-0.01201/m;
end
function f=f1(x)
global beta_coeff
beta=beta_coeff
x(4)=917;	
x(5)=0.332;	
x(6)=1847;
f=beta(1)*x(2)+beta(2)*x(3)+beta(3)*x(2)^2+beta(4)*x(3).^2+beta(5).*x(4)^2+beta(6)*x(5)^2+beta(7)/x(1)+beta(8)/x(2)+beta(9)/x(4)+beta(10)/x(5)+beta(11)/x(6)+beta(12)*x(1)*x(2)+beta(13)*x(1)*x(3)+beta(14)*x(1)*x(4)+beta(15)*x(2)*x(3)+beta(16)*x(4)*x(2)+beta(17)*x(5)*x(2)+beta(18)*x(3)*x(6);
end
function f=f2(x)
f=(2*pi*x(3))/((3.6/(x(4).*x(6)))-(1054).*x(5).*x(4))/((x(7)*10^3).*x(6).*x(5).*(x(4).^2));
end
%Nonlinear constraints
function [c, ceq] = nonlcon(x)
g4 = (1/3)*(x(7)*10^3)*x(6)*x(5)*x(4)*(x(4)^2)-860;
   g1 = 917*(pi*0.05*(((x(1)+x(2)+x(3))^2)-(x(1)+x(2)^2)))-0.1;
   g2 = x(5)-0.15*x(4);     
   g3 = x(6)-0.5*x(4);
   c = [g1 g2 g3 g4];
    ceq=[];
end


