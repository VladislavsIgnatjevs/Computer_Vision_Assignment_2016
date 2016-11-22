function out=colorFeat(input,tilesize,subsize)

%calculate ration
ratio=tilesize/subsize;

%resize and do rgb caclucation
resized=imresize(input,[tilesize tilesize]);
chunk=mat2cell(resized,repmat(subsize,[1 ratio]),repmat(subsize,[1 ratio]),3);
temp=double(zeros(ratio,ratio,3));
for i=1:1:ratio
    for j=1:1:ratio
        rgb=double(chunk{i,j});
        r=rgb(:,:,1);
        g=rgb(:,:,2);
        b=rgb(:,:,3);        
        temp(i,j,1)=mean2(r(:));
        temp(i,j,2)=mean2(g(:));
        temp(i,j,3)=mean2(b(:));
    end
end

%output
out=temp;
end