%%Subsystem 1 -Casing-
%%Multi Objective Optimisation
%%Weight & Temperature
disp("===Multiobjective Optimization===")
FitnessFunction = @simple_multiobjective;
n=10;
nIcon = @nonIcon4VARS;
options = optimoptions(@gamultiobj,'PlotFcn',{@gaplotpareto});
A =[1,1,1,0,0,0,0,0,0,0;-1,-1,-1,0,0,0,0,0,0,0;0,0,0,0,0,0,-0.08,1,0,0;0,0,0,0,0,0,-0.5,0,1,0;-1,-1,-1,0,0,0,1,0,0,0]; 
b=[0.037;-0.0125;0;0;0]; Aeq=[]; beq=[]; 
lb=[0.03, 0.001, 0.001, 890, 0.117, 1386,0.01,0.0005,0.004,0.02]; ub=[100,200,200,1310,0.461,1881,0.05,0.1,0.05,2.2];
[x, fval] = gamultiobj(FitnessFunction,n,A,b,Aeq,beq,lb,ub,nIcon,options);
%% 
fval_n=mapstd(fval'); %normalize fval to give correct waiting

f3=0.5*fval_n(1,:)+0.5*fval_n(2,:); %equal weighting for both objectives
idx = find(f3==min(f3)); %find minimum when both objectives are considered

solution_x=x(idx,:);
solution_f=fval(idx,:);

disp("Objective 1 minimum: "+solution_f(1))
disp("Objective 2 minimum: "+solution_f(2))
disp(table(solution_x(1),solution_x(2),solution_x(3),solution_x(4),solution_x(5),solution_x(6),'VariableNames',{'rm', 'Da', 'Dc', 'd', 'k', 'Cc'}))

 function f = simple_multiobjective(x)
   global beta_coeff
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
   f(2) =(2*pi*x(7))/((3.6/(x(7).*x(9)))-(1054).*x(8).*x(7))/((x(10)*10^4).*x(9).*x(8).*(x(7).^2));
   m=beta(1)*x(2)+beta(2)*x(3)+beta(3)*x(2)^2+beta(4)*x(3).^2+beta(5).*x(4)^2+beta(6)*x(5)^2+beta(7)/x(1)+beta(8)/x(2)+beta(9)/x(4)+beta(10)/x(5)+beta(11)/x(6)+beta(12)*x(1)*x(2)+beta(13)*x(1)*x(3)+beta(14)*x(1)*x(4)+beta(15)*x(2)*x(3)+beta(16)*x(4)*x(2)+beta(17)*x(5)*x(2)+beta(18)*x(3)*x(6);
   t=1000*f(2);
   f(1)=(0.00092096/m)*t.^2-(0.00085466/m)*t-0.01201/m
 end
 
 
function [c, ceq] = nonIcon4VARS(x) 
    ceq = [];

%     g1 = x(7)-0.08;         % l < 0.06
%     g2 = 0.01-x(7);          % l > 0.03
% %     g3 = x(2)-0.01;         % h < 0.01
% %     g4 = 0.0005-x(2);       % h > 0.0005
% %     g5 = x(3)-0.05;         % w < 0.05
% %     g6 = 0.01-x(3);         % w > 0.01
%     g7 = x(10)-2.2;          % p < 10000
%     g8 = 0.02-x(10);         % p > 2000
%     g9 = x(8)-0.15*x(7);     % h < 0.1*l
%     g10 = x(9)-0.5*x(7);    % w < 0.5*l 
    
    g11 = x(4)*(pi*0.05*(((x(1)+x(2)+x(3))^2)-(x(1)+x(2)^2)))-0.1;
    
    
    c = [g11];

end
