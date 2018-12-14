%%% Global search
clc
clear

x0 = [0.04,0.005,0.025,6];

lb=[0.01,0.0005,0.005,2];
ub=[0.08,0.1,0.05,10];

rng default
gs = GlobalSearch;

problem = createOptimProblem('fmincon','x0',x0,'objective',@objective,'nonlcon',@nlcon,'lb',lb,'ub',ub);
x = run(gs,problem);

disp(table(x(1),x(2),x(3),x(4),'VariableNames',{'l', 'h', 'b', 'density'}))
disp(['Final Objective: ' num2str(objective(x))])
disp(['RPM: ' num2str(60/(objective(x)))])

%% Non Linear Constraints & Objective Function 

function [c, ceq] = nlcon(x) 
    ceq = [];

    g1 = x(2)-0.08*x(1);     % h < 0.1*l
    g2 = x(3)-0.5*x(1);      % w < 0.5*l 
    
    g3 = (1/3)*(x(4)*10^3).*x(3).*x(2).*x(1)*(x(1).^2)-860;
        
    c = [g1 g2 g3];

end

function f=objective(x)

mass = (x(4)*10^3).*x(3).*x(2).*x(1);
f = (2*pi*x(1))/((3.6/(x(1).*x(3)))-(1054).*x(2).*x(1))/(mass*(x(1)));

end

