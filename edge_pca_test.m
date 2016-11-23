function X=edge_pca_test(url)

load('coeff_edge','coeff_edge');
cd(url);   %url of test set
threshold=0.1;


cd('./out_manmade_1k_crop');
images=dir('*.jpg');
n1=length(images);
for i=1:n1
    temp_im=imread(images(i).name);
    temp_im=edge(rgb2gray(temp_im),'Sobel',threshold);
    temp_X1(i,:)=reshape(temp_im,1,[]);
end

cd('../out_natural_1k_crop');
images=dir('*.jpg');
n2=length(images);
for i=1:n2
    temp_im=imread(images(i).name);
    temp_im=edge(rgb2gray(temp_im),'Sobel',threshold);
    temp_X2(i,:)=reshape(temp_im,1,[]);
end


temp_X=[temp_X1;temp_X2];   %combine test set
temp_X=double(temp_X);



X=temp_X*coeff_edge;
labels=[zeros(n1,1);ones(n2,1)]    %n1 for manmade, n2 for natural
test_edge=[X,labels];
cd('../../../');
save('test_edge','test_edge');