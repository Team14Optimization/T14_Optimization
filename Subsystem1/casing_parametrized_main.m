global m
%x0 = [Rm, Da, Dc, dc, Cc];
%Material list : LDPE, HDPE, PP (Copolymer), PP(Homopolymer), ABS, PEEK (Solidowrks)
%[Density, Conductivity, Heat Capcity]
materials= {[917, 0.332, 1847]; [952, 0.461, 1796]; [890, 0.147, 1881]; [933, 0.117, 1881]; [1020, 0.225, 1386]; [1310, 0.24, 1850]};
fs= [0 0 0 0 0 0];
xs= [0 0 0 0 0 0;
    0 0 0 0 0 0; 
    0 0 0 0 0 0;
    0 0 0 0 0 0;
    0 0 0 0 0 0;
    0 0 0 0 0 0];
for i=1:length(materials)
    disp("===Optimising for material "+i+"===")
    m=cell2mat(materials(i,:));
    x0 = [0.04, 0.005, 0.001];
    A =[1,1,1;-1,-1,-1]; b=[0.037;-0.0125]; 
    Aeq=[]; Beq=[]; 
    lb=[0.03,0.001,0.001]; ub=[100,200,200];
    options = optimoptions('fmincon','MaxIterations', 100);
    %options = optimoptions('fmincon','Display','iter', 'MaxIterations',
    %100) %display iterations
    [x,fval, exitflag, output]=fmincon(@obj,x0,A,b,Aeq,Beq,lb,ub,@nonlcon,options);
    xs(i,:)=[x, m(1:3)]; 
    fs(i)=fval;
end
xs=[fs',xs];
disp("Parametrised Optimisation results: ")
T = array2table(xs,'VariableNames',{'f','rm', 'Da', 'Dc', 'd', 'k', 'Cc'},'RowNames',{'LDPE','HDPE','PP C', 'PP H', 'ABS', 'PEEK'});
disp(T)
%Nonlinear Constraint Function 
function [c, ceq] = nonlcon(x)
global m
ceq = [];

c = m(1)*(pi*0.05*(((x(1)+x(2)+x(3))^2)-(x(1)+x(2)^2)))-0.1;

end
%Objective function
function f=obj(x)
global m beta_coeff
%parameters
beta=beta_coeff;

x(4)=m(1);
x(5)=m(2);
x(6)=m(3);

f=beta(1)*x(2)+beta(2)*x(3)+beta(3)*x(2)^2+beta(4)*x(3).^2+beta(5).*x(4)^2+beta(6)*x(5)^2+beta(7)/x(1)+beta(8)/x(2)+beta(9)/x(4)+beta(10)/x(5)+beta(11)/x(6)+beta(12)*x(1)*x(2)+beta(13)*x(1)*x(3)+beta(14)*x(1)*x(4)+beta(15)*x(2)*x(3)+beta(16)*x(4)*x(2)+beta(17)*x(5)*x(2)+beta(18)*x(3)*x(6);
end