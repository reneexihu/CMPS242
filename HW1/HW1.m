## Octave script for HW1 Regression, CMPS 242 Machine Learning
## Written by Steven Reeves, UCSC, Applied Mathematics and Statistics
## Batu Aytemiz UCSC Computational Media 
## Xi Hu UCSC, Something
## September 09/29/2017

## This script uses the vandermonde function! And the train and test data
## files provided by Dr. Manfred K. Warmuth CS,UCSC

## Order of Vandermonde Matrix
order = 10; 

## strength of the penalty 
lnl = [-30:0.1:0];
lambda = exp(lnl);  
## Mean square error
mse = zeros(size(lnl));

## Load Training Data
train = load('train.txt');
X = data_sort(train(:,1),train(:,2)); 
x_train = X(:,1);
t_train = X(:,2); 

parfor l = 1:length(lnl)
  ## random permutation for k-fold cross validation
  idx = randperm(10,10);
  ## handle data
  x_tmp = reshape(x_train,10,2);
  t_tmp = reshape(t_train,10,2);
  error = zeros(10,1);
  for k = 1:10
    ## k partition of data set
    x_k = x_tmp;
    t_k = t_tmp;
    ## delete k-th row
    x_k(idx(k),:) = [];
    t_k(idx(k),:) = [];
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
    for i = 1:order+1
      f = f + w(i)*x_tmp(idx(k),:).^(i-1); 
    end
    error(k) = (f(1) - t_tmp(idx(k),1))^2 + (f(2) - t_tmp(idx(k),2))^2;
  end
  mse(l) = mean(error);
end

plot(lnl,log(mse), 'linewidth', 2)
xlabel('lambda','fontsize',14)
ylabel('Log Mean Square Error','fontsize',14)
[minmse, loc] = min(mse)
minlam = exp(lnl(loc))
## Load Test Data
test = load('test.txt');
x_test = test(:,1);
t_test = test(:,2);