function read_Callback()
try
   %Get all criteria input
   file_object = findobj(gcbf,'Tag','edit_file_name');
   file_to_mine = get(file_object,'String');
   delimiter_object = findobj(gcbf,'Tag','delimiter');
   delimiter_value = get(delimiter_object,'Value');
   
   %Check file has been entered--------------------------------
	if isempty(file_to_mine)
   	msgbox('Please specify a file to mine first','CreateMode','Normal');
   	return;
	else 
   	switch delimiter_value
   		case 1
         	delimiterw = ',';
      	case 2 
         	delimiterw = ';';
      	case 3
         	delimiterw = ':';
      	case 4
         	delimiterw = '.';
      	case 5
         	delimiterw = ' ';
  		end
    end
end
	%File criteria should be specified OK once code hits here----
    
   
   	fprintf('Reading data file...\n');
    
    
  
  
  
   global vlist;
   vlist = gettext(file_to_mine, delimiterw, 1)
   %a=[vlist];
     %v = gettext('C:\Program Files\MATLAB71\work\yeni.txt',',',1)
  

close;
close startup;
startup;
%msgbox(v);



 
 

end