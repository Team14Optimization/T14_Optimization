%%Subsystem 1: Casing
%%Attempt to apply FONC to metamodel
syms x1 x2 x3 x4 x5 x6
global beta_coeff
beta=beta_coeff;
f = beta(1)*x1+beta(2)*x2+beta(3).*x3+beta(4).*x4+beta(5).*x5+beta(6).*x6+beta(7).*x5.^2+beta(8).*x4.^2+beta(9)*x3.^2+beta(10)./x4+beta(11)./x2+beta(12);

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

disp("Checking SOC: ")
g23=subs(grad2(3),g3) %second derivative wrt x(3)
g25=subs(grad2(5),g5) %second derivative wrt x(5)