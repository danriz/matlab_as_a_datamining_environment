function y=getfreq(var)
%GETFREQ Get the frequency of variables.
%   freq=getfreq(X) returns the distinct values of the variable with
%   their frequencies, percentages and indices in a cell array. 
%
%   X can be a k-by-p matrix, so the function looks the whole row and finds
%   the duplicated values.
%
%   Example:
%   X = ['F';'M';'M';'F';'F';'M';'F';'M';'M';'M';'M';'M'];
%   freq = getfreq(X)
%   Returns the distinct values of X which are 'F' and 'M', Their
%   frequencies which are 4 for 'F' and 8 for 'M'. Their percentages which 
%   are 33.3333 for 'F' and 66.6667 for 'M', and their indices which are 
%   1,4,5,7 for 'F' and 2,3,6,8,9,10,11,12 for 'M' as a cell array. 
%
%   Copyright 2001-2006 The SVS, Inc. 
%   Revision: 1.0.1.3   Date: 2006/05/18 15:30:12

cat=var(1,:);           % Deðiþkenin ilk deðeri aslýnda ilk kategorimiz.

for i=2:size(var,1)     % Deðiþken kaç satýrdan oluþuyorsa hepsine tek tek bakýyoruz.
    itemexist=0;        % Deðiþkenin deðerinin kategoriler arasýnda olup olmadýðýný anlamak için.
    
    for j=1:size(cat,1) % Deðiþkenin herbir deðeri için bütün kategorilere tek tek bakýyoruz.
        if var(i,:)==cat(j,:)
            itemexist=1;
            break;      % Deðiþkenin o anki deðeri kategoriler arasýnda mevcutsa diðer kategorilere bakmaya gerek yok
        end
    end
    
    if ~itemexist
        cat=[cat;var(i,:)]; % Eðer deðiþkenin seçilen deðeri kategoriler arasýnda yoksa ekliyoruz.    
    end        
end   

indexes=0;  % Herbir kategorinin indekslerini tutmak için
itotal=0;

for i=1:size(cat,1)
    k=1;
    
    for j=1:size(var,1)
        if cat(i,:)==var(j,:)   % Herbir kategoriyi deðiþkenimizin deðerleri arasýnda arýyoruz.
            indexes(k)=j;       % Eðer bulursak indeksini deðiþkenimize ekliyoruz.
            k=k+1;
        end
    end
    
    allindexes{i,1}=indexes;      % Birden fazla kategori olacaðý için herbir kategorinin indekslerini cell array þeklinde tutuyoruz.
    itemscount(i,1)=numel(indexes);   % Ayrýca herbir kategorinin kaç elemandan oluþtuðunu da cell array e ekliyoruz.
    itotal=itotal+itemscount(i,1);
    indexes=0;
end

for i=1:size(cat,1)
    ipercent(i,1)=(itemscount(i,1)/itotal)*100;
end

y={cat,itemscount,ipercent,allindexes}; % Sonuç olarak kategorileri, kategorilerin frequency lerini, yüzdelerini ve 
                                        % herbir kategorinin indekslerini cell array þeklinde geri döndürüyoruz.  
