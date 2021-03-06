function varargout = startup(varargin)
% STARTUP M-file for startup.fig
%      STARTUP, by itself, creates a new STARTUP or raises the existing
%      singleton*.
%
%      H = STARTUP returns the handle to a new STARTUP or the handle to
%      the existing singleton*.
%
%      STARTUP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STARTUP.M with the given input arguments.
%
%      STARTUP('Property','Value',...) creates a new STARTUP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before startup_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to startup_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help startup

% Last Modified by GUIDE v2.5 09-Jun-2007 22:53:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @startup_OpeningFcn, ...
                   'gui_OutputFcn',  @startup_OutputFcn, ...
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

global set_history
global set_counter



global samplehistory
global sample_row
global sample_col
[le,pe]=size(samplehistory)
if(le==0)
   samplehistory=['NA']
   sample_row=1;
   sample_col=1;
   sample_row=abs(sample_row)
   sample_col=abs(sample_col)
end


global descrip_history
global row_count
global col_count
[ko,kp]=size(descrip_history)
if(ko==0)
   descrip_history=['NA']
   row_count=1;
   col_count=1;
   row_count=abs(row_count);
   col_count=abs(col_count);
end


[az,ay]=size(set_history)
if(az==0)
set_history=['NA']    
set_counter=1;
set_counter=abs(set_counter);
end

global add_history
global add_counter

[cz,cy]=size(add_history)
if(cz==0)
add_history=['NA']
add_counter=1;
add_counter=abs(add_counter);    
end

global countlist;
global myhistory;

global countlist1;
global myhistory1;

global listorder
global listst
[tt,rr]=size(listst)
if(tt==0)
 listst=['vlist']
 listorder=2
end

[xx,xy]=size(myhistory1)
if (xx==0)
myhistory1=['NA']
countlist1=1;
countlist1=abs(countlist1);
end
[xz,xt]=size(myhistory)
if(xz==0)
myhistory=['NA']
countlist=1;
countlist=abs(countlist);
end
% --- Executes just before startup is made visible.
function startup_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to startup (see VARARGIN)

% Choose default command line output for startup
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes startup wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = startup_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


global vlist;
a=[vlist];
y=1;
[m,n]=size(a);


asstring=vlist(1,:);
sendit=['size(', asstring,')'];
[t,r]=evalin('base', sendit);

c=a(1,:);

for x=1:m-1

%handles.activex2.Row=-1;    
%handles.activex2.Col=x;

c=strcat(c,';',a(x+1,:));

%arrayin=x+1;
end
handles.activex2.AllColsText=c;
for a=0:m-1
    
for y=1:t
handles.activex2.Row=y-1;    
handles.activex2.Col=a;
yy=a+1;
mystr=vlist(yy,:);
tt=y;
rr=int2str(tt);
printit=[mystr,'(',rr,',:)'];
myvalue=evalin('base', printit);
if (isstr(myvalue))
readyy=myvalue;
else
readyy=int2str(myvalue);    
end
handles.activex2.Text=readyy;



end
end
handles.activex2.Row=0;
handles.activex2.Col=0;
%handles.activex2.Text=;



% --------------------------------------------------------------------
function Read_from_File_Callback(hObject, eventdata, handles)
% hObject    handle to Read_from_File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%h = uigetfile('FilterSpec','Open File','');
Readfromfile

% --------------------------------------------------------------------
function Read_from_ODBC_Callback(hObject, eventdata, handles)
% hObject    handle to Read_from_ODBC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uigetodbc

% --------------------------------------------------------------------
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

uiputfile('.m','Save As..','Untitled')

% --------------------------------------------------------------------
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
question= 'Are you sure you want to quit?';
button= questdlg(question,'Exit Request','Yes','No','No');
switch button
    case 'No'
        quit cancel;
    case 'Yes'
        quit;
end

% --------------------------------------------------------------------
function Missing_Value_Callback(hObject, eventdata, handles)
% hObject    handle to Missing_Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

