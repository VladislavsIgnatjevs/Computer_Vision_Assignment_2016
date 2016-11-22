function out=mosaic1(w,h, input_folder_path, imgClassification)%import and adjust RGB images (rough version)
height=h;
width=w; 


% pixels/tiles for both dimention
urlman='./Images/manmade_training';
urlnat='./Images/natural_training';
fileID1 = fopen('./Images/manmade_training/manmade_training.txt','r');
fileID2 = fopen('./Images/natural_training/natural_training.txt','r');
man=textscan(fileID1,'%s','delimiter','\n');
nat=textscan(fileID2,'%s','delimiter','\n');
man=man{1};
nat=nat{1};%get lists of filenames

%if 1 do naturalmade, elseif 0 do manmade
if imgClassification == 0
    target_array = man;
    target_path = urlman;
elseif imgClassification == 1
    target_array = nat;
    target_path = urlnat;
end    

cd(target_path);
num=length(target_array);%number of files of manmade, assume taking manmade images here
picCell=cell(num,1);
adjCell=cell(num,1);
for i=1:num%read all images into a cell array
    i
    picCell{i,1}=imread(char(target_array(i)));
    gauss = fspecial('gaussian',1,4);
    temp1=imresize(picCell{i,1},[height width]);
    %temp=imgaussfilt(picCell{i,1},3);
    %adjCell{i,1}=imresize(temp, [height width]);  %do gaussian filtering and resizing
    adjCell{i,1}=imfilter(temp1,gauss);
end
out=adjCell;
%assignin('base','out',out);
%tilesize = evalin('base','numTiles');
%subsize = w;

cd('../../');

end

