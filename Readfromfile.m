clear all;

warning off;

%Create main window
Start_Window = figure('Name','Read_From_File','NumberTitle','Off','WindowStyle','Normal','menubar','none','Position',[120,260,450,400]);

%Create File for mining details frame
uicontrol(Start_Window,'Style','frame','Position',[1,1,450,400]);
uicontrol(Start_Window,'Style','text','Position',[10,150,400,200],'String','FILE DETAILS :','FontWeight','bold','HorizontalAlignment','left');
uicontrol(Start_Window,'Style','edit','Position',[100,330,200,30],'BackgroundColor','white','HorizontalAlignment','left','Tag','edit_file_name');
uicontrol(Start_Window,'Style','pushbutton','Position',[330,330,70,30],'String','Browse','Backgroundcolor',[.725 .725 .867],'Callback','openTextFile');
uicontrol(Start_Window,'Style','text','Position',[10,210,80,50],'String','DELIMITING CHARACTER :','FontWeight','bold','HorizontalAlignment','left');
uicontrol(Start_Window,'Style','popupmenu','Position',[110,230,90,30],'String',', (comma)| ; (semi-colon)|: (colon)|. (full-stop)|-SPACE-','BackgroundColor','white','Tag','delimiter'); 
uicontrol(Start_Window,'Style','pushbutton','Position',[330,230,70,30],'String','Read','Backgroundcolor',[.725 .725 .867],'Callback','read_Callback');
uicontrol(Start_Window,'Style','pushbutton','Position',[330,150,70,30],'String','Close','Callback','close');



