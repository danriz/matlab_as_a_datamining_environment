function  [svs]=regression(y,vlist,crss_btstrp,n,categoric)
  
    if nargin<2
        error('Too few parameters.');
    end;


    if nargin<3 || crss_btstrp==0
        len=size(vlist);
        str=[];
        for i=1:len
            eval(['global ', deblank(vlist(i,:)),';']);
            str=[str, ' ', deblank(vlist(i,:))];
        end;
        X=eval(['[',str,'];']);
        X=[ones(size(X),1) X];
        [b,bint,r]=regress(y,X);
        mse=mean(r.^2);
        rmse=sqrt(mse);
        mae=mean(abs(r));
        rse=sum(r.^2) / sum( (y-mean(y)).^2 );
        rrse=sqrt(rse);
        rae=sum(abs(r)) / sum(abs( y-mean(y) ));
        
        SPA=sum(  ( (r+y)-mean(r+y) )  .*  (y-mean(y))  )  /  (length(y)-1);
        SP =sum(  ( (r+y)-mean(r+y) ).^2 ) / (length(y)-1);
        SA =sum(  ( (y)-mean(y)).^2 ) / (length(y)-1);
        
        coco=( SPA / sqrt(SP*SA) );
        svs.beta=b';
        svs.mse =mse;
        svs.rmse=rmse;
        svs.mae =mae;
        svs.rse =rse ;
        svs.rrse=rrse;
        svs.rae =rae ;
        svs.coco=coco;
        
    else
        if nargin <4
                error('Missing parameters.'); 
        elseif crss_btstrp==1 || crss_btstrp==2   
            
            if n<2
                error('n must be at least 2.');
            else    
                for i=1:size(vlist,1)
                    curvname=deblank(vlist(i,:));
                    newvname=['tmp' curvname];
                    eval(['global ',curvname,';']);
                    eval(['global ',newvname,';']);
                    eval([newvname,'=',curvname,';']);
                    tmpvlist(i,:)=['tmp' vlist(i,:)];
                end;
                
                global tmpindex;
                tmpindex=[];
                for i=1:length(eval([newvname]))
                    tmpindex(i,1)=i;
                end;
                tmpvlist=addlist(tmpvlist,'tmpindex');
                
                svsstats=[];
                svsb=[];
                
                folds=n;            
                for i=1:n
                    if crss_btstrp==1 
                        if nargin==5
                            temp=stfsample('tmpindex',100/folds,1,'s',categoric);
                        else
                            temp=sample('tmpindex',100/folds,1,'s');
                        end;
                    elseif crss_btstrp==2
                        temp=sample('tmpindex',100,0,'s');
                    end;
                    
                    evalin('base','clear svlist');
                    evalin('base','clear stmpindex');
                    if crss_btstrp==1 
                        train=restsample(vlist,tmpindex([temp]),'');
                        test=tmpindex([temp]);
                        temp=restsample(tmpvlist,temp,'');
                    elseif crss_btstrp==2
                        test=restsample(vlist,tmpindex([temp]),'');
                        train=tmpindex([temp]);
                    end;
                    
                    len=size(vlist);
                    str=[];
                    for i=1:len
                        str=[str, ' ', deblank(vlist(i,:)),'([train])'];
                    end;
                    X=eval(['[',str,'];']);
                    X=[ones(size(X),1) X];
                    ytrain=y([train]);
                    
                    [b,bint,r]=regress(ytrain,X);
                    svsb=[svsb b];
                    
                    if crss_btstrp==2
                        
                        mseTr=mean(r.^2);
                        rmseTr=sqrt(mseTr);
                        maeTr=mean(abs(r));
                        rseTr=sum(r.^2) / sum( (ytrain-mean(ytrain)).^2 );
                        rrseTr=sqrt(rseTr);
                        raeTr=sum(abs(r)) / sum(abs( ytrain-mean(ytrain) ));

                        SPATr=sum(  ( (r+ytrain)-mean(r+ytrain) )  .*  (ytrain-mean(ytrain))  )  /  (length(ytrain)-1);
                        SPTr =sum(  ( (r+ytrain)-mean(r+ytrain) ).^2 ) / (length(ytrain)-1);
                        SATr =sum(  ( (ytrain)-mean(ytrain)).^2 ) / (length(ytrain)-1);

                        cocoTr=( SPATr / sqrt(SPTr*SATr) );
                     
                    end;
                    
                    str=[];
                    for i=1:len
                        str=[str, ' ', deblank(vlist(i,:)),'([test])'];
                    end;
                    X=eval(['[',str,'];']);
                    X=[ones(size(X),1) X];
                    ytest=y([test]);
                    r=(X*b)-ytest;
                    
                    mseTs=mean(r.^2);
                    rmseTs=sqrt(mseTs);
                    maeTs=mean(abs(r));
                    rseTs=sum(r.^2) / sum( (ytest-mean(ytest)).^2 );
                    rrseTs=sqrt(rseTs);
                    raeTs=sum(abs(r)) / sum(abs( ytest-mean(ytest) ));

                    SPATs=sum(  ( (r+ytest)-mean(r+ytest) )  .*  (ytest-mean(ytest))  )  /  (length(ytest)-1);
                    SPTs =sum(  ( (r+ytest)-mean(r+ytest) ).^2 ) / (length(ytest)-1);
                    SATs =sum(  ( (ytest)-mean(ytest)).^2 ) / (length(ytest)-1);

                    cocoTs=( SPATs / sqrt(SPTs*SATs) );
                    
                    if crss_btstrp==1
                        svsstats=[svsstats ; mseTs  rmseTs  maeTs  rseTs  rrseTs  raeTs  cocoTs];
                    elseif crss_btstrp==2
                        mseErr=0.632*mseTr+0.368*mseTs;
                        rmseErr=0.632*rmseTr+0.368*rmseTs;
                        maeErr=0.632*maeTr+0.368*maeTs;
                        rseErr=0.632*rseTr+0.368*rseTs;
                        rrseErr=0.632*rrseTr+0.368*rrseTs;
                        raeErr=0.632*raeTr+0.368*raeTs;
                        cocoErr=0.632*cocoTr+0.368*cocoTs;
                        svsstats=[svsstats ; mseErr rmseErr maeErr rseErr rrseErr raeErr cocoErr];
                    end;
                    
                    for i=1:size(tmpvlist,1)
                        curvname=deblank(tmpvlist(i,:));
                        eval([curvname,'=',curvname,'([',int2str(temp),']);']);
                    end;
                    if nargin==5 categoric=categoric([temp],:); end;
                   
                    folds=folds-1;
                end;
                svsstats=mean(svsstats);
                svsb=(mean(svsb'))';
                svs.beta=svsb';
                svs.mse =svsstats(1);
                svs.rmse=svsstats(2);
                svs.mae =svsstats(3);
                svs.rse =svsstats(4);
                svs.rrse=svsstats(5);
                svs.rae =svsstats(6);
                svs.coco=svsstats(7);
               
            end;
     
            
        end;
        clear tmpindex;
    end;
    
    