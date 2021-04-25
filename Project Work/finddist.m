function finddist(var)
%FINDDIST Find distinct values of a variable.
%   finddist(var) finds distinct values of a variable and set these values
%   to the metadata of the variable var.
%
%   Example:
%   finddist('income')
%   Finds distinct values of variable 'income' and set these values to the metadata of
%   variable 'income'.
%
%   Copyright 2001-2006 The SVS, Inc. 
%   Revision: 1.0.1.3   Date: 2006/05/29 21:45:36

eval(['global ',var,';']);
evalstr=['tmpStruct=getfreq(',var,');'];
eval([evalstr]);
evalstr=['setmeta(''',var,''',''dist'',tmpStruct{1});'];    
eval([evalstr]);
