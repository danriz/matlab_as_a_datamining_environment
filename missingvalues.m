function varargout = missingvalues(varargin)
% MISSINGVALUES M-file for missingvalues.fig
%      MISSINGVALUES, by itself, creates a new MISSINGVALUES or raises the existing
%      singleton*.
%
%      H = MISSINGVALUES returns the handle to a new MISSINGVALUES or the handle to
%      the existing singleton*.
%
%      MISSINGVALUES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MISSINGVALUES.M with the given input arguments.
%
%      MISSINGVALUES('Property','Value',...) creates a new MISSINGVALUES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before missingvalues_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to missingvalues_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help missingvalues

% Last Modified by GUIDE v2.5 12-Jun-2007 11:22:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @missingvalues_OpeningFcn, ...
                   'gui_OutputFcn',  @missingvalues_OutputFcn, ...
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


% --- Executes just before missingvalues is made visible.
function missingvalues_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to missingvalues (see VARARGIN)

% Choose default command line output for missingvalues
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

set(handles.listboxC,'String',cur_variables);



%begining of Cloumn definiation

newlistvar_object = findobj(gcbf,'Tag','listboxC');
selected_newvar = get(newlistvar_object,'Value');
listval=selected_newvar

newliststr_object = findobj(gcbf,'Tag','listboxC');
selected_newstr = get(newliststr_object,'String');
liststr=selected_newstr

the_var=cur_variables(1,:)

the_var=deblank(the_var)

global set_history
global opt_selected
search_send=0
[ry,rp]=size(set_history)

for ert=1:ry
    history_row=set_history(ert,:)
search_res=findstr(history_row,the_var)
        if(search_res~=0)
        search_send=1
        end
end
if(search_send==1)
cloumn_str=getmeta(the_var,'type')
 set(handles.edit6,'String',cloumn_str);   
else
    set(handles.edit6,'String','Not Entered');
end




% UIWAIT makes missingvalues wait for user response (see UIRESUME)
% uiwait(handles.figure1);

h = uibuttongroup('visible','off','Position',[0 0 .01 .01]);
u0 = uicontrol('Style','Radio','String','Mean',...
    'pos',[60 290 50 30],'parent',h,'tag','u0','HandleVisibility','off');
u1 = uicontrol('Style','Radio','String','Mode',...
    'pos',[60 250 50 30],'parent',h,'tag','u1','HandleVisibility','off');
u2 = uicontrol('Style','Radio','String','Median',...
    'pos',[60 210 50 30],'parent',h,'tag','u2','HandleVisibility','off');
u3 = uicontrol('Style','Radio','String','',...
    'pos',[60 180 10 30],'parent',h,'tag','u3','HandleVisibility','off');
set(h,'SelectionChangeFcn',@selcbk);
set(h,'SelectedObject',[]);  % No selection
set(h,'Visible','on');

function selcbk(source,eventdata)
t=get(eventdata.NewValue,'Tag');

switch (t)   % Get Tag of selected object
    case 'u0'
    global opt_selected 
    opt_selected=0 
    case 'u1'
        global opt_selected
    opt_selected=1 
    case 'u2'
        global opt_selected
    opt_selected=2 
    case 'u3'
        global opt_selected
    opt_selected=3 
        
end



% --- Outputs from this function are returned to the command line.
function varargout = missingvalues_OutputFcn(hObject, eventdata, handles) 
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

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


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


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4


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


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5


% --- Executes on button press in radiobutton6.
function radiobutton6_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton6



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

newlistvar_object = findobj(gcbf,'Tag','listboxC');
selected_newvar = get(newlistvar_object,'Value');
listval=selected_newvar

newliststr_object = findobj(gcbf,'Tag','listboxC');
selected_newstr = get(newliststr_object,'String');
liststr=selected_newstr

the_var=selected_newstr(listval,:)

the_var=deblank(the_var)

newpre_object = findobj(gcbf,'Tag','edit4');
prefix_newval = get(newpre_object,'String');
prefixval=prefix_newval

global opt_selected



newcnt_object = findobj(gcbf,'Tag','edit3');
cnt_newval = get(newcnt_object,'String');
cnt_val=cnt_newval


newrep_object = findobj(gcbf,'Tag','edit7');
rep_newval = get(newrep_object,'String');
rep_val=rep_newval


newcol_object = findobj(gcbf,'Tag','edit6');
col_newval = get(newcol_object,'String');
col_val=col_newval


if(opt_selected==0)

    run_str=[the_var,'=repmiss(',the_var,')']
    evalin('base',run_str)
    close;
    close startup;
    startup; 
elseif(opt_selected==1)
    
    if((strcmp(col_val,'numeric')) || (isempty(col_val)))
    
    
            run_str=[the_var,'=repmiss(',the_var,',1)']
            evalin('base',run_str)    
            close;
            close startup;
            startup;
    else
            run_str=[the_var,'=repmiss(',the_var,',''',the_var,''')']
            evalin('base',run_str)
            close;
            close startup;
            startup; 
    end    
elseif(opt_selected==2)

    run_str=[the_var,'=repmiss(',the_var,',2)']
    evalin('base',run_str)    
    close;
    close startup;
    startup;    
end








%global set_history
%global opt_selected
%search_res=findstr(set_history,the_var)
%if(search_res~=0)
%cloumn_str=getmeta(the_var,'type')
% set(handles.edit6,'String',cloumn_str);   
%end

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



function listboxC_Callback(hObject, eventdata, handles)
% hObject    handle to listboxC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of listboxC as text
%        str2double(get(hObject,'String')) returns contents of listboxC as a double


newlistvar_object = findobj(gcbf,'Tag','listboxC');
selected_newvar = get(newlistvar_object,'Value');
listval=selected_newvar

newliststr_object = findobj(gcbf,'Tag','listboxC');
selected_newstr = get(newliststr_object,'String');
liststr=selected_newstr

the_var=selected_newstr(listval,:)

the_var=deblank(the_var)

global set_history
global opt_selected
search_send=0
[ry,rp]=size(set_history)

for ert=1:ry
    history_row=set_history(ert,:)
search_res=findstr(history_row,the_var)
        if(search_res~=0)
        search_send=1
        end
end
if(search_send==1)
cloumn_str=getmeta(the_var,'type')
 set(handles.edit6,'String',cloumn_str);   
else
    set(handles.edit6,'String','Not Entered');
end



% --- Executes during object creation, after setting all properties.
function listboxC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listboxC (see GCBO)
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



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --------------------------------------------------------------------
function uipanel1_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


        



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double

% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


