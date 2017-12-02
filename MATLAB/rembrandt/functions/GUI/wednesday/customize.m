function varargout = customize(varargin)
% CUSTOMIZE MATLAB code for customize.fig
%      CUSTOMIZE, by itself, creates a new CUSTOMIZE or raises the existing
%      singleton*.
%
%      H = CUSTOMIZE returns the handle to a new CUSTOMIZE or the handle to
%      the existing singleton*.
%
%      CUSTOMIZE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CUSTOMIZE.M with the given input arguments.
%
%      CUSTOMIZE('Property','Value',...) creates a new CUSTOMIZE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before customize_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to customize_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help customize

% Last Modified by GUIDE v2.5 15-Nov-2017 05:25:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @customize_OpeningFcn, ...
                   'gui_OutputFcn',  @customize_OutputFcn, ...
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


% --- Executes just before customize is made visible.
function customize_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to customize (see VARARGIN)

% Choose default command line output for customize
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes customize wait for user response (see UIRESUME)
% uiwait(handles.figure1);
Img = imread('desert.bmp');
axes(handles.axes1);
set(handles.axes1, 'Visible', 'on');
imshow(Img);


% --- Outputs from this function are returned to the command line.
function varargout = customize_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1

    if get(handles.popupmenu1, 'Value') == 1
        set(handles.pushbutton6, 'Enable', 'off');
        set(handles.pushbutton7, 'Enable', 'off');
    else
        set(handles.pushbutton6, 'Enable', 'on');
        set(handles.pushbutton7, 'Enable', 'on');
    end

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    set(handles.uipanel2, 'Visible', 'on');
    set(handles.uipanel5, 'Visible', 'off');
    set(handles.uipanel4, 'Visible', 'off');
    set(handles.pushbutton19, 'Enable', 'off');
    
% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    set(handles.uipanel5, 'Visible', 'on');
    set(handles.uipanel2, 'Visible', 'off');
    set(handles.uipanel4, 'Visible', 'off');
    set(handles.pushbutton19, 'Enable', 'off');
    set(handles.pushbutton2, 'Enable', 'off');

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    set(handles.uipanel4, 'Visible', 'on');
    set(handles.uipanel5, 'Visible', 'off');
    set(handles.uipanel2, 'Visible', 'off');    
    set(handles.pushbutton19, 'Enable', 'off');
    set(handles.pushbutton2, 'Enable', 'off');

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
            n = get(handles.popupmenu1, 'Value') - 1;
            if exist('image_preprocessed.jpg')
                FILENAME = 'image_preprocessed.jpg';
            else
                FILENAME = 'desert.bmp';
            end
            for i = 1:n
                OUTPUT_FILENAME = strcat('manual_segment_',num2str(i),'.jpg');
                
                I = imread(FILENAME);
                figure;
                [BW ,xi,yi] = roipoly(I);
                
                I2 = I;
                BW_i = find(BW~=1);
                BW_i = BW_i.';
                
                R = I2(:,:,1);
                G = I2(:,:,2);
                B = I2(:,:,3);
                
                R(BW_i)=0;
                G(BW_i)=0;
                B(BW_i)=0;
                
                I2(:,:,1) = R;
                I2(:,:,2) = G;
                I2(:,:,3) = B;
                
                imwrite(I2,OUTPUT_FILENAME);
                close
            end

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
            figure;
            checkboxes(1) = handles.checkbox3;
            checkboxes(2) = handles.checkbox4;
            checkboxes(3) = handles.checkbox5;
            checkboxes(4) = handles.checkbox6;
            checkboxes(5) = handles.checkbox7;
            checkboxes(6) = handles.checkbox8;
            n = get(handles.popupmenu1, 'Value') - 1;
            for i = 1:n
                L = imread(strcat('manual_segment_',num2str(i),'.jpg'));
                subplot(double(int32(n/2)),2,i);
                imshow(L);
                title(strcat('Region ',num2str(i)));
            end
            for i = 1:n
                set(checkboxes(i), 'Visible', 'on');
            end
            set(handles.pushbutton26, 'Enable', 'on');
% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    if exist('Manual_to_process.jpg')
        FILENAME = 'Manual_to_process.jpg';
    elseif exist('image_preprocessed.jpg')
        FILENAME = 'image_preprocessed.jpg';
    else
        FILENAME = 'desert.bmp';
    end
        
    num = str2double(get(handles.text12, 'string'));
    if get(handles.checkbox1, 'Value') == 1
        
            % colored-intensity regions
            I = imread(FILENAME); % original colored image
            G2 = rgb2gray(I);
            G = medfilt2(G2);
            n = get(handles.popupmenu4, 'Value') - 1;
            L = get_range(n,1,255);
            O = zeros([size(I) n]);
            
            for i=(1:n)
                
                lower = L(i,1);
                upper = L(i,2);
                Seg = O(:,:,i);
                ind = find(G >=lower & G <upper);
                Seg(ind) = 1; 
                J = I;
                J1 = J(:,:,1);
                J2 = J(:,:,2);
                J3 = J(:,:,3);

                J1(Seg~=1) = 0;
                J2(Seg~=1) = 0;
                J3(Seg~=1) = 0;

                J(:,:,1) = J1;
                J(:,:,2) = J2;
                J(:,:,3) = J3;
                
                imwrite(J, (strcat('Intensity_',num2str(i),'.jpg')));
                
            end
            figure;
            for i = 1:n
                L = imread((strcat('Intensity_',num2str(i),'.jpg')));
                subplot(2,double(int32(n/2)),i);
                imshow(L);
            end
    else
            % normal bw intensity regions
            
        I = imread(FILENAME);
            G2 = rgb2gray(I);
            G = medfilt2(G2);
            n = get(handles.popupmenu4, 'Value') - 1;
            L = get_range(n,1,255);
            O = zeros([size(I) n]);

            for i=(1:n)
                
                lower = L(i,1);
                upper = L(i,2);
                Seg = O(:,:,i);
                ind = find(G >=lower & G <upper);
                Seg(ind) = 1; 
                imwrite(medfilt2(Seg), strcat('Intensity_',num2str(i),'.jpg'));
            end
            figure;
            for i = 1:n
                L = imread(strcat('Intensity_',num2str(i),'.jpg'));
                subplot(2,double(int32(n/2)),i);
                imshow(L);
            end
            
    end

% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
            figure;
            n = get(handles.popupmenu4, 'Value') - 1;
            for i = 1:n
                L = imread(strcat('Final_',num2str(i),'.jpg'));
                subplot(2,double(int32(n/2)),i);
                imshow(L);
            end

% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4

    if get(handles.popupmenu4, 'Value') == 1
        set(handles.pushbutton10, 'Enable', 'off');
    else
        set(handles.pushbutton10, 'Enable', 'on');
    end

% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    set(handles.uipanel2, 'Visible', 'off');
    set(handles.uipanel1, 'Visible', 'on');

% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    set(handles.uipanel4, 'Visible', 'off');
    set(handles.uipanel1, 'Visible', 'on');
    n = get(handles.popupmenu4, 'Value') - 1;
    num = str2double(get(handles.text12, 'string'));
               
    for i = 1:n
        L = imread(strcat('Intensity_',num2str(i),'.jpg'));
        imwrite(L, strcat('Final_',num2str(i+num),'.jpg'));
    end

    num = num+n;
    set(handles.text12, 'string', int2str(num));
% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
        if exist('Manual_to_process.jpg')
            FILENAME = 'Manual_to_process.jpg';
        elseif exist('image_preprocessed.jpg')
            FILENAME = 'image_preprocessed.jpg';
        else
            FILENAME = 'desert.bmp';
        end
            
    I = imread(FILENAME);
    n = get(handles.popupmenu5, 'Value') - 1;
    L = lab_segmentation(n,I);
    num = str2double(get(handles.text12, 'string'));
    for i = 1:n
        imwrite(L(:,:,:,i), strcat('Lab_',num2str(i),'.jpg'))
    end
    figure;
    for i = 1:n
        L = imread(strcat('Lab_',num2str(i),'.jpg'));
        subplot(2,double(int32(n/2)),i);
        imshow(L);
    end

    
% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu5

    if get(handles.popupmenu5, 'Value') == 1
        set(handles.pushbutton14, 'Enable', 'off');
    else
        set(handles.pushbutton14, 'Enable', 'on');
    end

% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    set(handles.uipanel5, 'Visible', 'off');
    set(handles.uipanel1, 'Visible', 'on');
    n = get(handles.popupmenu5, 'Value') - 1;
    num = str2double(get(handles.text12, 'string'));
    for i = 1:n
        L = imread(strcat('Lab_',num2str(i),'.jpg'));
        imwrite(L, strcat('Final_',num2str(i+num),'.jpg'));
    end
    num = num+n;
    set(handles.text12, 'string', int2str(num));
% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    close


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    run('preprocessing.mlapp')


% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes3

% --- Executes during object deletion, before destroying properties.
function axes3_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over axes background.
function axes3_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in pushbutton25.
function pushbutton25_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
New = imread('image_preprocessed.jpg');
axes(handles.axes3);
imshow(New);


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3


% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4


% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox5


% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox6


% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox7


% --- Executes on button press in checkbox8.
function checkbox8_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox8


% --- Executes on button press in pushbutton26.
function pushbutton26_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
num = 0;
checkboxes(1) = handles.checkbox3;
checkboxes(2) = handles.checkbox4;
checkboxes(3) = handles.checkbox5;
checkboxes(4) = handles.checkbox6;
checkboxes(5) = handles.checkbox7;
checkboxes(6) = handles.checkbox8;
n = get(handles.popupmenu1, 'Value') - 1;

