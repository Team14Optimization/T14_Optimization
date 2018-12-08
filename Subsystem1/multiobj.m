%%Subsystem 1 -Casing-
%%Multi Objective Optimisation
%%Weight & Temperature
disp("===Multiobjective Optimization===")
FitnessFunction = @simple_multiobjective;
n=6;
options = optimoptions(@gamultiobj,'PlotFcn',{@gaplotpareto,@gaplotscorediversity});
A =[1,1,1,0,0,0;-1,-1,-1,0,0,0]; b=[0.037;-0.0125]; Aeq=[]; beq=[]; lb=[0.03, 0.001, 0.001, 890, 0.117, 1386]; ub=[100,200,200,1310,0.461,1881];
[x, fval] = gamultiobj(FitnessFunction,n,A,b,Aeq,beq,lb,ub,options);
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
   bets=beta_coeff;
   f(1) = bets(1).*x(1)+bets(2).*x(2)+bets(3).*x(3)+bets(4).*x(4)+bets(5).*x(5)+bets(6).*x(6)+bets(7).*x(5).^2+bets(8).*x(4).^2+bets(9)*x(3).^2+bets(10)./x(4)+bets(11)./x(2)+bets(12);
   f(2) = x(4)*(pi*0.05*(((x(1)+x(2)+x(3))^2)-(x(1)+x(2))^2));
 end