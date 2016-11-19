function [choose, k]=mosaic_main()%hausdorff¾àÀë
tilesize=40;
subsize=20;%size of sub tile
outHeight=1000;%output height
outWidth=2000;
r=int8(tilesize/subsize)
ratioH=int8(outHeight/tilesize)
ratioW=int8(outWidth/tilesize)
temp=mosaic(100,100);
theSize=size(temp);
colorCell=cell(theSize(1),1);
for i=1:1:theSize(1);
    colorCell{i,1}=colorFeat(temp{i,1},tilesize,subsize);
end;
%%
tar=imread('o-LA-TIMES-BUILDING-facebook.jpg');%target image
adjTar=imresize(tar,[outHeight outWidth]);
output=cell(ratioH,ratioW);
choose=zeros(ratioH,ratioW);
chunk=mat2cell(adjTar,repmat(tilesize,[1 ratioH]),repmat(tilesize,[1 ratioW]),3);
for i=1:1:ratioH
    for j=1:1:ratioW
        i
        j
        c=zeros(theSize(1),2);
        comp1=colorFeat(chunk{i,j},tilesize,subsize);
        for m=1:1:theSize(1)
            diff=comp1-colorCell{m,1};
            %k=double(ones(4,1));
            %k=0;
            z=sum(diff.^2);
            k=sum(z(:));
            %for x=1:1:r
            %    for y=1:1:r
            %        k=k+diff(x,y,1)^2+diff(x,y,2)^2+diff(x,y,3)^2;                    
                    %c(m,1)=abs(diff);
            %    end            
            %end 
            %k1=diff(1,1,1)^2+diff(1,1,2)^2+diff(1,1,3)^2;
            %k2=diff(1,2,1)^2+diff(1,2,2)^2+diff(1,2,3)^2;
            %k3=diff(2,1,1)^2+diff(2,1,2)^2+diff(2,1,3)^2;
            %k4=diff(2,2,1)^2+diff(2,2,2)^2+diff(2,2,3)^2;
            %ksquare=k.^2;
            %c(m,1)=sqrt(sum(ksquare(:)));
            %c(m,1)=sqrt(k1+k2+k3+k4);
            c(m,1)=sqrt(k);
            c(m,2)=m;
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
        get=hsv2rgb(get);
        output{i,j}=get;
        %output{i,j}=imresize(temp{b,1},[20 20]);
        choose(i,j)=which2get(2);
    end
end
k=cell2mat(output);
%k=uint8(double(adjTar)*0.5+half1*0.5);
end
