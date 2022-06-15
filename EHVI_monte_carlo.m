function HV = EHVI_monte_carlo(PF,r,mu_vector,sigma_vector)

    addpath(genpath('Support_files_EHVI'));
    n = 10000;
    
    
    %% sample here with multivariate normal distribution 
    Sigma = diag(sigma_vector.^2);
    R = mvnrnd(mu_vector,Sigma,n); 
    
    %% calculate hypervolume of PF
    HV_PF = P_evaluate_hv('HV',PF,r);
    

    %% calculate hypervolume with R
    HV = zeros(size(R,1),1);
    for i = 1:size(R,1)
        PF1 = [PF;R(i,:)];
        non = P_sort(PF1,'first')==1;
        PF1 = PF1(non,:);
        HV(i,:) = P_evaluate_hv('HV',PF1,r) - HV_PF ;
    end 
    HV = sum(HV)/n;   
end