function newlist=crelist(variables)
%CRELIST Create variable list.
%   vlist = crelist('var1 var2 var3 …') creates and returns a list of
%   variable names var1, var2, var3, etc… Variable lists are used to keep 
%   variables together and to send a group of variables to a function 
%   together. Variable lists just keep the names of the variables, not the 
%   actual values of the variables.
%
%   Copyright 2001-2006 The SVS, Inc. 
%   Revision: 1.0.1.3   Date: 2006/05/29 21:45:36

newlist='';
[row col]=size(variables);

for k=1:row
    currentrow=strtrim(variables(k,:));
    [varname currentrow]=strtok(currentrow,' ');
    while strcmp(varname,'')==0
        newlist=strvcat(newlist, varname);
        [varname currentrow]=strtok(currentrow,' ');
    end
end