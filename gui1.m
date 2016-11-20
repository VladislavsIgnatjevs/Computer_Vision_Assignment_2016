
function varargout = gui1(varargin)

% GUI1 MATLAB code for gui1.fig
%      GUI1, by itself, creates a new GUI1 or raises the existing
%      singleton*.
%
%      H = GUI1 returns the handle to a new GUI1 or the handle to
%      the existing singleton*.
%
%      GUI1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI1.M with the given input arguments.
%
%      GUI1('Property','Value',...) creates a new GUI1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui1

% Last Modified by GUIDE v2.5 20-Nov-2016 00:53:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @gui1_OpeningFcn, ...
    'gui_OutputFcn',  @gui1_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before gui1 is made visible.
function gui1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui1 (see VARARGIN)

% Choose default command line output for gui1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui1_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


global err numTiles numPixelsWidth numPixelsHeight generateButton output_folder_path InputFileName InputPathName input_training_path InputFilterIndex input_training_path TrainingFileName



% --- Executes on button press in generateButton.
function generateButton_Callback(hObject, eventdata, handles)
% hObject    handle to generateButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
err = 0;

%numTiles get, set and add to globals
numTiles = get(handles.numTiles,'String');
set(handles.numTiles,'String',numTiles);
assignin('base','numTiles',numTiles)

%numPixelsWidth/numPixelsHeight get, set and add to globals
numPixelsWidth = get(handles.numPixelsWidth,'String');
numPixelsHeight = get(handles.numPixelsHeight,'String');

assignin('base','numPixelsWidth',numPixelsWidth)
set(handles.numPixelsWidth,'String',numPixelsWidth);

assignin('base','numPixelsHeight',numPixelsHeight)
set(handles.numPixelsHeight,'String',numPixelsHeight);

%throw error if empty directory path since path cannot be empty
%check if files were inputed or folder specified
if isempty(get(handles.imgPath,'String'))
    err = 1;
    uiwait(msgbox('Input folder path cannot be empty', 'Error'));
end

% %check if path to training file is specified
% if isempty(get(handles.pathToTraining,'String'))
%     err = 1;
%     uiwait(msgbox('Path to training file cannot be empty', 'Error'));
% end

%check if output folder was specified
if isempty(get(handles.targetPath,'String'))
    uiwait(msgbox('Output folder path cannot be empty', 'Error'));
    err = 1;
end

%pass error var to workspace
assignin('base','err',err);

%break if any errors
if err == 1;
 % clear err generateButton input_folder_path InputFileName InputFilterIndex InputPathName numPixelsWidth numTiles output_folder_path source_imgs_dir_path target_imgs_dir_path
  close all; 
   
else 
   
    %disable input fields
    set(handles.targetPath, 'Enable', 'off');
    set(handles.imgPath, 'Enable', 'off');
%     set(handles.pathToTraining, 'Enable', 'off');
    
    %collect the rest of vars from the base workspace
    input_folder_path = evalin('base', 'input_folder_path');
%     input_training_path =  evalin('base', 'input_training_path');
    output_folder_path = evalin('base', 'output_folder_path');
    InputFileName = evalin('base', 'InputFileName');
    
  %  msgbox(err);
 imgClassification =classify(input_folder_path);
 %0 for nature, 1 for manmade
  out=mosaic1(str2num(numPixelsWidth), str2num(numPixelsHeight), str2num(numTiles), input_folder_path, imgClassification);
  %prepareEnvironment(input_folder_path, output_folder_path, InputFileName, numPixelsWidth,numTiles);
end


function numPixelsWidth_Callback(hObject, eventdata, handles)
% hObject    handle to numPixelsWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numPixelsWidth as text
%        str2double(get(hObject,'String')) returns contents of numPixelsWidth as a double


% --- Executes during object creation, after setting all properties.
function numPixelsWidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numPixelsWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function numTiles_Callback(hObject, eventdata, handles)
% hObject    handle to numTiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numTiles as text
%        str2double(get(hObject,'String')) returns contents of numTiles as a double


% --- Executes during object creation, after setting all properties.
function numTiles_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numTiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function targetPath_Callback(hObject, eventdata, handles)
% hObject    handle to targetPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of targetPath as text
%        str2double(get(hObject,'String')) returns contents of targetPath as a double
%output filenames and path



% --- Executes during object creation, after setting all properties.
function targetPath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to targetPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function imgPath_Callback(hObject, eventdata, handles)
% hObject    handle to imgPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of imgPath as text
%        str2double(get(hObject,'String')) returns contents of imgPath as a double






% --- Executes during object creation, after setting all properties.
function imgPath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imgPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over imgPath.

function imgPath_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to imgPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%user dialog for selecting input folder or files


% choice = questdlg('Would like to select files or whole folder?', ...
%     'Select how images will be imported', ...
%     'Select Images','Select Folder','Cancel');
% 
% % response
% switch choice
%     case 'Select Images'
        
        %input filenames and path 
        
        %fix so images added in column not in row
%         [InputFileName,input_folder_path] = uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
% },'MultiSelect','on');
%         
%         set(handles.imgPath,'String',input_folder_path);
%         
%         %assign to global vars
%         assignin('base','InputFileName',InputFileName);
%         assignin('base','input_folder_path',input_folder_path);
        %assignin('base','InputFilterIndex',InputFilterIndex);
        
%     case 'Select Folder'
%         


        %select folder
%         input_folder_path = uigetdir;
%         set(handles.imgPath,'String',input_folder_path);
%         assignin('base','input_folder_path',input_folder_path);

[InputFileName,input_folder_path] = uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
 },'MultiSelect','off');

targetImageFullPath = strcat(input_folder_path,InputFileName);
set(handles.imgPath,'String',targetImageFullPath);
assignin('base','input_folder_path',targetImageFullPath);
        
        
%     case 'Cancel'
% end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over targetPath.
function targetPath_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to targetPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
output_folder_path = uigetdir;
set(handles.targetPath,'String',output_folder_path);
assignin('base','output_folder_path',output_folder_path);





function numPixelsHeight_Callback(hObject, eventdata, handles)
% hObject    handle to numPixelsHeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numPixelsHeight as text
%        str2double(get(hObject,'String')) returns contents of numPixelsHeight as a double


% --- Executes during object creation, after setting all properties.
function numPixelsHeight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numPixelsHeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
