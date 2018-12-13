%Parametric study of objective 1
close all

dc = linspace(890,1310, 50); %Density
k = linspace(0.117,0.461,50); %Thermal Conductivity
Cc = linspace(1386,1881,50); %Specific Heat capacity

sfs= zeros(50,3);
for i=1:50
    sfs(i,1)=f1([0.03,0.0024,0.0046,dc(i), 0.117, 1386]);
    sfs(i,2)=f1([0.03,0.0024,0.0046,890, k(i), 1386]);
    sfs(i,3)=f1([0.03,0.0024,0.0046,890, 0.117, Cc(i)]);
end
disp("Range of f depending on density: "+(sfs(50,1)-sfs(1,1)))
disp("Range of f depending on thermal conductivity: "+(sfs(9,2)-sfs(50,2)))
disp("Range of f depending on specific heat capacity: "+(sfs(1,3)-sfs(50,3)))

subplot(3,1,1)  
scatter(dc,sfs(:,1), 100,'+')
xlabel('Density of casing [kg/m3]','FontSize',18)
set(gca,'FontSize',16)
subplot(3,1,2)
scatter(k,sfs(:,2),100,'+')
xlabel('Thermal conductivity [W/moC]','FontSize',18)
set(gca,'FontSize',16)
subplot(3,1,3)
scatter(Cc,sfs(:,3),100,'+')
xlabel('Specific heat capacity [J/kgoC]','FontSize',18)
sgtitle('Parameter study of objective 1','FontSize',20)
set(gca,'FontSize',16)

function f=f1(x)
global beta_coeff
beta=beta_coeff;
f=beta(1)*x(2)+beta(2)*x(3)+beta(3)*x(2)^2+beta(4)*x(3).^2+beta(5).*x(4)^2+beta(6)*x(5)^2+beta(7)/x(1)+beta(8)/x(2)+beta(9)/x(4)+beta(10)/x(5)+beta(11)/x(6)+beta(12)*x(1)*x(2)+beta(13)*x(1)*x(3)+beta(14)*x(1)*x(4)+beta(15)*x(2)*x(3)+beta(16)*x(4)*x(2)+beta(17)*x(5)*x(2)+beta(18)*x(3)*x(6);
end