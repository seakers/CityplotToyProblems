% archs=rand(30,10)>.5;
% archs=unique(archs,'rows');
mets=downSelLargeEffect(archs); % used 1's as base for w.

%% baseline just using hamming norm
dist=squareform(pdist(real(archs),'hamming')*10);
cityplot3d(dist,mets,archs)

%% weigting by max prev value. Should cluster nearly exactly
compIdx=nchoosek(1:30,2);
weightedDist=real(xor(archs(compIdx(:,1),:),archs(compIdx(:,2),:)))*2.^[9:-1:0]';
% weightedDist=real(xor(archs(compIdx(:,1),:),archs(compIdx(:,2),:)))*(10:-1:1)';
dist2=zeros(30);
for(i=1:length(weightedDist))
    dist2(compIdx(i,1),compIdx(i,2))=weightedDist(i);
end
dist2=dist2+dist2';

cityplot3d(dist2,mets,archs);