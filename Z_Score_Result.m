function varargout = Z_Score_Result(varargin)
% Z_SCORE_RESULT M-file for Z_Score_Result.fig
%      Z_SCORE_RESULT, by itself, creates a new Z_SCORE_RESULT or raises the existing
%      singleton*.
%
%      H = Z_SCORE_RESULT returns the handle to a new Z_SCORE_RESULT or the handle to
%      the existing singleton*.
%
%      Z_SCORE_RESULT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in Z_SCORE_RESULT.M with the given input arguments.
%
%      Z_SCORE_RESULT('Property','Value',...) creates a new Z_SCORE_RESULT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Z_Score_Result_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Z_Score_Result_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Z_Score_Result

% Last Modified by GUIDE v2.5 13-Jun-2007 19:42:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Z_Score_Result_OpeningFcn, ...
                   'gui_OutputFcn',  @Z_Score_Result_OutputFcn, ...
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


% --- Executes just before Z_Score_Result is made visible.
function Z_Score_Result_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Z_Score_Result (see VARARGIN)

% Choose default command line output for Z_Score_Result
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Z_Score_Result wait for user response (see UIRESUME)
% uiwait(handles.figure1);



global str2
set(handles.listbox1,'String',str2);
% --- Outputs from this function are returned to the command line.
function varargout = Z_Score_Result_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


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


