%%%Fiting a function to predict casing temperature at any time

D = csvread('time.csv'); %load temperature vs time data 
t=D(:,1);
T=D(:,2);
max=T(30); %maximum temperature value (at 30 s)
Ts=T./max; %scale temperature data to 0-1 values;

mdl = fitlm(t,T,'quadratic'); %fit a quadratic model to data
coeff=table2array(mdl.Coefficients)
a0=coeff(1,1)
a1=coeff(2,1)
a2=coeff(3,1)

%Plot scaled data to assess model fit
figure()
plot(t, Ts)
disp(mdl.Coefficients)
hold on
plot(t, ((a2/max)*t.^2+(a1/max)*t)+(a0/max))
title('')
