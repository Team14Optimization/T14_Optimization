%%%Fiting a function to predict casing temperature at any time based ond
%%%temperature reached after 30s
close all

D = csvread('time.csv'); %load temperature vs time data 
t=D(:,1);
T=D(:,2);
max=T(30); %maximum temperature value (at 30 s)
Ts=T./max; %scale temperature data to 0-1 values;

mdl = fitlm(t,T,'quadratic'); %fit a quadratic model to data
coeff=table2array(mdl.Coefficients);
a0=coeff(1,1); %intercept
a1=coeff(2,1); %coefficient of t
a2=coeff(3,1); %coeficient of t^2

disp("Scaled model coefficients: "+a2/max+"*x^2"+a1/max+"*x"+a0/max)

%Plot scaled data to assess model fit
figure()
plot(t, Ts,'DisplayName','Data')
hold on
plot(t, ((a2/max)*t.^2+(a1/max)*t)+(a0/max),'DisplayName','Model')
legend
xlabel("Time [s]")
ylabel("Temperature increase [oC]")
title('Fitting a model to predict temperature increase')

