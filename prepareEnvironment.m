% prepares environment and converts files to matrices
function prepareEnvironment(inputPath, outputPath, fileNameArray, numPixels, numTiles)

%add to path enviroment if not empty

global inputFiles outputFolder Image

% check if io paths are not empty
if (~isempty(inputPath) ) && (~isempty(outputPath))
    
    % get all images file names in the folder if no image files were added 
    if isempty(fileNameArray)
        fileNameArray = dir([inputPath '/*.jpg']);
    end
    
    %convert every image in filename array to matrix
    for k = 1:length(fileNameArray)
        img_filename = [inputPath '/' fileNameArray(k).name];
        Image = [Image,imread(img_filename)];
    end
    assignin('base','Image',Image);
    
    % assign image file names globally
    assignin('base','fileNameArray',fileNameArray);
    
    % prepare output folder
    outputFolder = dir(outputPath);
    assignin('base','outputFolder',outputFolder);
    
end




end