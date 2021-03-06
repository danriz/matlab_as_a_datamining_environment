function varargout = Run_Matlab_Command(varargin)
% RUN_MATLAB_COMMAND M-file for Run_Matlab_Command.fig
%      RUN_MATLAB_COMMAND, by itself, creates a new RUN_MATLAB_COMMAND or raises the existing
%      singleton*.
%
%      H = RUN_MATLAB_COMMAND returns the handle to a new RUN_MATLAB_COMMAND or the handle to
%      the existing singleton*.
%
%      RUN_MATLAB_COMMAND('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RUN_MATLAB_COMMAND.M with the given input arguments.
%
%      RUN_MATLAB_COMMAND('Property','Value',...) creates a new RUN_MATLAB_COMMAND or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Run_Matlab_Command_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Run_Matlab_Command_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Run_Matlab_Command

% Last Modified by GUIDE v2.5 08-Jun-2007 08:34:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Run_Matlab_Command_OpeningFcn, ...
                   'gui_OutputFcn',  @Run_Matlab_Command_OutputFcn, ...
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


% --- Executes just before Run_Matlab_Command is made visible.
function Run_Matlab_Command_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Run_Matlab_Command (see VARARGIN)

% Choose default command line output for Run_Matlab_Command
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Run_Matlab_Command wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global myhistory
set(handles.listbox1,'String',myhistory);


% --- Outputs from this function are returned to the command line.
function varargout = Run_Matlab_Command_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
entered=get(hObject, 'String');
handles.entered = entered;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%myhistory=['abc']
%ee=size(myhistory)
%evalin('base','history[1,:]')
% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%global myhistory
global countlist
global runit
global temp
global myhistory
runit=handles.entered
evalin('base', runit);
runit(1,1)
[o,p]=size(runit)

for bb=1:p
    ll=int2str(bb)
temp=runit(1,bb)
myhistory(countlist,bb)= temp

%myhistory(countlist,bb)= temp
end


set(handles.listbox1,'String',myhistory);
set(handles.edit1,'String','');
countlist=countlist+1

% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1
global myhistory
new_hist_val=get(hObject, 'Value');
handles.new_hist_val = new_hist_val

guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global myhistory
order=handles.new_hist_val
send_to_command=myhistory(order,:)
set(handles.edit1,'String',send_to_command);
