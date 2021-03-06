function varargout = transformation(varargin)
% TRANSFORMATION M-file for transformation.fig
%      TRANSFORMATION, by itself, creates a new TRANSFORMATION or raises the existing
%      singleton*.
%
%      H = TRANSFORMATION returns the handle to a new TRANSFORMATION or the handle to
%      the existing singleton*.
%
%      TRANSFORMATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRANSFORMATION.M with the given input arguments.
%
%      TRANSFORMATION('Property','Value',...) creates a new TRANSFORMATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before transformation_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to transformation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help transformation

% Last Modified by GUIDE v2.5 06-Jun-2007 21:39:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @transformation_OpeningFcn, ...
                   'gui_OutputFcn',  @transformation_OutputFcn, ...
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


% --- Executes just before transformation is made visible.
function transformation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to transformation (see VARARGIN)

% Choose default command line output for transformation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


global listst
%global all_vars

global cur_variables
cur_variables= ['NA']
my_var_c=1


all_vars=evalin('base','who')



listst

thesame=1
[mm,nn]=size(listst)
[aa,bb]=size(all_vars)





for count=1:aa
temp_vars=all_vars{count,1}
temp_vars=deblank(temp_vars)
same_counter=0
for lcount=1:mm
    
temp_listst=listst(lcount,:)

temp_listst=deblank(temp_listst)

my_res=strcmp(temp_vars,temp_listst)

if(my_res==1)
 
 same_counter=same_counter+1   
    
end    



end %k???k for

if(same_counter==0)
    
checkans=strcmp(temp_vars,'ans')
checkmeta=strcmp(temp_vars,'metadata')
if(checkans==0)
if(checkmeta==0)    
[aw,ar]=size(temp_vars)

for iii=1:ar 
fhj=temp_vars(1,iii)
    
glm=char(fhj)

cur_variables(my_var_c,iii)=glm

end
my_var_c=my_var_c+1
%cur_variables(variable_count,:)=temp_vars

end
end
end

end % b?y?k for

%%end %b?y?k for

set(handles.listbox1,'String',cur_variables);
%

% UIWAIT makes transformation wait for user response (see UIRESUME)
% uiwait(handles.figure1);
h = uibuttongroup('visible','off','Position',[0 0 .01 .01]);
u0 = uicontrol('Style','Radio','String','Z-score',...
    'pos',[30 325 70 20],'parent',h,'tag','u0','HandleVisibility','off');
u1 = uicontrol('Style','Radio','String','Min-Max',...
    'pos',[30 280 70 20],'parent',h,'tag','u1','HandleVisibility','off');


set(h,'SelectionChangeFcn',@selcbk);
set(h,'SelectedObject',[]);  % No selection
set(h,'Visible','on');

function selcbk(source,eventdata)
t=get(eventdata.NewValue,'Tag');

switch (t)   % Get Tag of selected object
    case 'u0'
    global transselect
    transselect=0
    case 'u1'
    global transselect
    transselect=1
end






% --- Outputs from this function are returned to the command line.
function varargout = transformation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


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



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

newvar_object = findobj(gcbf,'Tag','listbox1');
entered_newvar = get(newvar_object,'Value');
svar=entered_newvar

%strvar=handles.newvarstr
newstr_object = findobj(gcbf,'Tag','listbox1');
entered_newstr = get(newstr_object,'String');
strvar=entered_newstr

ready_var=strvar(svar,:)

ready_var=deblank(ready_var)




newprefix_object = findobj(gcbf,'Tag','edit2');
entered_newpre = get(newprefix_object,'String');
prefixvar=entered_newpre


newlow_object = findobj(gcbf,'Tag','edit3');
entered_newlow = get(newlow_object,'String');
lowvar=entered_newlow

newup_object = findobj(gcbf,'Tag','edit8');
entered_newup = get(newup_object,'String');
upvar=entered_newup

global transselect
if (transselect==0)

if(isempty(entered_newpre))
    
    global str1
    str1=evalin('base',ready_var)
    global str2
    run_str=['zscore(',ready_var,')']
    str2=evalin('base',run_str)
    Z_Score_Result;

else
     global str1
     str1=evalin('base',ready_var)
     global str2
     run_str=['zscore(',ready_var,',',entered_newpre,')']
    str2=evalin('base',run_str)
    Z_Score_Result;
end

elseif (transselect==1)
    if(isempty(entered_newpre))
    
        if(isempty(entered_newlow))
            global str2
            rn_str=['minmax(',ready_var,')']
            str2=evalin('base',rn_str)
            %str2=minmax(ready_var)
                Z_Score_Result;
        else
            if(~isempty(entered_newup))
                global str2
                rn_str=['minmax(',ready_var,',',lowvar,',',upvar,')']
                str2=evalin('base',rn_str)
                %str2=minmax(ready_var,lowvar,upvar)
                    Z_Score_Result;
            end
            
        end
    else
        if(isempty(entered_newlow))
        global str2
        rn_str=['minmax(',ready_var,',',prefixvar,')']
        str2=evalin('base',rn_str)
        %str2=minmax(ready_var,prefixvar)
            Z_Score_Result;
        else
            
            if(~isempty(entered_newup))
                global str2
                rn_str=['minmax(',ready_var,',',lowvar,',',upvar,',',prefixvar,')']
                %st2=minmax(ready_var,lowvar,upvar,prefixvar)
                    Z_Score_Result;
            end
            
        end
        
    end
    
    
end
% --- Executes on button press in radiobutton6.
function radiobutton6_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton6


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


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


