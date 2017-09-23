archLen=6;

%% currently in paper
w1=archLen.^(-([1:archLen]-1)/3);
w2=archLen.^(-(archLen-[1:archLen])/3); %should be
w3=normpdf([0.5:1:archLen],archLen/2,archLen/2);
w=[w1',w2',w3'];

oldClrMap=hsv2rgb([linspace(0,2/3,64)',ones(64,2)]);
% oldClrMap=flipud(colormap('cool'));
%% architectures
archs=reshape(str2num(reshape(dec2bin(0:(2^archLen-1)),archLen*2^archLen,1)),2^archLen,archLen);

mets=[archs*w,archLen-sum(archs,2)];

isP=paretofront(mets);
pIndx=find(isP);
pArchs=archs(isP,:);
pMets=mets(isP,:);

%% reporting
disp('number pareto architectures')
sum(isP)

%% plot objectives in 2d plot with color
% hold on
% scatter(mets(:,1),mets(:,2),[],mets(:,3));
% plot(mets(isP,1),mets(isP,2),'.');
% colorbar
% hold off

%% plot in 3d to see just what's happening
% figure
% hold on
% plot3(mets(:,1),mets(:,2),mets(:,3),'b.')
% plot3(mets(isP,1),mets(isP,2),mets(isP,3),'r.')
% hold off

%% examine a single numebr. 
% This is where my logic broke down.
% I was right for 1 or 9, but suppose we get 2 choices. Fix on position and
% the others flare out exponentially. Follows there's a cheapest option
% that dominates. This is evident when plotting anything other than 1 or 9

isNum=sum(archs,2)==2;
indxNum=find(isNum);
figure
hold on
plot3(mets(isNum,1),mets(isNum,2),mets(isNum,3),'b.')
plot3(mets(isNum & isP,1),mets(isNum & isP,2),mets(isNum & isP,3),'r.')

for(in=indxNum) % plot arch with each point
    text(mets(in,1),mets(in,2),num2str(archs(in,:)));
end
hold off

%% plot the updated cityplots--hamming
dist=squareform(pdist(real(pArchs),'hamming')*archLen);
figure();
cityplot3d(dist,-pMets,'DesignLabels',pArchs,'MdscaleOptArgs',{'Criterion','sammon'}, 'RoadColors', oldClrMap);
% cityplot3d(dist,-pMets,'DesignLabels',pArchs,'RoadColors', oldClrMap);

%% plot the updated cityplot--by 1st weighting
% compIdx=nchoosek(1:size(pArchs,1),2);
% weightedDist_T=real(xor(pArchs(compIdx(:,1),:),pArchs(compIdx(:,2),:))*(w1'));
% dist2_T=zeros(size(pArchs,1));
% dist2_T(sub2ind(size(dist2_T),compIdx(:,1),compIdx(:,2)))=weightedDist_T;
% dist2_T=dist2_T+dist2_T';
% 
% ax_h=figure();
% cityplot3d(ax_h,dist2_T,-pMets,'DesignLabels',pArchs,'MdscaleOptArgs',{'Criterion','sammon'}, 'RoadLimit', ceil((176/2)^2), 'RoadColors', oldClrMap);

%% new plot to test transparency - old
% alphaFactor=0.2;
% 
% figure()
% hold on
% dist=squareform(pdist(real(pArchs),'hamming')*archLen);
% [h, plt,nMet, pltOpts, hdt]=cityplot3d(dist,-pMets,'DesignLabels',pArchs, 'MdscaleOptArgs',{'Criterion','sammon'}, 'BuildingProp', {'FaceAlpha', alphaFactor, 'EdgeAlpha', alphaFactor});
% 
% OrFirstTwo=sum(pArchs(:,1:2),2)>=1;
% 
% nodesWithBarGraph3d(h, plt(OrFirstTwo,:),nMet(OrFirstTwo,:),pltOpts.BuildingHeight);

%% new plot to test transparency - new
% OrFirstTwoArr=0.2+0.8*(sum(pArchs(:,1:2),2)>=1);
% cityplot3d(dist, -pMets, 'DesignLabels', pArchs, 'MdscaleOptArgs', {'Criterion', 'sammon'}, 'BuildingTransparency', OrFirstTwoArr);

%% writing the revised dataset for Cityplot VR Experiment
writeCityplotStuff('fullerDiscExpTrade_sammon',pArchs,dist,-pMets,{'blue1','red2','green3','black4'},{'Criterion','sammon'})
writeCityplotStuff('fullerDiscExpTrade',pArchs,dist,-pMets,{'blue1','red2','green3','black4'},{})