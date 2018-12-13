%%% Sub-System 2 - Blades
%%% Multi Objective Optimisation
%%% Mass & Time
%  disp("===Multiobjective Optimization===")

clc
clear

FitnessFunction = @blademultiobj;
n=10;

A =[]; b=[]; 
Aeq=[]; beq=[]; 
lb=[0.01,0.0005,0.005,2]; 
ub=[0.08,0.1,0.05,10];

options = optimoptions(@gamultiobj,'PlotFcn',{@gaplotpareto});

[x, fval] = gamultiobj(FitnessFunction,n,A,b,Aeq,beq,lb,ub,@nonlcon,options);

%% Weighting the Functions 

fnorm = mapstd(fval'); 

multifun = 0.5*fnorm(1,:)+0.5*fnorm(2,:); 

minim = find(multifun==min(multifun)); 

X = x(minim,:);
F = fval(minim,:);

disp('Objective 1 minimum: '+F(1))
disp('Objective 2 minimum: '+F(2))
disp(table(X(1),X(2),X(3),X(4),'VariableNames',{'l', 'h', 'b', 'density'}))
disp(['Final Objective Mass: ' num2str(F(1))])
disp(['Final Objective Function: ' num2str(F(2))])
disp(['RPM: ' num2str(60/(F(2)))])
sol = 60/F(2);

%% Objective Function and Non Linear Constraints

 function f = blademultiobj(x)
 
   f(1)=(x(4)*10^3).*x(3).*x(2).*x(1);
   f(2)=(2*pi*x(1))/((3.6/(x(1).*x(3)))-(1054).*x(2).*x(1))/(((x(4)*10^3).*x(3).*x(2).*x(1))*(x(1)));
 
 end
 
 
function [c, ceq] = nonlcon(x) 

    ceq = []; 
    
    g1 = (1/3)*(x(4)*10^3).*x(3).*x(2).*x(1)*(x(1).^2)-860;
    g2 = x(2)-0.08*x(1);
    g3 = x(3)-0.5*x(1);
    
    c = [g1 g2 g3];

end
