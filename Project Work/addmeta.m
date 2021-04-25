function y=addmeta(var,p1,v1,p2,v2)
%ADDMETA Add new values to the metadata of a variable.
%   addmeta('var','param','value') adds new distinct value or missing value 
%   to the metadata of variable var.
%
%   addmeta('var','param1','value1','param2','value2') adds both new 
%   distinct value and missing value to the metadata of variable var.
%
%   If metadata of this variable does not exist, addmeta gives an error.
%
%   Example:
%   addmeta('income','dist','medium')
%   Adds 'medium' distinct value to the metadata of variable income which has
%   already a distinct value 'low'.
%
%   Example:
%   addmeta('income','miss','?','dist','high veryhigh')
%   Adds a new missing value and two distinct values together to the
%   metadata of variable 'income'.
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
    for k=1:((nargin-1)/2)
        eval(['param=p',int2str(k),';']);
        eval(['value=v',int2str(k),';']);
        if strcmp(param,'dist')==1 || strcmp(param,'miss')==1
            evalstr=['list=addlist(metadata(',int2str(index),').',param,',''',value,''');'];
            eval([evalstr]);
            evalstr=['metadata(',int2str(index),').',param,'=list;'];
            eval([evalstr]);
            y=metadata(index);
        end
    end
end

