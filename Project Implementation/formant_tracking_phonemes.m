%% Formant Tracking 
clear all;
close all;
clc;  
[y, Fs] = audioread('ba.wav');
%% with this we compare the formants given by LP

T=length(y)./Fs;            %Duration of sound file=Number of samples/Fs; Fs=8 KHz
t=10*10^(-3);           %Duration of each frame
f=(T/t);             %Number of frames
s=round(length(y)/f);   
%Number of samples per each frame

size(y);
d=y;
h=[];
k=1;
ou=[];

F=[];
%% this is for computing over all the frames
for j=1:s:(f*s)-(s-1)
    k=1;
    F2=[];
    %% this runs over many central frequencies with shift 
for freq=300:10:4000
    if(freq ~=4000)
        norm=(freq/(Fs));
    else
        norm=0.49848;
    end
sig = 9;
%% here the Bandwodth of the gabor filter is decided by sigma value
%% the order of the filter we have mentioned as 164
f5=Gabor1d_i(164,sig,norm,1);
h(k,:)=f5;
% freqz(f5);
% hold on;
ou(k,:)=conv(f5,d(j:j+s-1));
wo=norm*2*pi;
%% Here from each filter bank we will pass the signal into DESA block for
%% getting AM and FM components
[AMcom, FMcom] = DESA(ou(k,:),wo);
size(AMcom);
%% this computes the Spectral Moments
F2(k,1)=(sum((AMcom.^2).*FMcom)/sum(AMcom.^2))*(Fs/(2*pi));
k=k+1;

k;
end
F=horzcat(F,F2);
end
size(F);
%%plotting scatter plot
x_axis=1:1:size(F,2);
figure;
for row=1:1:size(F,1)-1
    rr=F(row,:);
    plot(x_axis,rr,':')
    hold on;
end
title('Pyknogram')
%imagesc((F))
%%% pruining of Pyknogram
pruned_final=[];
pruned_final2=[];
for coulmn=1:1:size(F,2)
    rr=F(:,coulmn);
    pru=[];
    pru2=[];
    %% this is pruning by threshold
    for row=1:1:size(F,1)-1
        if(((rr(row+1,1)-rr(row,1)))<15)
            pru(row,1)=rr(row,1);
            pru2(row,1)=rr(row,1);
        else
            pru(row,1)=NaN;
            pru2(row,1)=0;
        end
    end
    pruned_final=horzcat(pruned_final,pru);
    pruned_final2=horzcat(pruned_final2,pru2);
    
end
pruned_final;
%%Plotting the pruned pyknogram
figure;
 for row=1:1:size(pruned_final,1)
    rr2=pruned_final(row,:);
    
   plot(x_axis,rr2,':')
    hold on;
 end
title('Pruned Pyknogram with Formant Tracks') 
nc = 4;
%% 
dd=size(F,2);
mean_matrix=[];
cov_matrix=[];
mean_matrix2=[];
size(pruned_final2)
%% this is for intialization
for j=1:1:size(F,2)
    Y=pruned_final2(:,j);
    t=[];
    ll=1;
    %size(Y)
    for kk=1:1:size(Y,1)
        if(Y(kk,1)>300)
            t(ll)=Y(kk,1);
            ll=ll+1;
        end
    end

% size(t)
% size(Y)
% figure;
 values=t;
[idx,mu_intial] = kmeans(t,nc);
% pks = findpeaks(t)
mu_intial=sort(mu_intial)';
mean_matrix2=horzcat(mean_matrix2,mu_intial');
end
for i=1:1:4
    a=mean_matrix2(i,:);
    a=a'
    a=smooth(a)
    mean_matrix2(i,:)=a;
end
%% till here intialization will be done for mu values

for j=1:1:size(F,2)
    Y=pruned_final2(:,j);
    t=[];
    ll=1;
    %size(Y)
    for kk=1:1:size(Y,1)
        if(Y(kk,1)>300)
            t(ll)=Y(kk,1);
            ll=ll+1;
        end
    end
 values=t;
mu_intial=mean_matrix2(:,j)';
sigma_intial=[200 200 200 200]';
prior_intial=[0.25 0.25 0.25 0.25]';
% %%% Finding the estimated mus and estimated sigmas and also intialization
% %% 
v_intial=[10 10 10 10]';
%%% Finding the estimated mus and estimated sigmas and also intialization
%% 
C=4;
epsilon=1e-6;
[mu_est, sigma_est, p_est,v_est] = student_t_mixture(values, C,epsilon,mu_intial,sigma_intial,prior_intial,v_intial);
mean_matrix=horzcat(mean_matrix,mu_est');
%mu_est;
cov_matrix=horzcat(cov_matrix,sigma_est');
    
end
%% this corresponds to pruning after finding the means and formants
for i=1:1:4
    a=mean_matrix(i,:);
    a=a'
    a=smooth(a)
    mean_matrix(i,:)=a;
end
size(mean_matrix)
%pp=horzcat(pp,xp);
q=ones(1,size(mean_matrix,2))*1000;
size(q);
%% Plotting formant tracks of both reference and our approach
for row=1:1:size(mean_matrix,1)
    rr2=mean_matrix(row,:);
    plot(x_axis,rr2,'--rs')
    hold on;
   
    
end
mean_matrix(isnan(mean_matrix))=0;
legend('R-Mixture model approach')
B=mean_matrix';
x=0;
p=0;
%% computing the error at the end



    
    