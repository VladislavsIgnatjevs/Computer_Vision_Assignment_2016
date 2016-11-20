function y=classify(target_pic)


height=100;
width=100;
gauss = fspecial('gaussian',10,3);
load('train_edge.mat','train_edge');
load('train_hist.mat','train_hist');
load('coeff_hist.mat','coeff_hist');
load('coeff_edge.mat','coeff_edge');
K1=19;
K2=394;
threshold=0.10;


temp_im=imread(target_pic);
%pre-processing for hist
[m,n]=size(temp_im(:,:,1));
size_im=m*n;
count_r=(imhist(temp_im(:,:,1)).*10000)./size_im;
count_g=(imhist(temp_im(:,:,2)).*10000)./size_im;
count_b=(imhist(temp_im(:,:,3)).*10000)./size_im;
temp_im_hist=[count_r.',count_g.',count_b.'];
temp_hist=temp_im_hist*coeff_hist;

%pre-processing for edge
temp_im_edge=imfilter(temp_im, gauss);
temp_im_edge=imresize(temp_im_edge, [height,width]);
temp_im_edge=edge(rgb2gray(temp_im_edge),'Sobel',threshold);
temp_edge=reshape(temp_im_edge,1,[]);
temp_edge=double(temp_edge);
temp_edge=temp_edge*coeff_edge;


%classification
[sum,row_length]=size(train_hist);
group_train=train_hist(:,row_length);
vector_length=row_length-1;
train_hist=train_hist(:,1:vector_length);
class1=knnclassify(temp_hist,train_hist,group_train,K1,'euclidean','random');


[sum,row_length]=size(train_edge);
group_train=train_edge(:,row_length);
vector_length=row_length-1;
train_edge=train_edge(:,1:vector_length);
class2=knnclassify(temp_edge,train_edge,group_train,K2,'euclidean','random');

if class1==0 && class2==0
    y=0;
else
    y=1;
end
