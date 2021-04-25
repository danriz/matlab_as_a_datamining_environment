% örnek datalar:

% 1)
% global V1 V2 V3 C1;
% V1=[3;1;2;3;4;8;8;9;10;7];V2=[3;3;2;1;4;8;10;9;8;7];C1=['M';'M';'F';'M'
% ;'F';'F';'F';'F';'F';'F'];V3=[10,100;20,200;30,300;40,400;50,500;60,600;70,700;80,800;90,900;100,1000];vlist=['V1';'V2'];

% 2)
% V1=ceil(100*rand(100,1));V2=ceil(100*rand(100,1));V3=ceil(100*rand(100,1)
% );vlist=['V1';'V2';'V3'];

% =========================================================================

% if dtype is 1 then distance measure will be squared euclidean (default)
% if dtype is 2 then distance measure will be manhattan

function y=fkmeans(vlist,k,labelv,dtype,replics,controlv,cvtype)

if nargin<2
    error 'Minimum allowed number of Parameters is 2!'
elseif nargin>7
    error 'Maximum allowed number of Parameters is 7!'
end

vcount=size(vlist,1);
for i=1:vcount
    eval(['global ',vlist(i,:),';']);
    eval(['X(:,',int2str(i),')=',vlist(i,:),';']);
end  
      
if nargin<3 labelv=''; end
if nargin<4 dtype=1; end
if nargin<5 replics=[]; end
if nargin<6 controlv=''; end
if nargin<7 cvtype=[]; end

switch nargin
    case {2,3}
        [IDX,C,sumd,D] = kmeans(X,k,'display','final','emptyaction','singleton');
    
    case {4,5,6,7}
        if dtype==2
            if isscalar(replics)
                [IDX,C,sumd,D] = kmeans(X,k,'distance','city','display','final','emptyaction','singleton','replicates',replics);
            else
                [IDX,C,sumd,D] = kmeans(X,k,'distance','city','display','final','emptyaction','singleton');
            end
        else
            if isscalar(replics)
                [IDX,C,sumd,D] = kmeans(X,k,'display','final','emptyaction','singleton','replicates',replics);
            else
                [IDX,C,sumd,D] = kmeans(X,k,'display','final','emptyaction','singleton');
            end
        end
end

fr=getfreq(IDX);
csummary=[fr{1} fr{2}];
csummary=sortrows(csummary);

total=0;
for i=1:(k-1)
    CA=fr{4}{i};
    centA=C(i,:);
    for j=(i+1):k
        CB=fr{4}{j};
        centB=C(j,:);
        for a=1:numel(CA)
            PA=X(CA(a),:);
            for b=1:numel(CB)
                PB=X(CB(b),:);
                dist=mydist(PA,PB,dtype);
                total=total+dist;
                if a==1 & b==1
                    min=dist;                        
                    minA=CA(a);
                    minB=CB(b);                        
                    max=dist;
                    maxA=CA(a);
                    maxB=CB(b);                        
                elseif dist<min
                    min=dist;
                    minA=CA(a);
                    minB=CB(b);
                elseif dist>max
                    max=dist;
                    maxA=CA(a);
                    maxB=CB(b);                        
                end
            end                
        end
        singlelink(fr{1}(i),fr{1}(i))=0;
        singlelink(fr{1}(i),fr{1}(j))=min;
        singlelink(fr{1}(j),fr{1}(i))=min;            
        slpoints{fr{1}(i),fr{1}(j)}=[minA minB];
        slpoints{fr{1}(j),fr{1}(i)}=[minB minA];

        completelink(fr{1}(i),fr{1}(i))=0;
        completelink(fr{1}(i),fr{1}(j))=max;
        completelink(fr{1}(j),fr{1}(i))=max;            
        clpoints{fr{1}(i),fr{1}(j)}=[maxA maxB];
        clpoints{fr{1}(j),fr{1}(i)}=[maxB maxA];

        averagelink(fr{1}(i),fr{1}(i))=0;
        averagelink(fr{1}(i),fr{1}(j))=total/(numel(CA)*numel(CB));
        averagelink(fr{1}(j),fr{1}(i))=total/(numel(CA)*numel(CB));
        
        dist=mydist(centA,centB,dtype);
        centroitlink(i,i)=0;
        centroitlink(i,j)=dist;
        centroitlink(j,i)=dist;        
        
        total=0;
    end
end

for i=1:k
    radius(i,:)=sqrt(sumd(fr{1}(i))/fr{2}(i));
end

for i=1:k
    total=0;
    Cind=fr{4}{i};
    for j=1:numel(Cind)
        Clust(j,:)=X(Cind(j),:);
    end
    for m=1:size(Clust,1)
        PA=Clust(m,:);
        for n=1:size(Clust,1)
            PB=Clust(n,:);
            dist=mydist(PA,PB,dtype);
            total=total+dist;
        end
    end
    diameter(fr{1}(i),:)=sqrt(total/(size(Clust,1)*(size(Clust,1)-1)));
end

for i=1:numel(IDX)
    p2owncldist(i,1)=IDX(i);
    p2owncldist(i,2)=D(i,IDX(i));
