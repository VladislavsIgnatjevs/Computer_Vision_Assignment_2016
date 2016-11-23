function X=hist_pca_test(url)

load('coeff_hist','coeff_hist');
cd(url);   %url of test set


cd('./out_manmade_1k');
images=dir('*.jpg');
n1=length(images);
for i=1:n1
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


temp_X=[temp_X1;temp_X2];   %combine test set



X=temp_X*coeff_hist;
labels=[zeros(n1,1);ones(n2,1)]    %n1 for manmade, n2 for natural
test_hist=[X,labels];
cd('../../../');
save('test_hist','test_hist');