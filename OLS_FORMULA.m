function [beta_hat, SE_beta_hat, t_values, R2, adj_R2] = OLS_FORMULA(Y, X)
% Y = dependent
% X = independent

[T, K] = size(X); % # of independent variables
beta_hat = inv(X'*X)*X'*Y;  % (K X 1) #추정공식
Y_hat = X*beta_hat; % (T X 1) #fitted value
e_hat = Y - Y_hat; % (T X 1) #잔차항
sig2_hat = e_hat'*e_hat/(T - K); % (1 X 1) #표본분산

Var_beta_hat = sig2_hat*inv(X'*X); % (K X K) #beta_hat의 variance-covariance matrix
SE_beta_hat = sqrt(diag(Var_beta_hat)); % (K X 1) #표준편차 #beta_hat이 얼마나 불확실한가
t_values = beta_hat ./ SE_beta_hat; % (K X 1) #검정통계량

TSS = (Y - mean(Y))'*(Y - mean(Y));
RSS = e_hat'*e_hat;
R2 = 1 - RSS/TSS;
adj_R2 = 1 - (T-1)*RSS/(TSS*(T-K)); %모델의 설명력


disp('   beta hat  t values s.e.');
disp([beta_hat, t_values, SE_beta_hat]);
disp('adj_R2');
disp(adj_R2);

end