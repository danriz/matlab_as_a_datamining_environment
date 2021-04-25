function newlist=addlist(vlist,variables)
%ADDLIST Add new variable names to a variable list.
%   newlist = addlist(vlist,'var1 var2 var3 …') adds variable names var1,
%   var2, var3, etc… to an existing variable list vlist and returns 
%   the new variable list newlist. One variable list can also be added 
%   to another variable list.
%
%   Example:
%   newlist = addlist(vlist,'gender children')
%   Adds the variable names 'gender' and 'children' to the existing 
%   variable list 'vlist'.
%
%   Example:
%   newlist = addlist(vlist,vlist2)
%   Adds the variable names in the existing 'vlist2' to the existing 
%   variable list 'vlist'.
%
%   Copyright 2001-2006 The SVS, Inc. 
%   Revision: 1.0.1.3   Date: 2006/05/29 21:45:36

newlist=vlist;
[row col]=size(variables);

for k=1:row
    currentrow=strtrim(variables(k,:));
    [varname currentrow]=strtok(currentrow,' ');
    while strcmp(varname,'')==0
        newlist=strvcat(newlist, varname);
        [varname currentrow]=strtok(currentrow,' ');
    end
end