function newlist=remlist(vlist,variables)
%REMLIST Remove variable names from a variable list.
%   newlist = remlist(vlist,'var1 var2 var3 …') removes variable names
%   var1, var2, var3, etc… from an existing variable list vlist and 
%   returns the new variable list newlist. One variable list can also be 
%   removed from another variable list.
%
%   Example:
%   newlist = remlist(vlist,'income children')
%   Removes variable names 'income' and 'children' from the existing variable
%   list 'vlist'.
%
%   Example:
%   newlist = remlist(vlist,vlist2)
%   Removes the variable names in the variable list 'vlist2' from the 
%   variable list 'vlist'. 

%   Copyright 2001-2006 The SVS, Inc. 
%   Revision: 1.0.1.2   Date: 2006/05/25 23:02:06

newlist=vlist;
[row col]=size(variables);

for k=1:row
    currentrow=strtrim(variables(k,:));
    [varname currentrow]=strtok(currentrow,' ');
    while strcmp(varname,'')==0
        [vrow vcol]=size(newlist);
        for n=1:vrow
            curvar=strtrim(newlist(n,:));
            if strcmp(curvar,varname)==1
                newlist(n,:) = [];
                break;
            end
        end
        [varname currentrow]=strtok(currentrow,' ');
    end
end