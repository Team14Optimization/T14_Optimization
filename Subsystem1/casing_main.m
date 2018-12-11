%%Subystem 1 Casing optimisation%%
format shortEng
%x0 = [Rm, Da, Dc, dc, k, Cc];
x0 = [0.035, 0.002, 0.003, 1000, 0.2, 1586];
A =[1,1,1,0,0,0;-1,-1,-1,0,0,0]; b=[0.037;-0.0125]; 
Aeq=[]; Beq=[]; 
lb=[0.03, 0.001, 0.001, 890, 0.117, 1386]; 
ub=[100,200,200,1310,0.461,1881]; %upper bound for x(1), x(2), x(3) are placeholder only

disp("========Using Interior Point Algorithm======")
tic
options = optimoptions('fmincon','MaxIterations', 100);
% options = optimoptions('fmincon','Display','iter', 'MaxIterations', 100);
% %view iterations

[x_ip,f_ip, exitflag, output]=fmincon(@obj,x0,A,b,Aeq,Beq,lb,ub,@nonlcon,options);
toc
disp("Interior Point Result: ")
disp(table(f_ip,x_ip(1),x_ip(2),x_ip(3),x_ip(4),x_ip(5),x_ip(6),'VariableNames',{'f','rm', 'Da', 'Dc', 'd', 'k', 'Cc'}))

disp("========Using Interior SQP Algorithm======")
tic
options = optimoptions('fmincon','Algorithm', 'sqp');
[x_sqp,f_sqp, exitflag, output]=fmincon(@obj,x0,A,b,Aeq,Beq,lb,ub,@nonlcon,options);
toc
disp("SQP Result: ")
disp(table(f_sqp,x_sqp(1),x_sqp(2),x_sqp(3),x_sqp(4),x_sqp(5),x_sqp(6),'VariableNames',{'f','rm', 'Da', 'Dc', 'd', 'k', 'Cc'}))


disp("========Using Active-set Algorithm======")
tic
options = optimoptions('fmincon','Algorithm', 'active-set');
[x_as,f_as, exitflag, output]=fmincon(@obj,x0,A,b,Aeq,Beq,lb,ub,@nonlcon,options);
toc

disp("Active Set Result: ")
disp(table(f_as,x_sqp(1),x_as(2),x_as(3),x_as(4),x_as(5),x_as(6),'VariableNames',{'f','rm', 'Da', 'Dc', 'd', 'k', 'Cc'}))

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
f=beta(1)*x(2)+beta(2)*x(3)+beta(3)*x(2)^2+beta(4)*x(3).^2+beta(5).*x(4)^2+beta(6)*x(5)^2+beta(7)/x(1)+beta(8)/x(2)+beta(9)/x(4)+beta(10)/x(5)+beta(11)/x(6)+beta(12)*x(1)*x(2)+beta(13)*x(1)*x(3)+beta(14)*x(1)*x(4)+beta(15)*x(2)*x(3)+beta(16)*x(4)*x(2)+beta(17)*x(5)*x(2)+beta(18)*x(3)*x(6);
end