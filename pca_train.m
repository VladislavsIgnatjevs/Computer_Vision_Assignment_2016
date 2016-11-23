function X=pca_train(url)

cd(url); %url of train set
n=12; % number of features we want to obtain


cd('./out_manmade_1k_crop');
images=dir('*.jpg');
n1=length(images); 
for i=1:n1     %combine and reshape  
    temp_im=imread(images(i).name);
    temp_X1(i,:)=reshape(temp_im,1,[]);
end


cd('../out_natural_1k_crop');
images=dir('*.jpg');
n2=length(images);
for i=1:n2
    temp_im=imread(images(i).name);
    temp_X2(i,:)=reshape(temp_im,1,[]);
end


temp_X=[temp_X1;temp_X2];   %combine train se t
temp_X=double(temp_X);
[COEFF,SCORE,latent]=princomp(temp_X,'econ'); %use PCA
% cumsum(latent)./sum(latent)
coeff=COEFF(:,1:n);
cd('../../../');
save('coeff','coeff');
X=temp_X*coeff;
labels=[zeros(1,n1),ones(1,n2)];  %add label for trainning picture, 0 for manmade, 1 for natural
labels=labels.';
train=[X,labels];   %feature matrix for classifying
save('train','train');