function [choose, k]=mosaic_main(w,h, numTiles, subtile, input_folder_path, imgClassification)%hausdorff

% tile size
tilesize=numTiles;

%size of sub tile
subsize=subtile;

%output height, width
outHeight=h;
outWidth=w

%calculate ratios
r=int8(tilesize/subsize)
ratioH=int32(outHeight/tilesize)
ratioW=int32(outWidth/tilesize)

temp=mosaic1(100,100, input_folder_path, imgClassification);

theSize=size(temp);
colorCell=cell(theSize(1),1);

%adjust images
for i=1:1:theSize(1);
    colorCell{i,1}=colorFeat(temp{i,1},tilesize,subsize);
end;
%%

%read target image
tar=imread(input_folder_path);
adjTar=imresize(tar,[outHeight outWidth]);
output=cell(ratioH,ratioW);
choose=zeros(ratioH,ratioW);
chunk=mat2cell(adjTar,repmat(tilesize,[1 ratioH]),repmat(tilesize,[1 ratioW]),3);

for i=1:1:ratioH
    i
    for j=1:1:ratioW
        
        c=zeros(theSize(1),2);
        comp1=colorFeat(chunk{i,j},tilesize,subsize);
        for m=1:1:theSize(1)
            diff=comp1-colorCell{m,1};
            
            z=sum(diff.^2);
            k=sum(z(:));
            
            c(m,1)=k;
            c(m,2)=m;
            
        end
        
        %sort the results
        sorted=sortrows(c);
        %get 20 smallest values
        minSorted=sorted(1:10,:);
        
        num=randi(10);
        
        %randomly pick one
        which2get=minSorted(num,:);
        get=temp{which2get(2),1};
        get=imresize(get,[tilesize tilesize]);
        get=rgb2hsv(get);
        origin=chunk{i,j};
        origin=rgb2hsv(origin);
        ratio=mean2(origin(:,:,3))/mean2(get(:,:,3));
        get(:,:,3)=get(:,:,3)*ratio;
        ratio2=mean2(origin(:,:,2))/mean2(get(:,:,2));
        get(:,:,2)=get(:,:,2)*ratio2;
        get=hsv2rgb(get);
        output{i,j}=get;
        choose(i,j)=which2get(2);
    end
end
orihsv=rgb2hsv(adjTar);
origin=hsv2rgb(orihsv);

theout=cell2mat(output);

k=theout*0.9+origin*0.1;

%assign to base for debug purposes
assignin('base','k',k);

%write image into output folder
output_folder = evalin('base','output_folder_path');
output_file = strcat(output_folder,'/output.jpg');

imwrite(k,output_file);
end
