function struct=nnet(net,in,out,type,n)

if nargin==3,type=1;n=1;end

global INP;
global OUTP;
global TempINP;
global TempOUTP;
global MainIndex;

[row col]=size(in);
for i=1:row
    eval(['global ', deblank(in(i,:)),';']);
    if i==1
        str=[in(i,:)];
    else
        str=[str, ';', in(i,:)];
    end
end

eval(['INP= [',str,']'';']);
OUTP=out';
TempINP =INP ;
TempOUTP=OUTP;
errStats=[];

for i=1:size(TempINP)
    MainIndex(i,1)=i;
end

vlist=crelist(['INP OUTP']);
tmpvlist=crelist(['TempINP TempOUTP MainIndex']);

for i=1:n
    percent=100/(n-i+1);
    net=init(net);
    if n==1, percent=10; end
    
    if type==1
        tempIndex=sample('MainIndex',percent,1,'s');
        trainIndex=restsample(vlist,MainIndex([tempIndex]),'');
        testIndex=MainIndex([tempIndex]);
        tempIndex=restsample(tmpvlist,tempIndex,'');        
    else
        tempIndex=sample('MainIndex',100,0,'s');
        testIndex=restsample(vlist,MainIndex([tempIndex]),'');
        trainIndex=MainIndex([tempIndex]);    
    end

    TrInput=INP([trainIndex],:)';
    TrOutput=OUTP([trainIndex])';
    TsInput=INP([testIndex],:)';
    TsOutput=OUTP([testIndex])';

    TrNet = train(net,TrInput,TrOutput);

    TrY = sim(TrNet,TrInput);
    TsY = sim(TrNet,TsInput);

    errTr = TrOutput - TrY;
    errTs = TsOutput - TsY;

    mseTs=mean(errTs.^2);
    rmseTs=sqrt(mseTs);
    maeTs=mean(abs(errTs));
    rseTs=sum(errTs.^2) / sum((TsOutput-mean(TsOutput)).^2);
    rrseTs=sqrt(rseTs);
    raeTs=sum(abs(errTs)) / sum(abs(TsOutput-mean(TsOutput)));

    SPATs=sum(  ( (errTs+TsOutput)-mean(errTs+TsOutput) )  .*  (TsOutput-mean(TsOutput))  )  /  (length(TsOutput)-1);
    SPTs =sum(  ( (errTs+TsOutput)-mean(errTs+TsOutput) ).^2 ) / (length(TsOutput)-1);
    SATs =sum(  ( (TsOutput)-mean(TsOutput)).^2 ) / (length(TsOutput)-1);
    cocoTs=( SPATs / sqrt(SPTs*SATs) );
    
    if type==1
        errStats=[errStats ; mseTs  rmseTs  maeTs  rseTs  rrseTs  raeTs  cocoTs];
    else
        mseTr=mean(errTr.^2);
        rmseTr=sqrt(mseTr);
        maeTr=mean(abs(errTr));
        rseTr=sum(errTr.^2) / sum((TrOutput-mean(TrOutput)).^2);
        rrseTr=sqrt(rseTr);
        raeTr=sum(abs(errTr)) / sum(abs(TrOutput-mean(TrOutput)));
            SPATr=sum(((errTr+TrOutput)-mean(errTr+TrOutput)) .* (TrOutput-mean(TrOutput))) / (length(TrOutput)-1);
            SPTr =sum(((errTr+TrOutput)-mean(errTr+TrOutput)).^2) / (length(TrOutput)-1);
            SATr =sum(((TrOutput)-mean(TrOutput)).^2) / (length(TrOutput)-1);
        cocoTr=( SPATr / sqrt(SPTr*SATr) );
        
        mseErr=0.632*mseTr+0.368*mseTs;
        rmseErr=0.632*rmseTr+0.368*rmseTs;
        maeErr=0.632*maeTr+0.368*maeTs;
        rseErr=0.632*rseTr+0.368*rseTs;
        rrseErr=0.632*rrseTr+0.368*rrseTs;
        raeErr=0.632*raeTr+0.368*raeTs;
        coco=0.632*cocoTr+0.368*cocoTs;
        
        errStats=[errStats ; mseErr rmseErr maeErr rseErr rrseErr raeErr coco];
    end

    for i=1:size(tmpvlist,1)
        curvname=deblank(tmpvlist(i,:));
        eval([curvname,'=',curvname,'([',int2str(tempIndex),'],:);']);
    end
end

if n~=1, errStats=mean(errStats); end

struct.net      =TrNet;
struct.msErr    =errStats(1);
struct.rmsErr   =errStats(2);
struct.maErr    =errStats(3);
struct.rsErr    =errStats(4);
struct.rrsErr   =errStats(5);
struct.raErr    =errStats(6);
struct.coco  =errStats(7);

evalin('base','clear svlist');
evalin('base','clear sMainIndex');
