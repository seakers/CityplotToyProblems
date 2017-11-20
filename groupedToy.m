group1indxs=[1,2,3];
group2indxs=[4,5,6];
group3indxs=[7,8,9];
flexIndxs=[10,11,12];

% group1indxs=[1,2,3,4,5];
% group2indxs=[4,5,6,7,8];
% group3indxs=[7,8,9,9,10];
% flexIndxs=[10,11,12,13,14,15];

numArchInBase=2^length(flexIndxs);
numArch=numArchInBase*3;
numDec=max([group1indxs,group2indxs,group3indxs,flexIndxs]);

archs=zeros(numArch,numDec);

base=reshape(str2num(reshape(dec2bin(0:(2^length(flexIndxs)-1)),length(flexIndxs)*2^length(flexIndxs),1)),2^length(flexIndxs),length(flexIndxs));

it=1;
archs(it:(it+numArchInBase-1),group1indxs)=1; archs(it:(it+numArchInBase-1),flexIndxs)=base; it=it+numArchInBase;
archs(it:(it+numArchInBase-1),group2indxs)=1; archs(it:(it+numArchInBase-1),flexIndxs)=base; it=it+numArchInBase;
archs(it:(it+numArchInBase-1),group3indxs)=1; archs(it:(it+numArchInBase-1),flexIndxs)=base; it=it+numArchInBase;

weights1=2.^[0:(numDec-1)];
m2=archs*(weights1');
metrics=[m2,max(max(m2))-m2,sum(archs,2)];
% pRank=compute_pareto_rankings(metrics,size(metrics,1));
% metrics=[metrics,max(pRank)-pRank];

isP=paretofront(metrics);
pIndx=find(isP);
pArchs=archs(isP,:);
pMets=metrics(isP,:);

dist=squareform(pdist(real(pArchs),'hamming')*numDec);
redLoc=mdscale(dist,2,'Criterion','sammon');

figure();
hold on
it=1;
plot(redLoc(it:(it+numArchInBase-1),1),redLoc(it:(it+numArchInBase-1),2),'b.'); it=it+numArchInBase;
plot(redLoc(it:(it+numArchInBase-1),1),redLoc(it:(it+numArchInBase-1),2),'r.'); it=it+numArchInBase;
plot(redLoc(it:(it+numArchInBase-1),1),redLoc(it:(it+numArchInBase-1),2),'g.'); it=it+numArchInBase;

writeCityplotStuff('groupedToy',pArchs,dist,-pMets,{'obj1','obj2','count'},{'Criterion','sammon'});