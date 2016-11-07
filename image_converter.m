%Computer vision assignment 
%convert images to matrices in a loop

clear all
%when generate button pressed get images source and write path

 source_imgs_dir_path = '';
 target_imgs_dir_path = '';
 
global numTiles numPixels generateButton output_folder_path InputFileName InputPathName InputFilterIndex input_folder_path
gui1;




     
     

 
     

     
if generateButton == 1
    source_imgs_dir_path = imgPath;
    target_imgs_dir_path = targetPath;


%add to path enviroment if not empty
if (~isempty(source_imgs_dir_path) ) && (~isempty(target_imgs_dir_path))
  
    
    setenv('SOURCE_IMGS_DIR', source_imgs_dir_path);
    getenv('SOURCE_IMGS_DIR');

    setenv('TARGET_IMGS_DIR', target_imgs_dir_path);
    getenv('SOURCE_IMGS_DIR');
    
    
 

    
    

end

%image_test = imread('Images\out_manmade_1k\sun_aaasertfihkcjvdd.jpg');