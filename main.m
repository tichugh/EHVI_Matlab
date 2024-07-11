close all; clc; clear;

%% test 1
PF = [1,10;5,5;8,2;10,1];
r = [11,11];

mu = [4,4];
sigma = [0.5,0.3];

EHVI = EHVI_2d(PF,r,mu,sigma)

EHVI_monte_carlo = EHVI_monte_carlo(PF,r,mu,sigma)

%% Test 2
PF = dlmread('DTLZ2.2D.pf');

data = readtable('DTLZ2.2D.2.csv');
y1 = data.Var1;
y2 = data.Var2;

y1(1) = []; y2(1) = []; 


s1 = data.Var3;
s2 = data.Var3;

s1(1) = []; s2(1) = []; 


r1 = data.Var5;
r2 = data.Var6;

r1(1) = []; r2(1) = []; 



%%
y = [y1,y2];
s = [s1,s2];
ref_point = [r1,r2];
hvc = zeros(size(y,1),1); 
% hvc_me = zeros(size(y,1),1); 
for i = 1:size(y,1)
        hvc(i,:) = EHVI_2d(PF,ref_point(i,:),y(i,:),s(i,:));
%         hvc_me(i,:)=EHVI_monte_carlo(PF,ref_point(i,:),y(i,:),s(i,:));

end

hvc_me = csvread('hvc_mc_dtlz2_2d.csv'); % already estimated
min_hv = min([hvc;hvc_me]);
max_hv = max([hvc;hvc_me]);

figure;
scatter(hvc,hvc_me);
hold on;
plot([min_hv,max_hv],[min_hv,max_hv])
hold off;
xlabel('EHVI - Analytical')
ylabel('EHVI - MC')

