%%Subystem 1 Casing optimisation%%
%x0 = [Rm, Da, Dc, dc, k, Cc];
x0 = [0.035, 0.002, 0.003, 1000, 0.2, 1586];
A =[1,1,1,0,0,0;-1,-1,-1,0,0,0]; b=[0.037;-0.0125]; 
Aeq=[]; Beq=[]; 
lb=[0.03, 0.001, 0.001, 890, 0.117, 1386]; 
ub=[100,200,200,1310,0.461,1881]; %upper bound for x(1), x(2), x(3) are placeholder only

tic
options = optimoptions('fmincon','Display','iter', 'MaxIterations', 100)
[x_ip,f_ip, exitflag, output]=fmincon(@obj,x0,A,b,Aeq,Beq,lb,ub,@nonlcon,options);
toc

tic
options = optimoptions('fmincon','Display','iter', 'MaxIterations', 100, 'Algorithm', 'sqp');
[x_sqp,f_sqp, exitflag, output]=fmincon(@obj,x0,A,b,Aeq,Beq,lb,ub,@nonlcon,options);
toc

tic
options = optimoptions('fmincon','Display','iter', 'MaxIterations', 100, 'Algorithm', 'active-set');
[x_as,f_as, exitflag, output]=fmincon(@obj,x0,A,b,Aeq,Beq,lb,ub,@nonlcon,options);
toc
% dlmwrite('results.csv',[x_ip,f_ip],'delimiter',',','-append');
% dlmwrite('results.csv',[x_sqp,f_sqp],'delimiter',',','-append');
% dlmwrite('results.csv',[x_as,f_as],'delimiter',',','-append');

%Nonlinear Constraint Function 
function [c, ceq] = nonlcon(x)
ceq = [];
c = x(4)*(pi*0.05*(((x(1)+x(2)+x(3))^2)-(x(1)+x(2)^2)))-0.1;
end

%Objective function
function f=obj(x)
global beta_coeff
beta=beta_coeff;
%metamodel from model.m
f = beta(1).*x(1)+beta(2).*x(2)+beta(3).*x(3)+beta(4).*x(4)+beta(5).*x(5)+beta(6).*x(6)+beta(7).*x(5).^2+beta(8).*x(4).^2+beta(9)*x(3).^2+beta(10)./x(4)+beta(11)./x(2)+beta(12);
end