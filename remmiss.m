function y=remmiss(variables,count,prefix)
%REMMISS Remove missing values.
%   y = remmiss(X,n) removes rows with n missing values and returns new 
%   version of X.
%
%   If X is a column vector, remmiss(X,n) returns a column vector after 
%   replacing missing values.
%
%   If X is a matrix, remmiss(X,n) returns a matrix version of X which rows 
%   with n missing values are removed.
%
%   If X is a variable list, remmiss(X,n) creates new variables with prefix 
%   'rm_' which rows with n missing values are removed from variables in 
%   the variable list, and returns a new variable list.
%
%   y = remmiss(X,n,prefix) is used to define the prefix of new variables. 
%   Default of prefix is 'rm_'.
%
%   Example:
%   v1=[5 4 NaN 3 3 NaN 4 3 2 1]';
%   v2=[8 9 NaN 3 3 NaN 9 NaN 5 7]';
%   vlist=crelist('v1 v2');
%   remmiss(vlist,2,'new_')
%   Removes the rows of variables 'v1' and 'v2' both have missing values
%   and creates new variables with prefix 'new_' such as 'new_v1' and 'new_v2'.
%
%   X=[5 4 NaN 3 3 NaN 4 3 2 1;8 9 NaN 3 3 NaN 9 NaN 5 7]';
%   remmiss(X,2)
%   X is a matrix consisting of 10 rows and 2 columns. remmiss removes the
%   rows both have missing values.
%
%   Copyright 2001-2006 The SVS, Inc. 
%   Revision: 1.0.1.3   Date: 2006/05/30 19:45:12

[aa,bb]=size(variables);

if ischar(variables) 
    if nargin~=3 prefix='rm_'; end;
    str=[];
    for i=1:aa
        eval(['global ', deblank(variables(i,:)),';']);
        str=[str, ' ', deblank(variables(i,:))];
    end;
    source=eval(['[',str,'];']);
else
    source=variables;
end;

[a,b]=find(isnan(source));

if length(a)==0 
    y=variables;
    return;
end;

x=0;    
while length(a)>0
    x=x+1;
    temp2(x,1)=length(find(a==a(1)));
    temp2(x,2)=a(1);
    a=a(find(~(a==a(1))));
end;
temp2=temp2(find(temp2(:,1)>=count),2);
source(temp2,:)=[];

 if ischar(variables)
    svs=[];
    for i=1:aa
        newvname=[prefix, deblank(variables(i,:))];
        evalin('base',['global ',newvname,';']); 
        eval([newvname,'=source(:,i);']);
        eval(['assignin(''base'',''',newvname,''',',newvname,');']);
        svs=addlist(svs,newvname);

    end;
else
    svs=source;
end;   

y=svs;