for i = 1:n
    if get(checkboxes(i), 'value') == 1
        num = num+1;
        L = imread(strcat('manual_segment_',num2str(i),'.jpg'));
        imwrite(L, strcat('Final_',num2str(num),'.jpg'))
    end
end
set(handles.text12, 'string', int2str(num));
set(handles.text9, 'string', num2str(n-num));
set(handles.text10, 'string', num2str(n-num));
set(handles.text11, 'string', num2str(1));
set(handles.pushbutton29, 'visible', 'on');
set(handles.pushbutton30, 'visible', 'on');
if (n-num)>1
    set(handles.pushbutton30, 'enable', 'on');
end
for j = 1:n
    if get(checkboxes(j), 'value') ~= 1
        Man = imread(strcat('manual_segment_',num2str(j),'.jpg'));
        axes(handles.axes1);
        imshow(Man);
        imwrite(Man, 'Manual_to_process.jpg')
        break;
    end
end
set(handles.text7, 'string', 'Manual');

% --- Executes on button press in pushbutton28.
function pushbutton28_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    set(handles.pushbutton19, 'Enable', 'on');
    set(handles.pushbutton2, 'Enable', 'on');
    Img = imread('desert.bmp');
    axes(handles.axes1);
    imshow(Img);
    axes(handles.axes3);
    imshow(1);
    set(handles.text12, 'string', int2str(0));
    set(handles.text7, 'string', 'Original');
    checkboxes(1) = handles.checkbox3;
    checkboxes(2) = handles.checkbox4;
    checkboxes(3) = handles.checkbox5;
    checkboxes(4) = handles.checkbox6;
    checkboxes(5) = handles.checkbox7;
    checkboxes(6) = handles.checkbox8;
    for i = 1:6
        set(checkboxes(i), 'Visible', 'off');
    end
    set(handles.pushbutton29, 'visible', 'off');
    set(handles.pushbutton30, 'visible', 'off');

% --- Executes on button press in pushbutton29.
function pushbutton29_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
checkboxes(1) = handles.checkbox3;
checkboxes(2) = handles.checkbox4;
checkboxes(3) = handles.checkbox5;
checkboxes(4) = handles.checkbox6;
checkboxes(5) = handles.checkbox7;
checkboxes(6) = handles.checkbox8;
n = get(handles.popupmenu1, 'Value') - 1;
all = str2double(get(handles.text9, 'string'));
mini = str2double(get(handles.text10, 'string'));
maxi = str2double(get(handles.text11, 'string'));
maxi=maxi-1;
mini=mini+1;
if mini == all
    set(handles.pushbutton29, 'enable', 'off')
end
if maxi < all
    set(handles.pushbutton30, 'enable', 'on')
end

set(handles.text10, 'string', num2str(mini));
set(handles.text11, 'string', num2str(maxi));
k = str2double(get(handles.text11, 'string'));
for i = 1:n
    if get(checkboxes(i), 'value') ~= 1
        Man = imread(strcat('manual_segment_',num2str(i+k-1),'.jpg'));
        axes(handles.axes1);
        imshow(Man);
        imwrite(Man, 'Manual_to_process.jpg')

        break
    end
end

% --- Executes on button press in pushbutton30.
function pushbutton30_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
checkboxes(1) = handles.checkbox3;
checkboxes(2) = handles.checkbox4;
checkboxes(3) = handles.checkbox5;
checkboxes(4) = handles.checkbox6;
checkboxes(5) = handles.checkbox7;
checkboxes(6) = handles.checkbox8;
n = get(handles.popupmenu1, 'Value') - 1;
all = str2double(get(handles.text9, 'string'));
mini = str2double(get(handles.text10, 'string'));
maxi = str2double(get(handles.text11, 'string'));
maxi=maxi+1;
mini=mini-1;
if maxi == all
    set(handles.pushbutton30, 'enable', 'off')
end
if mini < all 
    set(handles.pushbutton29, 'enable', 'on')
end

set(handles.text10, 'string', num2str(mini));
set(handles.text11, 'string', num2str(maxi));
k = str2double(get(handles.text11, 'string'));
for i = 1:n
    if get(checkboxes(i), 'value') ~= 1
        Man = imread(strcat('manual_segment_',num2str(i+k-1),'.jpg'));
        axes(handles.axes1);
        imshow(Man);
        imwrite(Man, 'Manual_to_process.jpg')

        break
    end
end


% --- Executes on button press in pushbutton31.
function pushbutton31_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    num = str2double(get(handles.text12, 'string'));
    figure;

    for i=1:num
        if exist(strcat('Final_', int2str(i), '.jpg'))
            L = imread(strcat('Final_', int2str(i), '.jpg'));
            subplot(1,num,i);
            imshow(L);
        else
            break
        end
    end
