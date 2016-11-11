function out=mosiac(h,w)%import and adjust RGB images (rough version)
height=h;
width=w;   % pixels/tiles for both dimention
urlman='./Images/manmade_training';
urlnat='./Images/natural_training';
fileID1 = fopen('./Images/manmade_training/manmade_training.txt','r');
fileID2 = fopen('./Images/natural_training/natural_training.txt','r');
man=textscan(fileID1,'%s','delimiter','\n');
nat=textscan(fileID2,'%s','delimiter','\n');
man=man{1};
nat=nat{1};%get lists of filenames
cd(urlman);
num=length(man);%number of files of manmade, assume taking manmade images here
picCell=cell(num,1);
adjCell=cell(num,1);
for i=1:num%read all images into a cell array
    picCell{i,1}=imread(char(man(i)));
    gauss = fspecial('gaussian',10,3);
    temp=imfilter(picCell{i,1},gauss);
    %temp=imgaussfilt(picCell{i,1},3);
    adjCell{i,1}=imresize(temp, [height width]);  %do gaussian filtering and resizing
end
out=adjCell{1}
end