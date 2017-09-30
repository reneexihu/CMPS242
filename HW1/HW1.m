## Octave script for HW1 Regression, CMPS 242 Machine Learning
## Written by Steven Reeves, UCSC, Applied Mathematics and Statistics
## Batu Aytemiz UCSC Computational Media 
## Xi Hu UCSC, Electrical Engineering
## September 09/29/2017_1

## This script uses the vandermonde function! And the train and test data
## files provided by Dr. Manfred K. Warmuth CS,UCSC

## Order of Vandermonde Matrix
order = 9; 

## strength of the penalty 
lnl = [-20:.1:0];
lambda = exp(lnl);  
## Mean square error
mse = zeros(size(lnl));

## Load Training Data
train = load('train.txt');
X = data_sort(train(:,1),train(:,2)); 
x_train = X(:,1);
t_train = X(:,2); 

parfor l = 1:length(lnl)
  ## random permutation for 10-fold cross validation
  idx = randperm(10,10);
  ## handle data
   x_tmp = reshape(x_train,10,2);
   t_tmp = reshape(t_train,10,2);
   error = zeros(10,1);
  
  #Leave one out 
  #idx = randperm(19,19);
  #error = zeros(19,1);
  
  for k = 1:10
  #for k = 1:19
    ## k partition of data set
    x_k = x_tmp;
    t_k = t_tmp;
    ## delete k-th row
    x_k(idx(k),:) = [];
    t_k(idx(k),:) = [];
    
    #x_k = x_train;
    #t_k = t_train;
    
    #delete k-th entry
    #x_k(idx(k)) = [];
    #t_k(idx(k)) = [];
    
    ## now use the 18 other points
    x_k = reshape(x_k,18,1);
    t_k = reshape(t_k,18,1);
    
    ## Create Vandermonde Matrix for Regression 
    V_k = vandermonde(x_k, order); 
    I = eye(order+1,order+1);
    
    ## find optimal weights
    temp = V_k*V_k' + lambda(l)*I;
    w = inverse(temp)*V_k*t_k; 

    ## construct polynomial for validation error
    f = zeros(size(x_tmp(idx(k),:)));
    #f = 0;
    for i = 1:order+1
      f += w(i)*x_tmp(idx(k),:).^(i-1); 
    #  f += w(i)*x_k(idx(k)).^(i-1); 
    end
    error(k) = (f(1) - t_tmp(idx(k),1))^2 + (f(2) - t_tmp(idx(k),2))^2;
#    error(k) = (f - t_k(idx(k)))^2;
  end
  mse(l) = mean(error);
end

figure(1)
plot(lnl,mse, 'linewidth', 2)
title(strcat("Order = ", num2str(order)),'fontsize',14);
xlabel('\lambda','fontsize',14)
ylabel('Mean Square Error','fontsize',14)
hold on
[minmse, loc] = min(mse);
minlam = exp(lnl(loc));
plot(lnl(loc), minmse,'markersize',20, 'r.')
legend('MSQE', 'Min')

disp(minlam)

## Now construct optimal polynomial 
## k partition of data set
x = x_train;
t = t_train;
## Create Vandermonde Matrix for Regression 
V = vandermonde(x, order); 
I = eye(order+1,order+1);
## find optimal weights
temp = V*V' + minlam*I;
w = inverse(temp)*V*t; 

## Load Test Data
test = load('test.txt');
x_test = test(:,1);
t_test = test(:,2);

## construct polynomial for test error
f = zeros(size(x_test)); 
for i = 1:order+1
  f += w(i)*x_test.^(i-1);
end  

figure(2)
plot(x_test,t_test,'b.','markersize',10)
hold on
XPLT = data_sort(x_test, f);
plot(XPLT(:,1),XPLT(:,2),'r','linewidth', 2)
xlabel("x_{test}",'fontsize', 14)
ylabel("Regression Curve and Test Data", 'fontsize',14)
legend('Test Set', 'Predicted Regression') 

## Do square error on test 
error = 0.0;
for i = 1:length(t_test)
  error += (f(i) - t_test(i))^2;
end  

error /= length(t_test);
disp(error)
