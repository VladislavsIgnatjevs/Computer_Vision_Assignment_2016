function y=classify(target_pic)
height=150;
width=150;
gauss = fspecial('gaussian',10,3);
load('coeff','coeff');
load('train','train');
K=10;


im=imread(target_pic);   %pre-processing
temp=imfilter(im, gauss);
temp=imresize(temp, [height,width]);
temp=reshape(temp,1,[]);
temp=double(temp);
temp=temp*coeff;


[~,row_length]=size(train);
train_matrix=train(:,1:row_length-1);
group_train=train(:,row_length);
class=knnclassify(temp,train_matrix,group_train,K,'cosine')