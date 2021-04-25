function y=sample(vlist,percent,type,prefix,interval,model)
%SAMPLE Make sampling with or without replacement.
%   vlist parameter should be a character array that has variable names at 
%   each row. The variables whose names are included into the vlist must be 
%   defined as global. Also, these variables may be vertical arrays or two 
%   dimensional matrices but they must consist of the same number of rows.
%
%   percent parameter should be a scalar between 0 and 100.
%
%   type parameter should be a scalar that has the information of the 
%   sampling type that is with or without replacement. The values could be:
%   	0 - with replacement
%   	1 - without replacement
%
%   prefix parameter should be a string that will be used to name the new 
%   variables. New variable names are the combination of prefix value with 
%   the original names of the variables in the vlist. These new variables 
%   consist of the values in the selected rows of each variable after the 
%   sampling. If it is empty as '', then the new variables will not be 
%   created but the sampling will be performed and the information about 
%   the indices of the selected rows will be returned as a vector after the 
%   sampling has been done.
%
%   interval should be a scalar or a 1-by-2 or 2-by-1 array. If interval is 
%   a scalar, for example 50 and the variables consist of 100 rows then the 
%   rows between 50 and 100 will be selected according to the type and 
%   percentage. If interval is an array of two elements for example [30,70] 
%   then the rows between 30 and 70 will be selected. The order of 30 and 70 
%   is unimportant so [70,30] is the same as the previous one. Also, if the 
%   percent parameter is empty while the interval has been defined, then all 
%   rows between 30 and 70 will be selected without making a random sampling.
%
%   model parameter is an array of integer numbers which are the indices of 
%   the rows that you want to be selected and be entered manually. Also, 
%   these indices are returned as the result of the sampling. For example, 
%   you get a sample of 10 variables, but then you have to add another 
%   variable or variables to this sampling without changing the characteristics 
%   of the first sample, so you can store the returned array of indices in 
%   a variable as the model of the sampling and send it to this function as 
%   model parameter that will be used to get the sample from that newly added 
%   variable or variables. When the model parameter has entered then the 
%   percent, type, and interval parameters will be discarded during the 
%   sampling so they can be left empty as below:
%   sm2=sample(vlist,'','','s2','',sm1);
%   sm1 and sm2 means the models of the sampling process 1 and 2 respectively. 
%
%   In addition to the new variables that hold the selected values, a list 
%   of newly created variables will be created as the combination of prefix 
%   parameter with 'vlist'. This list can be used to get a new sample from 
%   the sample.  
%
%   Example:
%   global V1 V2 V3
%   V1=[1;2;3;4;5;6;7;8;9;10];
%   V2=['A';'B';'C';'D';'E';'F';'G';'H';'I';'J'];
%   V3=[10,100;20,200;30,300;40,400;50,500;60,600;70,700;80,800;90,900;100,1000];
%   vlist=crelist('V1 V2 V3');
%   sm1=sample(vlist,50,0,'s1_')
%   The command above gets a 50% sample of the variables included into the
%   vlist by using with replacement method and creates new variables started 
%   with the prefix 's1_'. Also, returns the indices of the selected rows 
%   to the sm1.
%
%   sm2=sample(vlist,50,1,'s2_')
%   The command above gets a 50% sample of the variables included into the
%   vlist by using without replacement method and creates new variables 
%   started with the prefix 's2_'. Also, returns the indices of the selected 
%   rows to the sm1.
%
%   sm2=sample(vlist,50,1,'s2_',[2,8])
%   The command below gets a 50% sample of the variables included into the
%   vlist by using the without replacement method. Sampling is performed 
%   between the 2nd and 8th rows of variables including each. Then, it 
%   creates new variables starting with the prefix 's2_'. Also, it returns 
%   the indices of the selected rows to the sm1. 
%
%   sm2=sample(vlist,'','','s2_',[2,8])
%   if the percent argument is blank then all rows between the interval are
%   selected without sampling.
%
%   m3=sample(vlist,'','','s3_','',sm1)
%   if a model that has the information of the rows that will be selected is
%   entered to the function like below, then there is no need to enter the 
%   percent, type and interval arguments. Since, they are discarded and the 
%   given rows are selected. But the prefix argument is necessary to name 
%   the new variables. This helps to get the same sampling results on new 
%   variables.
%
%   Copyright 2001-2006 The SVS, Inc. 
%   Revision: 1.0.1.3   Date: 2006/05/14 20:14:32

if nargin<4
    error 'Minimum allowed number of Parameters is 4!'
elseif nargin>6
    error 'Maximum allowed number of Parameters is 6!'
end

if percent<0 | percent>100
    error 'Percentage must be within the interval of 0-100!'
else
    percent=percent*0.01;       % tamsayý þeklinde belirtilen yüzde deðerini ondalýklý hale çeviriyoruz.
end

switch nargin
    case {4,5}        
        if nargin==4
            eval(['global ',vlist(1,:),';']);
            b=eval(['size(',vlist(1,:),',1);']);        
            a=0;
        else                        
            interval=sort(interval);
            if numel(interval)==1
                a=interval(1)-1;
                eval(['global ',vlist(1,:),';']);
                b=eval(['size(',vlist(1,:),',1);']);
            else
                a=interval(1)-1;
                b=interval(2); 
            end
        end     

        if isempty(percent)                 % eðer percent belirtilmediyse sampling yapmayacak datanýn tamamýný alacak
            selectedrows=[(a+1):b];
        else
            ssize=ceil((b-a)*percent);
            if type==0                          % with replacement
                selectedrows=ceil((b-a)*rand(1,ssize)+a);
            elseif type==1                      % without replacement
                selectedrows=ceil((b-a)*rand()+a);
                i=1;
                while i<ssize                   % For döngüsü sorun çýkartýyor, çünkü i=i-1 dediðimizde i azalýyo gibi
                    temp=ceil((b-a)*rand()+a);  % görünse de aslýnda azalmýyor ve döngüye kaldýðý yerden devam ediyor.
                    itemexist=0;
                    for j=1:i
                        if temp==selectedrows(j)
                            itemexist=1;
                            break;
                        end
                    end
                    if itemexist==0
                        selectedrows=[selectedrows,temp];
                        i=i+1;
                    end
                end
            end
        end
    case 6
        selectedrows=model;        
end

% Eðer yeni deðiþkenler için bir önek belirtilmiþse Seçilmiþ olan
% satýrlardan oluþan yeni deðiþkenler oluþturuluyor.
if ~strcmp(prefix,'')
    newvlist='';
    for i=1:size(vlist,1)
        curvname=vlist(i,:);
        eval(['global ',curvname,';']);
        newvname=genvarname([prefix,curvname],who);   
        newvlist=strvcat(newvlist,newvname);
        for j=1:numel(selectedrows)
            evalin('base',['global ', newvname]);   % Yeni deðiþkenlerin de global olmasý için
            eval([newvname,'(',int2str(j),',:)=',curvname,'(',int2str(selectedrows(j)),',:);']);
            eval(['assignin(''base'',''',newvname,''',',newvname,');']);
        end        
    end
    newvlistname=[prefix,'vlist'];
    eval([newvlistname,'=newvlist;']); % Oluþturulan deðiþken isimlerinin bulunduðu yeni bir deðiþken listesi oluþturuluyor.
    eval(['assignin(''base'',''',newvlistname,''',',newvlistname,');']);
end 

y=selectedrows;