syms x1 x2 x3 x4 x5 x6
close all
global beta_coeff
%Load model data
%M = csvread('data.csv'); %30 sample dataset
M = csvread('data2.csv'); %80 sample dataset
N=length(M);
disp("Number of samples: "+N)

%Plot data to with respect to each x tocheck for any patterns
% scatter(M(:,1),M(:,8))
% figure()
% scatter(M(:,2),M(:,8))
% figure()
% scatter(M(:,3),M(:,8))
% figure()
% scatter(M(:,4),M(:,8))
% figure()
% scatter(M(:,5),M(:,8))
% figure()
% scatter(M(:,6),M(:,8))

%Shuffle dataset
seed=1;
rng(seed);                                 % MATLAB random seed 1
newInd = randperm(length(M));  % New index order for data set
M = M(newInd,:);
disp("Data shuffled with seed "+seed)

%Divide data and normalize (or don't, raw data gives better model, see Figure in report)
X=M(:,1:6)';
% [X, PSx]=mapstd(X);
Y=M(:,8)';
% [Y, PSy]=mapstd(Y);
X=X' ;
Y=Y';

%Divide train and test X an Y data (roughly 75% - 25%)
p=round(0.75*N);
Xtrain = X(1:p,:);
Xtest=X(p+1:N,:);
Ytrain = Y(1:p,:);
Ytest=Y(p+1:N,:);

%% Linear model
disp("=====Fitting linear model=====")
mdl = fitlm(Xtrain,Ytrain);
disp(mdl.Coefficients)
yp = predict(mdl,Xtrain); %Evaluate model
[lin_tr_r2 lin_tr_rmse] = rsquare(Ytrain,yp);
ypred = predict(mdl,Xtest); %Test model
[lin_tst_r2 lin_tst_rmse] = rsquare(Ytest,ypred);

disp("Linear model Training dataset R2: "+lin_tr_r2) 
disp("Linear model Test dataset R2: "+lin_tst_r2) 
%% Nonlinear model
w = warning ('off','all');
disp("====Fitting nonlinear model====")
%Model guess
modelfun=@(b,x) b(1).*x(:,2)+b(2).*x(:,3)+b(3).*x(:,2).^2+b(4).*x(:,3).^2+b(5).*x(:,4).^2+b(6).*x(:,5).^2+b(7)./x(:,1)+b(8)./x(:,2)+b(9)./x(:,4)+b(10)./x(:,5)+b(11)./x(:,6)+b(12).*x(:,1).*x(:,2)+b(13).*x(:,1).*x(:,3)+b(14).*x(:,1).*x(:,4)+b(15).*x(:,2).*x(:,3)+b(16).*x(:,4).*x(:,2)+b(17).*x(:,5).*x(:,2)+b(18).*x(:,3).*x(:,6);
beta0=zeros(18,1); %coefficients guess

%Fit nonlinear model
[beta_coeff,R,J,CovB,MSE,ErrorModelInfo] = nlinfit(Xtrain,Ytrain,modelfun,beta0);

%Evaluate model
yguess1=modelfun(beta_coeff, Xtrain);
[nln_tr_r2 nln_tr_rmse] = rsquare(Ytrain,yguess1);
%Test model
yguess2=modelfun(beta_coeff, Xtest);
[nln_tst_r2 nln_tst_rmse] = rsquare(Ytest,yguess2); 

%
%% Plot nonlinear model 
%evalute fit by inspection
fig=figure();

subplot(2,3,1);
scatter(Xtrain(:,1),Ytrain,'filled')
hold on
scatter(Xtrain(:,1),yguess1,'filled')
hold on
scatter(Xtest(:,1),Ytest)
hold on
scatter(Xtest(:,1),yguess2)
title('Rm')

subplot(2,3,2)
scatter(Xtrain(:,2),Ytrain,'filled')
hold on
scatter(Xtrain(:,2),yguess1,'filled')
hold on
scatter(Xtest(:,2),Ytest)
hold on
scatter(Xtest(:,2),yguess2)
title('Da')

subplot(2,3,3);
scatter(Xtrain(:,3),Ytrain,'filled')
hold on
scatter(Xtrain(:,3),yguess1,'filled')
hold on
scatter(Xtest(:,3),Ytest)
hold on
scatter(Xtest(:,3),yguess2)
title('Dc')

subplot(2,3,4);
scatter(Xtrain(:,4),Ytrain,'filled')
hold on
scatter(Xtrain(:,4),yguess1,'filled')
hold on
scatter(Xtest(:,4),Ytest)
hold on
scatter(Xtest(:,4),yguess2)
title('density')

subplot(2,3,5);
scatter(Xtrain(:,5),Ytrain,'filled')
hold on
scatter(Xtrain(:,5),yguess1,'filled')
hold on
scatter(Xtest(:,5),Ytest)
hold on
scatter(Xtest(:,5),yguess2)
title('k')

subplot(2,3,6);
scatter(Xtrain(:,6),Ytrain,'filled','DisplayName','Train data')
hold on
scatter(Xtrain(:,6),yguess1,'filled', 'DisplayName','Predicted data')
hold on
scatter(Xtest(:,6),Ytest,'DisplayName','Test data')
hold on
scatter(Xtest(:,6),yguess2, 'DisplayName','Predicted data')
title('Cc')
sgtitle('Plotted model prediction vs actual')
legend

disp("Nonlinear model Training dataset RMSE: "+nln_tr_rmse) 
disp("Nonlinear model Test dataset RMSE: "+nln_tst_rmse) 

%dlmwrite('models.csv',[N seed lin_tr_r2, lin_tst_r2, nln_tr_r2, nln_tst_r2],'delimiter',',','-append');
disp("Final model: ")
disp(modelfun(beta_coeff, [x1, x2, x3, x4, x5, x6]))