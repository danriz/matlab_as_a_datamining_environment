function y = maxdiff(source,labels)
%MAXDIFF Make a boundry between sorted adjacent values if the difference
%   is one of the largest k differences.
%
%   y=maxdiff(X,labels) where X is a column vector and, labels is a cell 
%   array of labels that define each interval, returns a column vector of 
%   corresponding label of interval. Number of intervals is number of labels. 
%   Thus to divide the column vector into N interval, labels should have 
%   N elements. Elements of labels can be both numeric and character arrays. 
%
%   Maxdiff sorts the X vector and finds the largest N-1 differences to make
%   boundaries of intervals.
%
%   Example:
%   X=[1 19 27 30 25 0 17 8 10 5]';
%   maxdiff(X,{'A' 'B' 'C'})
%   There are three labels A, B and C. That means X will be divided into 3 
%   intervals. Maxdiff sorts the X vector and finds the 2 largest differences 
%   as boundaries. 
%   Sorted X - 0    1   5   8   10  17  19  25  27  30
%   Maxdiff divides the vector from boundaries. As a result 0, 1, 5, 8, 10 
%   are labeled as A, 17, 19 are labeled as B, while 25, 27 and 30 are 
%   labeled as C.
%
%   Copyright 2001-2006 The SVS, Inc. 
%   Revision: 1.0.1.3   Date: 2006/05/23 20:45:00

groupcount=length(labels);

len=length(source);
for i=1:len
    temp(i,1)=i;
    temp(i,2)=source(i);
end;

temp=sortrows(temp,2);
for i=1:len-1
    temp(i,3)=abs(temp(i,2)-temp(i+1,2));
end;

temp=sortrows(temp,3);
temp=[temp [zeros(len-groupcount+1,1);ones(groupcount-1,1)]];
temp=sortrows(temp,2);


gr=1;
for i=1:len
    temp2(i,1:length(labels{1,gr}))=labels{1,gr};
    if (temp(i,4)==1) gr=gr+1; end;
end;
temp=temp(:,1);
temp2([temp],:)=temp2;
clear temp;
y=temp2;