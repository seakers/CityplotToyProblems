%% number of archs
numArch=30;
archLen=10;
%% random architectures
% archs=[];
% while(size(archs,1)<numArch)
%     archs=[archs;rand(30-size(archs,1),archLen)>.5];
%     archs=unique(archs,'rows');
% end

%% all architectures
allArchs=reshape(str2num(reshape(dec2bin(0:(2^archLen-1)),10*2^archLen,1)),2^archLen,10);

%% paerto optimum of constrained
% numToUse=2;
% decSel=nchoosek(1:archLen,numToUse);
% archs=zeros(size(decSel,1),archLen);
% archs(sub2ind(size(archs),ceil([1:(size(decSel,2)*size(archs,1))]/size(decSel,2))',reshape(decSel',size(decSel,2)*(size(archs,1)),[])))=1; % turns the decSel values to 1.

%% cacluate metrics
allMets=downSelLargeEffect(allArchs); % used 1's as base for w.

%% get pareto arch (if necessary)
isP=paretofront(allMets);
pIndx=find(isP);
archs=allArchs(isP,:);
mets=allMets(isP,:);

%% baseline just using hamming norm
dist=squareform(pdist(real(archs),'hamming')*10);
cityplot3d(dist,mets,archs)
savefig('toyCityplot_downSelRegDist_sammon.fig');

%% weigting by max prev value. Should cluster nearly exactly
compIdx=nchoosek(1:size(archs,1),2);
weightedDist=real(xor(archs(compIdx(:,1),:),archs(compIdx(:,2),:)))*10.^(linspace(0,-3,10)');
% weightedDist=real(xor(archs(compIdx(:,1),:),archs(compIdx(:,2),:)))*(10:-1:1)';
dist2=zeros(size(archs,1));
for(i=1:length(weightedDist))
    dist2(compIdx(i,1),compIdx(i,2))=weightedDist(i);
end
dist2=dist2+dist2';

cityplot3d(dist2,mets,archs);
savefig('toyCityplot_downSelExpDist_sammon.fig');