function varlist=gettext(filename,delimiter,isheader,rowlimit)
%GETTEXT Retrieve data from a text file.
%   vlist = gettext(filename,delimiter,isheader) retrieves data from 
%   a text file, creates new variables from each column of text file, and 
%   return the variable list of these created variable names. Variable 
%   names are generated from headers in the text file. If there is no 
%   header information in the file, variable names are randomly generated 
%   such as var1, var2, var3, etc…
%
%   vlist = gettext(filename,delimiter,isheader,rowlimit) reads data from 
%   the text file, up to the maximum rowlimit.
%
%   filename is the text file from which you are retrieving data.
%
%   delimiter acts as delimiters between elements in the text file such as 
%   comma, space, semicolon, tab, etc…
%
%   isheader indicates whether there is a header line at the beginning of 
%   the file or not.
%       0 – there is no header line at the beginning of the file.
%       1 – there is header line at the beginning of the file.
%
%   rowlimit is used to limit how much data is retrieved at once.
%
%   Example:
%   vlist = gettext('c:\customer.txt',';',1)
%   Retrieve data from text file customer.txt. There is header line at the
%   beginning of the file. Delimiter is semicolon (;).
%
%   Example:
%   vlist = gettext('c:\customer2.txt',';',0,5)
%   Retrieve data from text file customer2.txt up to the maximum
%   rowlimit=5. There is no header line at the beginning of the file.
%
%   Copyright 2001-2006 The SVS, Inc. 
%   Revision: 1.0.1.3   Date: 2006/05/23 11:55:23

if isheader==1
    firstline=char(textread(filename,'%s',1,'headerlines',1));
    colnum=length(findstr(firstline,delimiter))+1;
    colnames=char(textread(filename,'%s',1));
else
    firstline=char(textread(filename,'%s',1));
    colnum=length(findstr(firstline,delimiter))+1;
    for k=1:colnum
        if k==1
            colnames='var1';
        else
            colnames=[colnames delimiter 'var' int2str(k)];
        end
    end
end

varlist='';
getstr='[';
namestr='';
formstr='';

for k=1:colnum
    [varname{k} colnames]=strtok(colnames,delimiter);
    varname{k}=genvarname(varname{k},who('global'));
    varlist = strvcat(varlist, varname{k});
    
    [form{k} firstline]=strtok(firstline,delimiter);
    if isnan(str2double(form{k}))==1
        form{k}='%q';
    else
        form{k}='%f';
    end
    
    if k==1
        namestr=[namestr varname{k}];
        formstr=[formstr form{k}];
    else
        namestr=[namestr ' ' varname{k}];
        formstr=[formstr ' ' form{k}];
    end
end

getstr=[getstr namestr '] = textread(' '''' filename ''',''' formstr ''','];

if nargin==4
    getstr=[getstr int2str(rowlimit) ','];
end

getstr=[getstr '''emptyvalues'',NaN,''delimiter'','''];

if isheader==1
    getstr=[getstr delimiter ''',''headerlines'',1);'];
else
    getstr=[getstr delimiter ''');'];
end

eval([getstr]);

for k=1:colnum
    if strcmp(form{k},'%q')==1
        eval([varname{k},'=char(',varname{k},');']);
    end
    evalin('base',['global ',varname{k}]);
    eval(['assignin(''base'',''',varname{k},''',',varname{k},');']);
    eval(['clear ' varname{k}]);
end