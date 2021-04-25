function varlist = getodbc(source,username,password,sqlquery,rowlimit)
%GETODBC Retrieve data from a data source via an ODBC driver.
%   vlist = getodbc(source,username,password,sqlquery) connects to a 
%   database via an ODBC driver, retrieves data from this data source, 
%   creates new variables from each column of database table, and return 
%   the variable list of these created variable names. Variable names are 
%   generated from column names of database table.
%
%   vlist = getodbc(source,username,password,sqlquery,rowlimit) retrieves 
%   data from the data source, up to the maximum rowlimit.
%   source is the data source to which you are connecting. You must have
%   previously set up the ODBC data source.
%
%   username and password are the username and/or password required to 
%   connect to the database. If you do not need a username or a password 
%   to connect to the database, use empty strings as the arguments.
%
%   sqlquery is the valid SQL statement sqlquery to be executed. 
%   The sqlquery argument can also be a stored procedure for that 
%   database connection.
%
%   rowlimit is used to limit how much data is retrieved at once.
%
%   Example:
%   vlist = getodbc('hospital','','','select * from "DOCTOR INFORMATION"')
%   Retrieve data from the database hospital via ODBC Access driver. No
%   username or password is required to connect to the database.
%
%   Example:
%   vlist = getodbc('hospital','','','select * from "DOCTOR INFORMATION"',8)
%   Retrieve data from database hospital, up to the maximum rowlimit=8.
%
%   Copyright 2001-2006 The SVS, Inc. 
%   Revision: 2.0.1.1   Date: 2006/05/25 21:46:57

setdbprefs('DataReturnFormat','cellarray');
conn=database(source,username,password);

curs=exec(conn,sqlquery);
curs=fetch(curs,1);

colnames=strrep(columnnames(curs),'''','');
colnum=length(findstr(colnames,','))+1;

varlist='';
for k=1:colnum
    [varname colnames]=strtok(colnames,',');
    sqlnew = strrep(sqlquery, '*', ['"',varname,'"']);
        
    curs=exec(conn,sqlnew);
    if nargin==4
        curs=fetch(curs);
    elseif nargin==5
        curs=fetch(curs,rowlimit);
    end

    varname=genvarname(varname,who('global'));
    eval([varname,'=curs.data(:,1);']);
    
    if strcmp(class(curs.data{1,1}),'char')==1
        eval([varname,'=char(',varname,');']);
    elseif strcmp(class(curs.data{1,1}),'double')==1
        eval([varname,'=[',varname,'{:}]'';']);
    elseif strcmp(class(curs.data{1,1}),'logical')==1
        eval([varname,'=[',varname,'{:}]'';']);
    end
    
    varlist = strvcat(varlist, varname);
    evalin('base',['global ',varname]);
    eval(['assignin(''base'',''',varname,''',',varname,');']);
    eval(['clear ' varname]);
end