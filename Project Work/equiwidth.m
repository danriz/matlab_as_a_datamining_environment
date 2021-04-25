function y = equiwidth(source,labels)
%EQUIWIDTH Divide the range into intervals of equal size.
%   y=equiwidth(X,labels) where X is a column vector and, labels is a cell 
%   array of labels that define each interval, returns a column vector of 
%   corresponding label of interval which an element is within. Number of 
%   intervals is number of labels. Thus to divide the column vector into N 
%   interval, labels should have N elements. Elements of labels can be both 
%   numeric and character arrays. Range of each interval is equal.
%
%   Example:
%   X=[1 2 5 0 7 8 1 5 9 10]';
%   equiwidth(X,{'A1' 'B2'})
%   There are two labels 'A1' and 'B2'. That means X will be divided into 2
%   intervals. X has 0 as minimum and 10 as maximum. Thus, each interval 
%   size will be 5. 'A1' is for [0,5] interval and 'B2' is for (5,10]. 
%   Returning column vector is the answer of which value is in which 
%   interval. 1,2,5,0,1,5 are between [0,5], thus become A1, and 7,8,9,10 
%   are between (5,10], thus become B2.
%
%   equiwidth(x1,{1 2})
%   Elements of labels can be numeric as well.
%
%   Copyright 2001-2006 The SVS, Inc. 
%   Revision: 1.0.1.3   Date: 2006/05/25 12:45:20

len=length(source);
groupcount=length(labels);
minx=min(source);
maxx=max(source);
width=(maxx-minx)/groupcount;

if iscell(labels)
    for i=1:len
        gr=(source(i,1)-minx)/width;
        for j=1:groupcount
            if (gr<=j) 
                temp(i,1:length(labels{1,j}))=labels{1,j};
                break;
            end;
        end;
    end;
end;

y=temp;