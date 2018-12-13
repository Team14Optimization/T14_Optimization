%%%% fmincon optimization of the blades
clc 
clear 

% x(1) is length
% x(2) is height
% x(3) is width
% x(4) is material density

%% Interior-Point 
clear

x0 = [0.01,0.0005,0.005,2];     % initial values
lb=[0.01,0.0005,0.005,2];       % lower bounds
ub=[0.08,0.1,0.05,10];          % upper bounds
A =[]; b=[]; Aeq=[]; beq=[];

options1 = optimoptions('fmincon','Algorithm', 'interior-point');

[x,fval,ef,output,lambda]=fmincon(@objective,x0,A,b,Aeq,beq,lb,ub,@nonlcon, options1);


disp(['Initial Objective: ' num2str(objective(x0))])
disp(table(x(1),x(2),x(3),x(4),'VariableNames',{'l', 'h', 'b', 'density'}))
disp(['Final Objective Interior-Point: ' num2str(objective(x))])
disp(['RPM: ' num2str(60/(objective(x)))])

%% Active-Set
clear

x0 = [0.01,0.0005,0.005,2];     % initial values
lb=[0.01,0.0005,0.005,2];       % lower bounds
ub=[0.08,0.1,0.05,10];          % upper bounds
A =[]; b=[]; Aeq=[]; beq=[];

options2 = optimoptions('fmincon','Algorithm', 'active-set');

[x,fval,ef,output,lambda]=fmincon(@objective,x0,A,b,Aeq,beq,lb,ub,@nonlcon, options2);


disp(['Initial Objective: ' num2str(objective(x0))])
disp(table(x(1),x(2),x(3),x(4),'VariableNames',{'l', 'h', 'b', 'density'}))
disp(['Final Objective Active-Set: ' num2str(objective(x))])
disp(['RPM: ' num2str(60/(objective(x)))])

%% SQP
clear

x0 = [0.01,0.0005,0.005,2];     % initial values
lb=[0.01,0.0005,0.005,2];       % lower bounds
ub=[0.08,0.1,0.05,10];          % upper bounds
A =[]; b=[]; Aeq=[]; beq=[];

options3 = optimoptions('fmincon','Algorithm', 'sqp');

[x,fval,ef,output,lambda]=fmincon(@objective,x0,A,b,Aeq,beq,lb,ub,@nonlcon, options3);


disp(['Initial Objective: ' num2str(objective(x0))])
disp(table(x(1),x(2),x(3),x(4),'VariableNames',{'l', 'h', 'b', 'density'}))
disp(['Final Objective SQP: ' num2str(objective(x))])
disp(['RPM: ' num2str(60/(objective(x)))])


%% Objective Function

function f=objective(x)

mass = (x(4)*10^3).*x(3).*x(2).*x(1);
f = (2*pi*x(1))/((3.6/(x(1).*x(3)))-(1054).*x(2).*x(1))/(mass*(x(1)));

end

%% Non Linear Constraints

function [c, ceq] = nonlcon(x) 
    
    ceq = [];

    g1 = x(2)-0.08*x(1);
    g2 = x(3)-0.5*x(1);
    
    g3 = (1/3)*(x(4)*10^3).*x(3).*x(2).*x(1)*(x(1).^2)-860;
    
    
    c = [g1 g2 g3];

end



