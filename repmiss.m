function y = repmiss(variables,v1,v2,v3)
%REPMISS Replace missing values.
%   y = repmiss (X) where X is numeric, replaces the missing values (NaN)
%   with mean and returns the replaced version of X.
%
%   if X is a column vector, repmiss(X) returns a column vector after 
%   replacing missing values.
%
%   if X is a matrix, repmiss(X) treats each column of X as different 
%   variables and replaces missing values with mean of each column and 
%   returns replaced matrix version of X.
%
%   y = repmiss(X,type) where X is numeric vector or matrix, type is the
%   option to determine with what fill the missing values. Missing values 
%   can be filled with mean, median and mode for numeric values. Type 
%   argument is 0 as default. For other options following values for type 
%   should be used.
%       0 - mean
%       1 - median
%       2 - mode
%
%   y = repmiss(X,varname) where X is a character array, varname is the
%   name of X variable, replaces the missing values of X with mode and 
%   returns the replaced version of X. 
%
%   Missing values of X must be stated in metadata. repmiss gets the missing 
%   value information from metadata. Thus, name of the variable should also 
%   be given as second parameter.
%
%   In character arrays, missing values can be replaced only with mode. 
%   Thus, there is no type option.
%
%   X must be defined as global variable.
%
%   y = repmiss(X,'vlist') where X is a variable list, creates new variables 
%   which contain replaced version of old variables with prefix 'r_' and 
%   returns a new variable list for newly created variables.
%
%   To state X is a variable list, second parameter must be 'vlist'.
%
%   y = repmiss(X,'vlist',type) is used to define whether mean, median or 
%   mode is used to replace missing values of numeric variables in the 
%   variable list.
%
%   y = repmiss(X,'vlist',prefix) is used to define the prefix of new 
%   variables. Default of prefix is 'r_'.
%
%   y = repmiss(X,’vlist’,type,prefix) is used to define both type and prefix.
%
%   Example:
%   repmiss(X)
%   Replaces the missing values of variable 'X' with the mean value of it. 
%
%   repmiss(X,1)
%   Replaces the missing values of variable 'X' with the median value of it.
%
%   X=['AA';'AA';'? ';'BB';'CC';'AA';'AA';'? ';'CC';'AA'];
%   setmeta('X','miss','?');
%   repmiss(X,'X')
%   X is a character array, and '?' is defined as missing value in
%   metadata. repmiss replaces missing values with mode which is 'AA'.
%
%   x1=[NaN 19 27 60 25 0 17 NaN 10 NaN]';
%   x2=[17 12 25 14 NaN 91 19 26 10 NaN]';
%   xcat=['AA'; 'AA' ;'? '; 'BB'; 'CC' ;'AA';'AA';'? ';'CC';'AA'];
%   vlist=crelist('x1 x2 xcat');
%   setmeta('xcat','miss','?');
%   newlist=repmiss(vlist,'vlist',1,'replaced_')
%   X is a variable list with both numeric and categorical attributes.
%   repmiss replaces missing values of numeric variables with median, and 
%   mode for categorical ones. Missing values of variable 'xcat' is defined 
%   in metadata. New variables have prefix of 'replaced_'.
%
%   Copyright 2001-2006 The SVS, Inc. 
%   Revision: 1.0.1.3   Date: 2006/05/29 20:45:28

if isnumeric(variables) 
    if (nargin==1) v1=0; end;
    type=v1;
    [a,b]=size(variables);

    result=[];
    for i=1:b
        source=variables(:,i);
        nans=find(isnan(source));
        if ((nargin==1)||(type==0))
            missingvalue=nanmean(source);
        elseif (type==1)
            missingvalue=nanmedian(source);
        elseif (type==2)
            temp=find(~isnan(source));
            temp=source(temp);
            temp=sort(temp);
            x=0;
            while length(temp)>0
                x=x+1;
                temp2(x,1)=length(find(temp==temp(1)));
                temp2(x,2)=temp(1);
                temp=temp(find(~(temp==temp(1))));
            end;
            temp2=sortrows(temp2,1);
            missingvalue=temp2(x,2);
        end;

        source([nans])=missingvalue;
        result=[result source];
    end;
    svs=result;
elseif ischar(variables)
    if  ~strcmp(v1,'vlist')
        varname=v1;
        source=variables;
        freq=getfreq(source);

        misschars=getmeta(varname,'miss');
        missings=[];
        for i=1:size(misschars)
            xxx=find(strcmp(freq{1,1},deblank({misschars(i,:)})));
            if length(xxx)>0
                missings=[missings; (freq{1,4}{xxx})'];
            end
        end;
        weights=[];
        len=length(freq{1,3});
        for i=1:len
            weights(i,1)=i;
        end;
        weights=[weights freq{1,3}];
        weights=sortrows(weights,2);

        control=1;
        while control>0
            missingvalue=freq{1,1}(weights(len,1),:);
            control=length(find(strcmp(misschars,{deblank(missingvalue)})));
            len=len-1;
        end;

        if control~=0 y=variables; return; end;

        len=length(missingvalue);
        for i=1:length(missings)
            source(missings(i,1),1:len)=missingvalue;
        end;
        svs=char(source);
    else
        % vlist  %
        if nargin==2 
            prefix='r_'; 
            type=0;
        elseif nargin==3 
                if isnumeric(v2) type=v2; prefix='r_';
                else prefix=v2; type=0; end;
        else 
            type=v2;
            prefix=v3;
        end;

        svs=[];
        [a,b]=size(variables);
        for i=1:a
            eval(['global ', deblank(variables(i,:)),';']);
            str=['if isnumeric(',deblank(variables(i,:)),') ', ...
                        'temp=repmiss(',deblank(variables(i,:)),',type); ' ...
                  'else ' ...
                        'temp=repmiss(',deblank(variables(i,:)),',deblank(variables(i,:)));' ...
                  'end;'];
            eval([str]);

            newvname=[prefix, deblank(variables(i,:))];
            evalin('base',['global ',newvname,';']); 
            eval([newvname,'=temp;']);
            eval(['assignin(''base'',''',newvname,''',',newvname,');']);
            svs=addlist(svs,newvname);
        end;
    end;
end; 
y=svs;