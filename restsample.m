function y=restsample(vlist,model,prefix)
%RESTSAMPLE Create new variables with the values that are not selected in a
%   previously performed sampling.
%
%   vlist parameter should be a character array that has variable names at 
%   each row. The variables whose names are included into the vlist must be 
%   defined as global. Also, these variables may be vertical arrays or two 
%   dimensional matrices but they must consist of the same number of rows.
%
%   model parameter is an array of integer numbers which are the indices of 
%   the rows that you want to be selected and can be entered manually. Also, 
%   these indices are returned as the result of the sampling and can be 
%   stored in variables.
%
%   prefix parameter should be a string that will be used to name the new 
%   variables. New variable names are the combination of prefix value with 
%   the original names of the variables in the vlist. These new variables 
%   consist of the values that are not included into the model parameter. 
%   If it is empty as '', then the new variables will not be created but the 
%   indices that are not in the model will be found and returned as the 
%   result of the function as in the form of a vector.
%
%   Example:
%   rsm1=restsample(vlist,sm2,'rs2_')
%   Finds the indices of unselected rows according to the model 'sm2' and 
%   copyies the values of corresponding rows to new variables starting with 
%   the prefix 'rs2_'.
%
%   Copyright 2001-2006 The SVS, Inc. 
%   Revision: 1.0.1.3   Date: 2006/05/19 20:30:15

if ~nargin==3
    error 'Required number of parameters is 3!'
end

eval(['global ',vlist(1,:),';']);
ssize=eval(['size(',vlist(1,:),',1);']);

temp=ones(1,ssize);
for i=1:numel(model)
    temp(model(i))=0;
end
unselecteds=find(temp);     % sýfýrdan farklý olan deðerlerin indekslerini alýyoruz.

if ~strcmp(prefix,'')
    newvlist='';
    for i=1:size(vlist,1)
        curvname=vlist(i,:);
        eval(['global ',curvname,';']);
        newvname=genvarname([prefix,curvname],who);   
        newvlist=strvcat(newvlist,newvname);
        for j=1:numel(unselecteds)
            evalin('base',['global ', newvname]);   % Yeni deðiþkenlerin de global olmasý için
            eval([newvname,'(',int2str(j),',:)=',curvname,'(',int2str(unselecteds(j)),',:);']);
            eval(['assignin(''base'',''',newvname,''',',newvname,');']);
        end        
    end
    newvlistname=[prefix,'vlist'];
    eval([newvlistname,'=newvlist;']);
    eval(['assignin(''base'',''',newvlistname,''',',newvlistname,');']);
end

y=unselecteds;