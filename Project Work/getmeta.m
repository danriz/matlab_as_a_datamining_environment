function metavalue=getmeta(var,param)
%GETMETA Get metadata value of a variable.
%   value = getmeta('var','param') gets metadata value of variable var.
%   If metadata of this variable does not exist, getmeta gives an error.
%
%   Example:
%   typevalue = getmeta('age','type')
%   Gets the 'type' value of the variable 'age' from its existing metadata.
%
%   Copyright 2001-2006 The SVS, Inc. 
%   Revision: 1.0.1.3   Date: 2006/05/29 21:45:36

evalin('base',['global metadata']);
global metadata;
len=length(metadata);

index=0;
for k=1:len
    if strcmp(metadata(k).name,var)==1
        index=k;
        break;
    end
end

if index==0
    error(['This variable does not exist --> ',var])
else
    evalstr=['metavalue=metadata(',int2str(index),').',param,';'];
    eval([evalstr]);
end