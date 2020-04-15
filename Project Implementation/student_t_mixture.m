%% Student TMM model Expectation Maximization algorithm
%% Based on the Expressions given in Paper
function [mu_est, sigma_est, p_est,v_est] = student_t_mixture(values, C,epsilon,mu_est_i,sigma_est_i,p_est_i,v_est_i)

path(path, '/home/mroughan/src/matlab/NUMERICAL_ROUTINES/');
% get and check inputs
N = length(values);

% initialize
counter = 0;
mu_est=mu_est_i;
sigma_est=sigma_est_i;
p_est=p_est_i;
v_est= v_est_i;
difference = epsilon;
% now iterate
while (difference >= epsilon & counter < 25000)
  % [mu_est, sigma_est, p_est]
  
  % E step: soft classification of the values into one of the mixtures 
  for j=1:C
    class(j, :) = p_est(j) * norm_density_student(values, mu_est(j), sigma_est(j),v_est(j));
    %((values-ones(size(values)).*mu_est(j))./sigma_est(j))
    u_vector(j,:)= (v_est(j)+1)./((v_est(j)+(((values-ones(size(values)).*mu_est(j)).^2)./sigma_est(j))));
  end
  % normalize
  class = class ./ repmat(sum(class), C, 1);

  % M step: ML estimate the parameters of each class (i.e., p, mu, sigma)
  mu_est_old = mu_est;
  sigma_est_old = sigma_est;
  p_est_old = p_est;
  v_est_old=v_est;
  for j=1:C
    mu_est(j) = sum( class(j,:).*values.*u_vector(j,:) ) / sum(class(j,:).*u_vector(j,:));
    sigma_est(j) = sqrt( sum(class(j,:).*u_vector(j,:).*(values - mu_est(j)).^2) /  sum(class(j,:)) );
    p_est(j) = mean(class(j,:));
  end
  sum_v=0;
  vv=v_est_old(1,1);
  for j=1:C
      %sum_v=sum_v+sum(class(j,:).*((psi((vv+1)/2).*ones(size(values)))+)); 
      %size(log(2./(vv+((values-ones(size(values)).*mu_est(j))./sigma_est(j)))))
      %size((psi((vv+1)/2).*ones(size(values))))
      %values  %% 
      
      
      sum_v=sum_v+sum(class(j,:).*((psi((vv+1)/2).*ones(size(values)))+log(2./(vv+((((values-ones(size(values)).*mu_est(j)).^2)./sigma_est(j)))))-u_vector(j,:)));   
  end
  taux=-sum_v/N;
  counter;
  taux;
  v_est(1,1)=0.0416*(1+erf(0.659*log(2.1971/(taux+log(taux)-1))))+(2/(taux+log(taux)-1));
    %v_est= sum( class(j,:).*values.*u_vector(j,:) ) / sum(class(j,:));
  v_est=ones(C,1)*v_est(1,1);
  difference(counter+1) = sum(abs(mu_est_old - mu_est)) + ...
      sum(abs(sigma_est_old - sigma_est)) + ...
      sum(abs(p_est_old - p_est));
  

  
  counter = counter + 1;
end


