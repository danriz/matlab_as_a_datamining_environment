function read_from_odbc()


try
   db_object=findobj(gcbf,'Tag','edit1');
   db_name=get(db_object,'String');
   
   user_object=findobj(gcbf,'Tag','edit4');
   user_name=get(user_object,'String');
   
   pass_object=findobj(gcbf,'Tag','edit5');
   pass_name=get(pass_object,'String');
   
   %select_object=findobj(gcbf,'Tag','edit2');
   %select_name=get(select_object,'String');
   
   tbl_object=findobj(gcbf,'Tag','edit3');
   tbl_name=get(tbl_object,'String');
   
   row_object=findobj(gcbf,'Tag','edit6');
   row=get(row_object,'String')
   
end

%['select ',select_name,' from "',tbl_name,'"'];
%my_sql=[tbl_object];
global vlist

if(isempty(row))
vlist = getodbc(db_name,user_name,pass_name,tbl_name);
else
int_row=str2num(row)    
vlist = getodbc(db_name,user_name,pass_name,tbl_name,int_row)    
end
    close;
    close startup;
    startup;
end