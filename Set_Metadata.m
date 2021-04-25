function varargout = Set_Metadata(varargin)
% SET_METADATA M-file for Set_Metadata.fig
%      SET_METADATA, by itself, creates a new SET_METADATA or raises the existing
%      singleton*.
%
%      H = SET_METADATA returns the handle to a new SET_METADATA or the handle to
%      the existing singleton*.
%
%      SET_METADATA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SET_METADATA.M with the given input arguments.
%
%      SET_METADATA('Property','Value',...) creates a new SET_METADATA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Set_Metadata_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Set_Metadata_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Set_Metadata

% Last Modified by GUIDE v2.5 21-May-2007 21:41:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Set_Metadata_OpeningFcn, ...
                   'gui_OutputFcn',  @Set_Metadata_OutputFcn, ...
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


% --- Executes just before Set_Metadata is made visible.
function Set_Metadata_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Set_Metadata (see VARARGIN)

% Choose default command line output for Set_Metadata
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Set_Metadata wait for user response (see UIRESUME)
% uiwait(handles.figure1);

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



end %küçük for

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

end % büyük for

%%end %büyük for

set(handles.popupmenu2,'String',cur_variables);



% --- Outputs from this function are returned to the command line.
function varargout = Set_Metadata_OutputFcn(hObject, eventdata, handles) 
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
newdist=get(hObject, 'String');
handles.newdist = newdist;
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



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double
newdesc=get(hObject, 'String');
handles.newdesc = newdesc;
guidata(hObject,handles)



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


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)

newmis=get(hObject, 'Value');
handles.newmis = newmis

newmisstr=get(hObject, 'String');
handles.newmisstr = newmisstr

guidata(hObject,handles)


% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4
newtyp=get(hObject, 'Value');
handles.newtyp = newtyp

newtypstr=get(hObject, 'String');
handles.newtypstr = newtypstr

guidata(hObject,handles)





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


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2

newvar=get(hObject, 'Value');
handles.newvar = newvar

newvarstr=get(hObject, 'String');
handles.newvarstr = newvarstr

guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
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

%svar=handles.newvar
newvar_object = findobj(gcbf,'Tag','popupmenu2');
entered_newvar = get(newvar_object,'Value');
svar=entered_newvar

%strvar=handles.newvarstr
newstr_object = findobj(gcbf,'Tag','popupmenu2');
entered_newstr = get(newstr_object,'String');
strvar=entered_newstr


%stype=handles.newtyp
newtyp_object = findobj(gcbf,'Tag','popupmenu4');
entered_newtyp = get(newtyp_object,'Value');
stype=entered_newtyp

%str_typ=handles.newtypstr
new_str_typ_object = findobj(gcbf,'Tag','popupmenu4');
entered_newstr_typ = get(new_str_typ_object,'String');
str_typ=entered_newstr_typ


%mydesc=handles.newdesc
newdesc_object = findobj(gcbf,'Tag','edit2');
entered_newdesc = get(newdesc_object,'String');
mydesc=entered_newdesc


%mydist=handles.newdist
newdist_object = findobj(gcbf,'Tag','edit1');
entered_newdist = get(newdist_object,'String');
mydist=entered_newdist


%smiss=handles.newmis
newmis_object = findobj(gcbf,'Tag','popupmenu3');
entered_newmis = get(newmis_object,'Value');
smiss=entered_newmis

%strmissing=handles.newmisstr
newmisstr_object = findobj(gcbf,'Tag','popupmenu3');
entered_newmisstr = get(newmisstr_object,'String');
strmissing=entered_newmisstr


%o_miss=handles.new_ot_mis
newomiss_object = findobj(gcbf,'Tag','edit3');
entered_newomis = get(newomiss_object,'String');
o_miss=entered_newomis


global cur_variables  

global set_history
global set_counter

ready_var=cur_variables(svar,:)

ready_var=deblank(ready_var)







%str_typ=handles.newtypstr

temp_type=str_typ(stype,:)

ready_type=temp_type{1}



temp_miss=strmissing(smiss,:)

ready_miss=temp_miss{1}

