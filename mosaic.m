
% preprocess images.
% @param h (height)
% @param w (width)
% @param urlman (path to manmade training directory)
% @param urlman (path to natural training directory)
% @param pathManTraining (path to training file for manmade)
% @param pathNatTraining (path to training file for naturalmade

%import and adjust RGB images (rough version)
function out=mosaic(h,w,urlman, pathManTraining)

% pixels/tiles for both dimention
height=h;
width=w;

fileID1 = fopen(pathManTraining,'r');
man=textscan(fileID1,'%s','delimiter','\n');

% get lists of filenames
man=man{1};


%cd to folder with images
cd(urlman);

%number of files of manmade, assume taking manmade images here
num=length(man);
picCell=cell(num,1);
adjCell=cell(num,1);


%loop through all the images withing this folder
%and read all images into a cell array
for i=1:num
    picCell{i,1}=imread(char(man(i)));
    gauss = fspecial('gaussian',10,3);
    temp=imfilter(picCell{i,1},gauss);
    %do gaussian filtering and resizing
    adjCell{i,1}=imresize(temp, [height width]);
end
out=adjCell;
end
