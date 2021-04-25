function y = equidepth(source,labels)
%EQUIDEPTH Divide the range into intervals, each contains approximately
%   same number of elements.
%
%   y=equidepth(X,labels) where X is a column vector and, labels is a cell
%   array of labels that define each interval, returns a column vector of 
%   corresponding label of interval which an element is within after sorting. 
%   Number of intervals is number of labels. Thus to divide the column vector 
%   into N interval, labels should have N elements. Elements of labels can 
%   be both numeric and character arrays. Each interval has same number of 
%   elements.
%
%   Example:
%   X=[1 2 5 0 7 8 1 5 3 10]';
%   equidepth(X,{1 2})
%   There are two labels 1 and 2. That means X will be divided into 2
%   intervals. X has 10 elements. Thus, each interval will have 5 elements. 
%   equidepth sorts the X vector and puts first 5 elements into first interval, 
%   and second 5 elements into second interval. Returning column vector is 
%   the answer of which value is in which interval. 0,1,1,2,3 are in the 
%   first interval and labeled as 1, and 5,5,7,8,10 are in the second interval 
%   and labeled as 2.
%
%   Copyright 2001-2006 The SVS, Inc. 
%   Revision: 1.0.1.3   Date: 2006/05/26 16:45:35

groupcount=length(labels);

len=length(source);
for i=1:len
    temp(i,1)=i;
    temp(i,2)=source(i);
end;
temp=sortrows(temp,2);

st_membercount=fix(len/groupcount);
remaining=mod(len,groupcount);
y1=((groupcount-remaining)/2)+1;
y2=ceil(groupcount-((groupcount-remaining)/2));

x=0;
membercount=st_membercount;
for i=1:groupcount
    if (i>=y1) membercount=st_membercount+1; end;
    if (i>y2) membercount=st_membercount; end;
    for j=1:membercount
        x=x+1;
        gr(x,1)=i;
    end;
end;
temp=[temp gr];
temp=sortrows(temp,1);

for i=1:len
    temp2(i,1:length(labels{1,temp(i,3)}))=labels{1,temp(i,3)};
end;
y=temp2;