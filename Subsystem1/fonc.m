%%Subsystem 1: Casing
%%Attempt to apply FONC to metamodel
syms x1 x2 x3 x4 x5 x6
global beta_coeff
beta=beta_coeff;
f=beta(1)*x+beta(2)*x3+beta(3)*x2^2+beta(4)*x3.^2+beta(5)*x4^2+beta(6)*x5^2+beta(7)/x1+beta(8)/x2+beta(9)/x4+beta(10)/x5+beta(11)/x6+beta(12)*x1*x2+beta(13)*x1*x3+beta(14)*x1*x4+beta(15)*x2*x3+beta(16)*x4*x2+beta(17)*x5*x2+beta(18)*x3*x6;

%first derivative
grad=[diff(f, x1), diff(f, x2),diff(f, x3),diff(f, x4),diff(f, x5),diff(f, x6)];

%second derivative
grad2=[diff(f, x1, x1), diff(f, x2, x2),diff(f, x3,x3),diff(f, x4,x4),diff(f, x5,x5),diff(f, x6,x6)];
disp("Checking FONC ")
%solve for df/d(x(i))=0 x(i) value
g1=solve(grad(1)==0,x1)
g2=solve(grad(2)==0,x2)
g3=solve(grad(3)==0,x3)
g4=solve(grad(4)==0,x4)
g5=solve(grad(5)==0,x5)
