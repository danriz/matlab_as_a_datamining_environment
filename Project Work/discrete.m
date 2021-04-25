function y = discrete(source,labels)
%DISCRETE Transform the numeric vector into discrete values according to
%   given intervals.
%
%   y=discrete (X,labels) where X is a column vector and, labels is a cell 
%   array of interval expressions and discrete values, returns a column 
%   vector of corresponding discrete value. 
%
%   Labels is a N-by-3 cell array. N is the number of discrete values. Each 
%   rows define one of discrete value. There are three cells in each row, 
%   first and second cell are used to define the range of interval and third 
%   is the corresponding discrete value.
%
%   Example:
%   exp={'<=18','','young';'>18','<=45','mature';'>45','','old'};
%   x1=[1 19 27 60 25 0 17 46 10 55]';
%   discrete(x1,exp)
%   Transforms the numerical values of variable 'x1' to discrete values
%   according to the interval described in expression 'exp'.
%
%   exp={'<=18','',1;'>18','<=45',2;'>45','',3}
%   x1=[1 19 27 60 25 0 17 46 10 55]';
%   discrete(x1,exp)
%   Instead of discrete values, numeric values can be used.
%
%   Copyright 2001-2006 The SVS, Inc. 
%   Revision: 1.0.1.3   Date: 2006/05/20 14:15:30

[a,b]=size(labels);
len=length(source);

for i=1:a;
        r=0;
        exp='';
        if (strcmp(labels{i,1},'')==0) r=r+1; end;
        if (strcmp(labels{i,2},'')==0) r=r+2; end;   

        if (r==3)   exp=strcat('((source(k,1)',labels{i,1},')&&(source(k,1)',labels{i,2},'))');
        elseif (r==0)   exp='false';
        else    exp=strcat('(source(k,1)',labels{i,r},')');
        end;
        grup{i,1}=exp;
        grup{i,2}=labels{i,3};
end;

for k=1:len;
    i=1;
    while (i<=a)
        eval(['if ',grup{i,1},'' ...
                    'temp2(k,1:length(grup{i,2}))=grup{i,2};' ...
                    'i=a; ' ...
              'end']);
        i=i+1;
   end;
end;  
clear grup;
clear source;

y=temp2;