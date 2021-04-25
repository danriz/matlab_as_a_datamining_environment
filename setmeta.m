function y = setmeta(var,p1,v1,p2,v2,p3,v3,p4,v4)
%SETMETA Set metadata value of a variable.
%   setmeta('var','param','value') sets metadata value of variable var.
%   setmeta('var','param1','value1','param2','value2',…) sets more than 
%   one metadata value of variable var.
%
%   Metadata keeps information about variables that does not exist in 
%   MATLAB or that we cannot reach directly from data. Metadata keeps type, 
%   desc, dist, and miss values for a variable.
%
%   'type' - Type of the variable such as ordinal, nominal, numeric, etc…
%   'desc' - Description of the variable such as this variable will be input vector.
%   'dist' - Distinct values of the variable such as low, medium, high, etc…
%   'miss' - Missing values of the variable	such as Nan, ?, NA, etc…
%
%   If metadata of a variable does not exist, setmeta first creates 
%   metadata of this variable, then sets metadata value of the variable. 
%
%   Example:
%   setmeta('age','type','ordinal','miss','NaN NA')
%   Since metadata of age does not exist, setmeta first creates metadata of
%   this variable, then sets metadata value of the variable. More than one 
%   value can be assigned to a metadata at a time.
%
%   Example:
%   setmeta('age','type','numeric','desc','age of the customer')
%   Adds new values to the metadata or change existing values in the
%   metadata. 
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
    index=len+1;
    metadata(index).name=var;
    metadata(index).desc='';
    metadata(index).type='';
    metadata(index).dist='';
    metadata(index).miss='';
end

for k=1:((nargin-1)/2)
    eval(['param=p',int2str(k),';']);
    eval(['value=v',int2str(k),';']);
    if strcmp(param,'desc')==1 || strcmp(param,'type')==1
        evalstr=['metadata(',int2str(index),').',param,'=''',value,''';'];
        eval([evalstr]);
    elseif strcmp(param,'dist')==1 || strcmp(param,'miss')==1
        list=crelist(value);
        evalstr=['metadata(',int2str(index),').',param,'=list;'];
        eval([evalstr]);
    end
    y=metadata(index);
end