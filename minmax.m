function y = minmax(variables,lower,upper,prefix)
%MINMAX Transform to [0,1] range or given range.
%   y=minmax(X) returns the values of the elements for each column or 
%   variable transformed to [0,1] range.
%
%   if X is a column vector, minmax (X) returns a column vector including 
%   transformed values of each element.
%
%   if X is a matrix, minmax (X) treats each column of X as different 
%   variables and returns a matrix including transformed values of each 
%   element along that column.
%
%   if X is a variable list, minmax (X) creates new variables including 
%   transformed values with prefix 'mm_' corresponding to each variable in 
%   the variable list and returns a new variable list for newly created variables.
%
%   y=minmax(X,lower,upper) is used to define the lower and upper range values. 
%   Default of lower and upper are 0 and 1. This returns the values of the 
%   elements for each column or variable transformed to [lower,upper] range.
%
%   y=minmax(X,prefix) is used to define the prefix of new variables.
%   Default of prefix is 'mm_' where X is a variable list.
%
%   y=minmax(X,lower,upper,prefix) is used to define both the lower and 
%   upper range values instead of 0 and 1 and prefix of new variables 
%   instead of 'mm_' where X is a variable list.
%
%   Example:
%   X=[1 2 5 3 7 8 0 5 9 10]';
%   minmax(X)
%   Transforms each value of variable 'X' to the range of [0,1].
%
%   X=[1 2 5 3 7 8 0 5 9 10;7 6 5 8 7 9 9 6 10 8]';
%   minmax(X,0,100)
%   Transforms each value of variable 'X' along the columns to the range of [0,100].
%
%   x1=[1 2 5 0 7 8 1 5 9 10]';
%   x2=[7 6 5 8 7 9 9 6 10 8]';
%   vlist=crelist('x1 x2');
%   newlist=minmax(vlist,0,100,'minmax_')
%   Transforms the values of variables in the variable list 'vlist' to the
%   range of [0,100] and creates new variables starting with the prefix
%   'minmax_' such as 'minmax_x1' and 'minmax_x2'.
%
%   Copyright 2001-2006 The SVS, Inc. 
%   Revision: 3.0.1.3   Date: 2006/05/27 11:40:36

[a,b]=size(variables);

if ischar(variables) 
    if ischar(lower) prefix=lower; 
    elseif nargin~=4 prefix='mm_'; end;
    str=[];
    for i=1:a
        eval(['global ', deblank(variables(i,:)),';']);
        str=[str, ' ', deblank(variables(i,:))];
    end;
    source=eval(['[',str,'];']);
else
    source=variables;
end;
minx=nanmin(source);
maxx=nanmax(source);
m_minx=minx;
m_maxx=maxx;
[x,y]=size(source);
for i=1:x-1
    m_minx=[m_minx;minx];
    m_maxx=[m_maxx;maxx];
end;

if (nargin>=3)
    temp=lower+(upper-lower)*((source-m_minx)./(m_maxx-m_minx));
else
    temp=(source-m_minx)./(m_maxx-m_minx);
end;

if ischar(variables)
    svs=[];
    for i=1:a
        newvname=[prefix, deblank(variables(i,:))];
        evalin('base',['global ',newvname,';']); 
        eval([newvname,'=temp(:,i);']);
        eval(['assignin(''base'',''',newvname,''',',newvname,');']);
        svs=addlist(svs,newvname);

    end;
else
    svs=temp;
end;   
y=svs;