missingvalues
% --------------------------------------------------------------------
function Sampling_Callback(hObject, eventdata, handles)
% hObject    handle to Sampling (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sampling

% --------------------------------------------------------------------
function Transformation_Callback(hObject, eventdata, handles)
% hObject    handle to Transformation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

transformation
% --------------------------------------------------------------------
function Discretization_Callback(hObject, eventdata, handles)
% hObject    handle to Discretization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
discretization

% --------------------------------------------------------------------
function Association_Callback(hObject, eventdata, handles)
% hObject    handle to Association (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
armada

% --------------------------------------------------------------------
function Clustering_Callback(hObject, eventdata, handles)
% hObject    handle to Clustering (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

K_means
% --------------------------------------------------------------------
function Classification_Callback(hObject, eventdata, handles)
% hObject    handle to Classification (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Regression_Callback(hObject, eventdata, handles)
% hObject    handle to Regression (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Regression

% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Preparation_Callback(hObject, eventdata, handles)
% hObject    handle to Preparation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Functionality_Callback(hObject, eventdata, handles)
% hObject    handle to Functionality (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'toolbar','figure');






% --------------------------------------------------------------------
function activex1_Click(hObject, eventdata, handles)
% hObject    handle to activex1 (see GCBO)
% eventdata  structure with parameters passed to COM event listener
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function activex1_DblClick(hObject, eventdata, handles)
% hObject    handle to activex1 (see GCBO)
% eventdata  structure with parameters passed to COM event listener
% handles    structure with handles and user data (see GUIDATA)




% --------------------------------------------------------------------
function activex1_EndEdit(hObject, eventdata, handles)
% hObject    handle to activex1 (see GCBO)
% eventdata  structure with parameters passed to COM event listener
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function activex1_Modified(hObject, eventdata, handles)
% hObject    handle to activex1 (see GCBO)
% eventdata  structure with parameters passed to COM event listener
% handles    structure with handles and user data (see GUIDATA)




% --------------------------------------------------------------------
function Sequention_Callback(hObject, eventdata, handles)
% hObject    handle to Sequention (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Descriptives_Callback(hObject, eventdata, handles)
% hObject    handle to Read_from_ODBC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Descriptives

% --------------------------------------------------------------------
function Read_Callback(hObject, eventdata, handles)
% hObject    handle to Read (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --------------------------------------------------------------------
function List_Metadata_Callback(hObject, eventdata, handles)
% hObject    handle to List_Metadata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
List_Metadata

% --------------------------------------------------------------------
function Data_Callback(hObject, eventdata, handles)
% hObject    handle to Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Create_List_Callback(hObject, eventdata, handles)
% hObject    handle to Create_List (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Create_List

% --------------------------------------------------------------------
function Add_List_Callback(hObject, eventdata, handles)
% hObject    handle to Add_List (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Add_to_List

% --------------------------------------------------------------------
function Remove_List_Callback(hObject, eventdata, handles)
% hObject    handle to Remove_List (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Remove_from_List

% --------------------------------------------------------------------
function Show_Lists_Callback(hObject, eventdata, handles)
% hObject    handle to Show_Lists (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Show_Lists

% --------------------------------------------------------------------
function Add_Meta_Callback(hObject, eventdata, handles)
% hObject    handle to Add_Meta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 Add_Metadata

% --------------------------------------------------------------------
function Set_Meta_Callback(hObject, eventdata, handles)
% hObject    handle to Set_Meta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Set_Metadata

% --------------------------------------------------------------------
function Bar_Chart_Callback(hObject, eventdata, handles)
% hObject    handle to Bar_Chart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Bar_Graph
% --------------------------------------------------------------------
function Pie_Chart_Callback(hObject, eventdata, handles)
% hObject    handle to Pie_Chart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Pie_Graph
% --------------------------------------------------------------------
function Graphics_Callback(hObject, eventdata, handles)
% hObject    handle to Graphics (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Open_Callback(hObject, eventdata, handles)
% hObject    handle to Open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --------------------------------------------------------------------
function Read_from_MatFiles_Callback(hObject, eventdata, handles)
% hObject    handle to Read_from_MatFiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --------------------------------------------------------------------
function Run_Matlab_Command_Callback(hObject, eventdata, handles)
% hObject    handle to Run_Matlab_Command (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Run_Matlab_Command



% --------------------------------------------------------------------
function CHAID_Callback(hObject, eventdata, handles)
% hObject    handle to CHAID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Chaid
% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ex_chaid
% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Neural_Network


% --------------------------------------------------------------------
function Box_Plot_Callback(hObject, eventdata, handles)
% hObject    handle to Box_Plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Box_Grapth

% --------------------------------------------------------------------
function Scatter_Plot_Callback(hObject, eventdata, handles)
% hObject    handle to Scatter_Plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Scatter_Grapth
% --------------------------------------------------------------------
function Untitled_7_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Line_Graph
