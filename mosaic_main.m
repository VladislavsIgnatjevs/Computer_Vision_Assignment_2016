% function [choose, k]=mosaic_main()%hausdorff
function [choose, k]=mosaic_main(w,h, numTiles, subtile, input_folder_path, imgClassification)%hausdorff
% tilesize=40;
tilesize=numTiles;
subsize=subtile;%size of sub tile
outHeight=h;%output height
outWidth=w
r=int8(tilesize/subsize)
ratioH=int32(outHeight/tilesize)
ratioW=int32(outWidth/tilesize)
%temp=mosaic(100,100);
temp=mosaic1(100,100, input_folder_path, imgClassification);

theSize=size(temp);
colorCell=cell(theSize(1),1);
for i=1:1:theSize(1);
    colorCell{i,1}=colorFeat(temp{i,1},tilesize,subsize);
end;
%%
tar=imread(input_folder_path);%target image
% tar=imread('o-LA-TIMES-BUILDING-facebook.jpg');%target image
adjTar=imresize(tar,[outHeight outWidth]);
output=cell(ratioH,ratioW);
choose=zeros(ratioH,ratioW);
chunk=mat2cell(adjTar,repmat(tilesize,[1 ratioH]),repmat(tilesize,[1 ratioW]),3);
for i=1:1:ratioH
    i
    for j=1:1:ratioW
        j     
        c=zeros(theSize(1),2);
        comp1=colorFeat(chunk{i,j},tilesize,subsize);
        %comp2=chunk{i,j};
        for m=1:1:theSize(1)
            
            %comp1=imresize(temp{m,1},[tilesize tilesize]);
            diff=comp1-colorCell{m,1};
            %k=double(ones(4,1));
            %k=0;

                z=sum(diff.^2);
                k=sum(z(:));


            %c(m,1)=sqrt(k);
            c(m,1)=k;
            c(m,2)=m;
            %comhist1R=imhist(comp1(:,:,1),4);
            %comhist1G=imhist(comp1(:,:,2),4);
            %comhist1B=imhist(comp1(:,:,3),4);
            %comhist2R=imhist(comp2(:,:,1),4);
            %comhist2G=imhist(comp2(:,:,2),4);
            %comhist2B=imhist(comp2(:,:,3),4);
            %k2=(comhist1R-comhist2R).^2+(comhist1G-comhist2G).^2+(comhist1B-comhist2B).^2;
            %c(m,1)=sum(k2(:));
        end
        %[a,b]=min(c(:));
        sorted=sortrows(c);%sort the results
        minSorted=sorted(1:10,:);%get 20 smallest values
        %b=edgeFeat(chunk{i,j},tilesize);
        %h=zeros(20,2);
        %for z=1:1:20
        %    index=minSorted(z,2);
        %    a=edgeFeat(temp{index,1},tilesize);
        %    h(z,1)=hausdorff(a,b);
        %    h(z,2)=index;
        %end
        %sorted2=sortrows(h);
        %minSorted2=sorted2(1:10,:);
        num=randi(10);
        which2get=minSorted(num,:);%random pick one
        get=temp{which2get(2),1};
        get=imresize(get,[tilesize tilesize]);
        get=rgb2hsv(get);
        origin=chunk{i,j};
        origin=rgb2hsv(origin);
        ratio=mean2(origin(:,:,3))/mean2(get(:,:,3));
        get(:,:,3)=get(:,:,3)*ratio;
        ratio2=mean2(origin(:,:,2))/mean2(get(:,:,2));
        get(:,:,2)=get(:,:,2)*ratio2;

        %if which2get(1)>iter*6000
            %ratio3=mean2(origin(:,:,1))/mean2(get(:,:,1));
            %get(:,:,1)=get(:,:,1)*ratio3;
        %end
       % ratio3=mean2(origin(:,:,1))/mean2(get(:,:,1));
       % get(:,:,1)=get(:,:,1)*ratio3;
        get=hsv2rgb(get);
        output{i,j}=get;
        %output{i,j}=imresize(temp{b,1},[20 20]);
        choose(i,j)=which2get(2);
    end
end
orihsv=rgb2hsv(adjTar);
origin=hsv2rgb(orihsv);

theout=cell2mat(output);
k=theout;%*0.8+origin*0.2;
assignin('base','k',k);
output_folder = evalin('base','output_folder_path');
output_file = strcat(output_folder,'/output.jpg');

imwrite(k,output_file);
%k=uint8(double(adjTar)*0.5+half1*0.5);
end
