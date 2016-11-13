function out=dHasher(input)%input is original or scaled RGB image
resized=imresize(input,[8 9]);
gray=rgb2gray(resized);%grayscale
fingerprint=zeros(8,8)
for i=1:1:8
    for j=1:1:8
        if gray(i,j)>gray(i,j+1)
            fingerprint(i,j)=1;%generate a 8 by 8 binary matrix as fingerprint of the image
        end
    end
end
out=fingerprint;
end