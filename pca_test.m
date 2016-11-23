function X=pca_test(url)

load('coeff.mat','coeff');
cd(url);   %url of test set


cd('./out_manmade_1k_crop');
images=dir('*.jpg');
n1=length(images);
for i=1:n1
    temp_im=imread(images(i).name);
    temp_X1(i,:)=reshape(temp_im,1,[]);
end
% temp_X1=double(temp_X1);
% [m,n]=size(temp_X1);
% for i=1:m                             
%     mean_n=mean(temp_X1,2);
%     for j=1:n
%         temp_X1(i,j)=temp_X1(i,j)-mean_n(i);
%     end
% end
cd('../out_natural_1k_crop');
images=dir('*.jpg');
n2=length(images);
for i=1:n2
    temp_im=imread(images(i).name);
    temp_X2(i,:)=reshape(temp_im,1,[]);
end


temp_X=[temp_X1;temp_X2];   %combine test set
temp_X=double(temp_X);



X=temp_X*coeff;
labels=[zeros(n1,1);ones(n2,1)]    %n1 for manmade, n2 for natural
test=[X,labels];
cd('../../../');
save('test','test');