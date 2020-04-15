%% this function is for intializing the means for formant tracks
%% based on the k means clustering
function mean_matrix=initialize_k(pruned_final2)
%Y : Data Points
%nc = 4
%th = 500Hz after frequency to point mapping
%min =0Hz
%max = 4000Hz
nc=4
mean_matrix=[]
for j=1:1:size(pruned_final2,2)
     Y=pruned_final2(:,j);
    [idx,mu_intial] = kmeans(Y,nc);
    mu_intial
    mean_matrix=horzcat(mean_matrix,mu_intial');
end


for i=1:1:4
    a=mean_matrix(i,:);
    a=a'
    a=smooth(a)
    mean_matrix(i,:)=a;
end
end