if(isempty(o_miss))%1
if(isempty(mydesc))%2
if(isempty(mydist))%3
    if(strcmp(ready_miss,'Select'))%4

        r_str=['setmeta(''',ready_var,''',''type'',''',ready_type,''')']
        evalin('base',r_str)
        
        [hz,hy]=size(r_str)
        
        for tt=1:hy
        set_history(set_counter,tt)=r_str(1,tt)    
        end
        
        set_counter=set_counter+1
        set_history
        r_str=''
        set(handles.popupmenu4,'Value',1)
        set(handles.popupmenu2,'Value',1)
    else %4
        r_str=['setmeta(''',ready_var,''',''type'',''',ready_type,''',''miss'',''',ready_miss,''')']
        evalin('base',r_str)
       
                [hz,hy]=size(r_str)
        
        for tt=1:hy
        set_history(set_counter,tt)=r_str(1,tt)    
        end
        
        r_str=''
        set(handles.popupmenu4,'Value',1)
set(handles.popupmenu2,'Value',1)
set(handles.popupmenu3,'Value',1)
set(handles.edit2,'String','');
set(handles.edit1,'String','');
set(handles.edit3,'String','');
    end%4
    
else%3
  
            if(strcmp(ready_miss,'Select'))   %5 
            r_str=['setmeta(''',ready_var,''',''type'',''',ready_type,''',''dist'',''',mydist,''')']
            evalin('base',r_str)
            
            [hz,hy]=size(r_str)
        
            for tt=1:hy
            set_history(set_counter,tt)=r_str(1,tt)    
            end
            
            r_str=''
            set(handles.popupmenu4,'Value',1)
set(handles.popupmenu2,'Value',1)
set(handles.popupmenu3,'Value',1)
set(handles.edit2,'String','');
set(handles.edit1,'String','');
set(handles.edit3,'String','');
            else %5
            r_str=['setmeta(''',ready_var,''',''type'',''',ready_type,''',''dist'',''',mydist,''',''miss'',''',ready_miss,''')']
            evalin('base',r_str)
            
           [hz,hy]=size(r_str)
        
           for tt=1:hy
           set_history(set_counter,tt)=r_str(1,tt)    
           end
            
            r_str=''
            set(handles.popupmenu4,'Value',1)
set(handles.popupmenu2,'Value',1)
set(handles.popupmenu3,'Value',1)
set(handles.edit2,'String','');
set(handles.edit1,'String','');
set(handles.edit3,'String','');
            end %5
end %end of isempty mydist 3
else % else of is empty mydesc2
  
    if(isempty(mydist))%6
        if(strcmp(ready_miss,'Select'))%7
         r_str=['setmeta(''',ready_var,''',''type'',''',ready_type,''',''desc'',''',mydesc,''')']
         evalin('base',r_str)
         
                 [hz,hy]=size(r_str)
        
        for tt=1:hy
        set_history(set_counter,tt)=r_str(1,tt)    
        end
         
         r_str=''
         set(handles.popupmenu4,'Value',1)
set(handles.popupmenu2,'Value',1)
set(handles.popupmenu3,'Value',1)
set(handles.edit2,'String','');
set(handles.edit1,'String','');
set(handles.edit3,'String','');
         %stringleri sil dropdownlarý ilk deðere getir
        else%7
         r_str=['setmeta(''',ready_var,''',''type'',''',ready_type,''',''desc'',''',mydesc,''',''miss'',''',ready_miss,''')']
         evalin('base',r_str)
         
                 [hz,hy]=size(r_str)
        
        for tt=1:hy
        set_history(set_counter,tt)=r_str(1,tt)    
        end
         
         r_str=''
         set(handles.popupmenu4,'Value',1)
set(handles.popupmenu2,'Value',1)
set(handles.popupmenu3,'Value',1)
set(handles.edit2,'String','');
set(handles.edit1,'String','');
set(handles.edit3,'String','');
         %stringleri sil dropdownlarý ilk deðere getir
        end%7

    else %else of isempty6
        if(strcmp(ready_miss,'Select')) %8
        r_str=['setmeta(''',ready_var,''',''type'',''',ready_type,''',''desc'',''',mydesc,''',''dist'',''',mydist,''')']
        evalin('base',r_str)
        
                [hz,hy]=size(r_str)
        
        for tt=1:hy
        set_history(set_counter,tt)=r_str(1,tt)    
        end
        
        r_str=''
        set(handles.popupmenu4,'Value',1)
set(handles.popupmenu2,'Value',1)
set(handles.popupmenu3,'Value',1)
set(handles.edit2,'String','');
set(handles.edit1,'String','');
set(handles.edit3,'String','');
        else%8
        r_str=['setmeta(''',ready_var,''',''type'',''',ready_type,''',''desc'',''',mydesc,''',''dist'',''',mydist,''',''miss'',''',ready_miss,''')']
        evalin('base',r_str)
        
                [hz,hy]=size(r_str)
        
        for tt=1:hy
        set_history(set_counter,tt)=r_str(1,tt)    
        end
        
        r_str=''
        set(handles.popupmenu4,'Value',1)
set(handles.popupmenu2,'Value',1)
set(handles.popupmenu3,'Value',1)
set(handles.edit2,'String','');
set(handles.edit1,'String','');
set(handles.edit3,'String','');
        end%8
    
    end%6
end
else %else of isempty o_miss

    
    if(isempty(mydesc)) %9
        if(isempty(mydist)) %10
        r_str=['setmeta(''',ready_var,''',''type'',''',ready_type,''',''miss'',''',o_miss,''')']
        evalin('base',r_str)
        
                [hz,hy]=size(r_str)
        
        for tt=1:hy
        set_history(set_counter,tt)=r_str(1,tt)    
        end
        
        r_str=''
        set(handles.popupmenu4,'Value',1)
set(handles.popupmenu2,'Value',1)
set(handles.popupmenu3,'Value',1)
set(handles.edit2,'String','');
set(handles.edit1,'String','');
set(handles.edit3,'String','');
        else %10
        r_str=['setmeta(''',ready_var,''',''type'',''',ready_type,''',''miss'',''',o_miss,''',''dist'',''',mydist,''')']
        evalin('base',r_str)
        
                [hz,hy]=size(r_str)
        
        for tt=1:hy
        set_history(set_counter,tt)=r_str(1,tt)    
        end
        
        r_str=''
        set(handles.popupmenu4,'Value',1)
set(handles.popupmenu2,'Value',1)
set(handles.popupmenu3,'Value',1)
set(handles.edit2,'String','');
set(handles.edit1,'String','');
set(handles.edit3,'String','');
    
        end %10
    
    else %9
        
        if(isempty(mydist)) %11
        r_str=['setmeta(''',ready_var,''',''type'',''',ready_type,''',''miss'',''',o_miss,''',''desc'',''',mydesc,''')']
        evalin('base',r_str)
        
                [hz,hy]=size(r_str)
        
        for tt=1:hy
        set_history(set_counter,tt)=r_str(1,tt)    
        end
        
        r_str=''
        set(handles.popupmenu4,'Value',1)
set(handles.popupmenu2,'Value',1)
set(handles.popupmenu3,'Value',1)
set(handles.edit2,'String','');
set(handles.edit1,'String','');
set(handles.edit3,'String','');
    
        else%11
        r_str=['setmeta(''',ready_var,''',''type'',''',ready_type,''',''miss'',''',o_miss,''',''desc'',''',mydesc,''',''dist'',''',mydist,''')']
        evalin('base',r_str)
        
                [hz,hy]=size(r_str)
        
        for tt=1:hy
        set_history(set_counter,tt)=r_str(1,tt)    
        end
        
        
        r_str=''
        set(handles.popupmenu4,'Value',1)
set(handles.popupmenu2,'Value',1)
set(handles.popupmenu3,'Value',1)
set(handles.edit2,'String','');
set(handles.edit1,'String','');
set(handles.edit3,'String','');
      
        end%11         
    end %9
end

function edit3_Callback(hObject, eventdata, handles)

new_ot_mis=get(hObject, 'String');
handles.new_ot_mis = new_ot_mis;
guidata(hObject,handles)

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


