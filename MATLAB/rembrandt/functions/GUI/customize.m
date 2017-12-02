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

% Last Modified by GUIDE v2.5 13-Nov-2017 21:37:21

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


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    set(handles.uipanel5, 'Visible', 'on');

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    set(handles.uipanel4, 'Visible', 'on');


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
            n = get(handles.popupmenu1, 'Value') - 1;
            for i = 1:n
                OUTPUT_FILENAME = strcat('manual_segment_',num2str(i),'.jpg');
                
                I = imread('image.jpg');
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
            n = get(handles.popupmenu1, 'Value') - 1;
            for i = 1:n
                L = imread(strcat('manual_segment_',num2str(i),'.jpg'));
                subplot(2,double(int32(n/2)),i);
                imshow(L);
            end


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    FILENAME = 'desert.bmp'
    if get(handles.checkbox1, 'Value') == 1
        
            % colored-intensity regions
            I = imread(FILENAME); % original colored image
            G2 = rgb2gray(I);
            G = medfilt2(G2);
            n = get(handles.popupmenu4, 'Value') - 1;
            L = get_range(n,1,255);
            O = zeros([size(I) n]);
            
            for i=(1:n)
                OUTPUT_FILENAME = strcat('manual_segment_3_intensity_segment_',num2str(i),'.jpg');
                
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
                
                imwrite(J, OUTPUT_FILENAME);
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
                OUTPUT_FILENAME = strcat('manual_segment_3_intensity_segment_',num2str(i),'.jpg');
                
                lower = L(i,1);
                upper = L(i,2);
                Seg = O(:,:,i);
                ind = find(G >=lower & G <upper);
                Seg(ind) = 1; 
                imwrite(medfilt2(Seg), OUTPUT_FILENAME);
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
                L = imread(strcat('manual_segment_3_intensity_segment_',num2str(i),'.jpg'));
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
        set(handles.pushbutton11, 'Enable', 'off');
    else
        set(handles.pushbutton10, 'Enable', 'on');
        set(handles.pushbutton11, 'Enable', 'on');
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


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    set(handles.uipanel4, 'Visible', 'off');


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

    if get(handles.popupmenu4, 'Value') == 1
        set(handles.pushbutton10, 'Enable', 'off');
        set(handles.pushbutton11, 'Enable', 'off');
    else
        set(handles.pushbutton10, 'Enable', 'on');
        set(handles.pushbutton11, 'Enable', 'on');
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

% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2
