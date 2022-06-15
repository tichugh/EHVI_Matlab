function EHVI = EHVI_2d(PF,r,mu,sigma)

    n = size(PF,1);
    S1 = [r(1),-inf];
    Send = [-inf,r(2)];
    [~,index] = sort(PF(:,2));
    S = PF(index,:);
    
    S = [S1;S;Send];
    
%     [~,index] = sort(PF_aug(:,2));
%     S = PF_aug(index,:);
    y1 = S(:,1); y2 = S(:,2);
    
   
    
    sum_total1 = 0;
    sum_total2 = 0;
    
    for i = 2:n+2
%         if i == n+2
%             display('lets check here');
%         end
        t = (y1(i) - mu(1))/sigma(1);
        if i==n+2
        sum_total1 = sum_total1 + 0;
        else
        sum_total1 = sum_total1 + (y1(i-1) - y1(i))*normcdf(t)*psi_cal(y2(i),y2(i),mu(2),sigma(2));
        end
        sum_total2 = sum_total2 + (psi_cal(y1(i-1),y1(i-1),mu(1),sigma(1)) - psi_cal(y1(i-1),y1(i),mu(1),sigma(1)))*psi_cal(y2(i),y2(i),mu(2),sigma(2));
    end
    
    EHVI = sum_total1 + sum_total2;
end

function int_value = psi_cal(a,b,mu,sigma)
    
    t = (b - mu)/sigma;
    int_value = sigma*normpdf(t) + (a - mu)*normcdf(t);

% 
    

end