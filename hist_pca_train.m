function X=hist_pca_train(url)

cd(url); %url of train set
diam=13; % number of features want to obtain


cd('./out_manmade_1k');
images=dir('*.jpg');
n1=length(images); 
for i=1:n1     %combine and reshape  
    temp_im=imread(images(i).name);
    [m,n]=size(temp_im(:,:,1));
    size_im=m*n;
    count_r=(imhist(temp_im(:,:,1)).*10000)./size_im;
    count_g=(imhist(temp_im(:,:,2)).*10000)./size_im;
    count_b=(imhist(temp_im(:,:,3)).*10000)./size_im;     
    temp_X1(i,:)=[count_r.',count_g.',count_b.'];
end


cd('../out_natural_1k');  
images=dir('*.jpg');
n2=length(images);
for i=1:n2
    temp_im=imread(images(i).name);
    [m,n]=size(temp_im(:,:,1));
    size_im=m*n;
    count_r=(imhist(temp_im(:,:,1)).*10000)./size_im;
    count_g=(imhist(temp_im(:,:,2)).*10000)./size_im;
    count_b=(imhist(temp_im(:,:,3)).*10000)./size_im;
    temp_X2(i,:)=[count_r.',count_g.',count_b.'];
end


temp_X=[temp_X1;temp_X2];   %combine train se t
[COEFF,SCORE,latent]=princomp(temp_X,'econ'); %use PCA
cumsum(latent)./sum(latent)
coeff_hist=COEFF(:,1:diam);
cd('../../../');
save('coeff_hist','coeff_hist');
X=temp_X*coeff_hist;
labels=[zeros(1,n1),ones(1,n2)];  %add label for trainning picture, 0 for manmade, 1 for natural
labels=labels.';
train_hist=[X,labels];   %feature matrix for classifying
save('train_hist','train_hist');