end

svs.clusters=IDX;
svs.centers=C;
svs.distances=D;
svs.distwithincl=p2owncldist;
svs.sumdist=sumd;
svs.cfreq=csummary(:,2);
svs.singlelink=singlelink;
svs.slpoints=slpoints;
svs.completelink=completelink;
svs.clpoints=clpoints;
svs.averagelink=averagelink;
svs.centroitlink=centroitlink;
svs.radius=radius;
svs.diameter=diameter;

if k<8
    if size(X,2)==2                          % 2D
        colors=['b','r','k','m','g','c','y'];
        legnames='legend(';
        for i=1:k
            for j=1:numel(fr{4}{i})
                temp(j,:)=X(fr{4}{i}(j),:);
            end
            hold on;
            grid on;
            eval(['plot(temp(:,1),temp(:,2),''.',colors(i),''',''MarkerSize'',20);']);
            eval(['plot(C(fr{1}(i),1),C(fr{1}(i),2),''*',colors(i),''',''MarkerSize'',10);']);
            legnames=[legnames,'''Cluster-',int2str(fr{1}(i)),''',''Centroit-',int2str(fr{1}(i)),''','];
            temp=[0,0];
        end
        legnames=[legnames,'-1);'];
        eval(['xlabel(''',vlist(1,:),''');']);
        eval(['ylabel(''',vlist(2,:),''');']);
        eval([legnames]);
    end
    
    if size(X,2)==3                          % 3D
        colors=['b','r','k','m','g','c','y'];
        legnames='legend(';
        for i=1:k
            for j=1:numel(fr{4}{i})
                temp(j,:)=X(fr{4}{i}(j),:);
            end
            hold on;
            grid on;
            eval(['plot3(temp(:,1),temp(:,2),temp(:,3),''.',colors(i),''',''MarkerSize'',20);']);
            eval(['plot3(C(fr{1}(i),1),C(fr{1}(i),2),C(fr{1}(i),3),''*',colors(i),''',''MarkerSize'',10);']);
            legnames=[legnames,'''Cluster-',int2str(fr{1}(i)),''',''Centroit-',int2str(fr{1}(i)),''','];
            temp=[0,0,0];
        end
        legnames=[legnames,'-1);'];
        eval(['xlabel(''',vlist(1,:),''');']);
        eval(['ylabel(''',vlist(2,:),''');']);
        eval(['zlabel(''',vlist(3,:),''');']);
        eval([legnames]);
    end
end

if ~isempty(controlv)
    switch cvtype
        case 1            
            clusters='';
            temp='';
            for i=1:size(fr{1},1)
                for j=1:fr{2}(i)
                    temp=strvcat(temp,controlv(fr{4}{i}(j)));
                end        
                clusters{fr{1}(i)}=temp;        
                cfr=getfreq(temp);
                cluster{fr{1}(i),1}={cfr{1} cfr{2} cfr{3}};    
                temp='';
            end
            contfreq=getfreq(controlv);

            for i=1:k
                contvsize=numel(contfreq{1});
                clustsize=numel(cluster{i}{1});
                if ~(contvsize==clustsize)
                    for j=1:contvsize
                        itemexist=0;
                        for m=1:clustsize
                            if contfreq{1}(j)==cluster{i}{1}(m)
                                itemexist=1;
                                break;
                            end
                        end
                        if ~itemexist 
                            cluster{i}{1}(end+1,:)=contfreq{1}(j);
                            cluster{i}{2}(end+1,:)=0;
                            cluster{i}{3}(end+1,:)=0;
                        end
                    end
                end
            end
            svs.cvfreqing={contfreq{1} contfreq{2} contfreq{3}};
            svs.cvfreqinc=cluster;
        
        case 2
            temp=[];
            for i=1:size(fr{1},1)
                for j=1:fr{2}(i)
                    temp=[temp;controlv(fr{4}{i}(j),:)];
                end        
                cluster(fr{1}(i),:)=mean(temp);        
                temp=[];
            end
            svs.cvmean=cluster;
        
        otherwise
            error 'You have to define the type of control variable ! \n(1:categorical,2:continuous)'                
    end
end

if ~isempty(labelv)
    fresult='';
    for i=1:numel(IDX)
        if ischar(labelv) 
            fresult=strvcat(fresult,[labelv(i,:),' --> ',int2str(IDX(i))]);            
        else
            fresult=strvcat(fresult,[int2str(labelv(i,:)),' --> ',int2str(IDX(i))]);            
        end
    end
    svs.result=fresult;
else
    fresult='';
    for i=1:numel(IDX)
        fresult=strvcat(fresult,[int2str(i),' --> ',int2str(IDX(i))]);        
    end
    svs.result=fresult;
end

y=svs;

%=========================================================================

function dist=mydist(A,B,type)
    sumdist=0;
    switch type
        case 1
            for x=1:numel(A)
                sumdist=sumdist+(A(x)-B(x))^2;
            end
        case 2
            for x=1:numel(A)
                sumdist=sumdist+abs((A(x)-B(x)));
            end
    end    
dist=sumdist;