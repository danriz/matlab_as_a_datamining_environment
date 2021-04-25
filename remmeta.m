function metalist=remmeta(var,p1,v1,p2,v2)
%REMMETA Remove existing distinct values from the metadata of a variable.
%   remmeta('var','param','value') removes an existing distinct value or 
%   missing value from the metadata of variable var.
%
%   remmeta('var','param1','value1','param2','value2') removes an existing 
%   distinct value and missing value together from the metadata of variable var.
%
%   If metadata of this variable does not exist, remmeta gives an error.
%
%   Example:
%   remmeta('income','miss','NA')
%   Removes 'NA' missing value from the metadata of variable 'income'.
%
%   Example:
%   remmeta('income','miss','?','dist','high veryhigh')
%   Removes one missing value and two distinct values together from the
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
            evalstr=['list=remlist(metadata(',int2str(index),').',param,',''',value,''');'];
            eval([evalstr]);
            evalstr=['metadata(',int2str(index),').',param,'=list;'];
            eval([evalstr]);
            metalist=metadata(index);
        end
    end
end

