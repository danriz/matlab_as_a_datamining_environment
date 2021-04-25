%Function to select a file to perform mine on
function openDataFile()

%Open default open file dialgoue window
[fileName, pathName] = uigetfile('*.txt'); 

%Get handle of object who's UserData will store file data-----------
edit_file_name = findobj(gcbf,'Tag','edit_file_name');

%If a file has been selected
if fileName ~= 0
   %Set file edit box to selected file
   clear dataFile;
   set(edit_file_name,'String',cat(2,pathName,fileName));
end