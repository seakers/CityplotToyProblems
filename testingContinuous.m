%% parameters
% for Dixon-Price
indx=1:5;
[iX,iY]=meshgrid(indx,indx);

dpMat=iX.^iY;

% %% define objective function--bigger and better
f=@(x) [sum(sum((dpMat+.5).*((repmat(x,5,1)./iX).^iY-1),2).^2,1);
        (x(1)-1)^2+dot(indx(2:end),(2*x(2:end).^2-x(1:(end-1))).^2);
        sum(100*(x(2:end)-x(1:(end-1)).^2).^2+(x(1:(end-1))-1).^2);
        100*norm(x+3*ones(1,5),1)^4;
        100*norm(x+[-1,-1,0,1,1])^4;
        dot(2.5*indx-2.5,abs(x))];

%% define objective function--original
% f=@(x) [sum(sum((dpMat+.5).*((repmat(x,5,1)./iX).^iY-1),2).^2,1);
%         (x(1)-1)^2+dot(indx(2:end),(2*x(2:end).^2-x(1:(end-1))).^2);
%         sum(100*(x(2:end)-x(1:(end-1)).^2).^2+(x(1:(end-1))-1).^2);
%         dot(2.5*indx-2.5,abs(x))];

%% optimize
options=gaoptimset('PopulationSize',500,'InitialPopulation',[1:5;2.^-((2.^[1:5]-2)./2.^[1:5]);ones(1,5);-3*ones(1,5);[-3,-3,0,3,3];zeros(1,5)]);
[pArchs,vals]=gamultiobj(f,5,[],[],[],[],-5*ones(5,1),5*ones(5,1),options);

%% post processing
% take a sample of the pareto front whch spans the space well.
% eh screw it. my head hurts and this seems to be the topological set cover
% I think it's related to delauney triangulation but I'll just do random
targetNum=150;
savArchs=pArchs;
savVals=vals;

smplIndx=randsample(size(savArchs,1),targetNum);
pArchs=savArchs(smplIndx,:);
vals=savVals(smplIndx,:);

%% make scatter plot
% scatter3(vals(:,1),vals(:,2),vals(:,3),1000,vals(:,4),'.');
scatter3(vals(:,1),vals(:,2),vals(:,3),vals(:,6)+eps,vals(:,5),'.');
xlabel('perm');
ylabel('dixon-price');
zlabel('rosenbrock');
colorbar;
% savefig('contiToy_Scatter_6objNorms_full.fig');

%% make cityplot
cityplot3d(squareform(pdist(pArchs)),vals,pArchs);
% savefig('contiToy_Cityplot_6objNorms_full.fig');
cityplot3d(squareform(pdist(pArchs)),vals(:,1:3),pArchs);
% savefig('contiToy_Cityplot_6objNorms_full3Obj.fig');

%% make cityplot of the parts which are in the big block
care=[1,2,3,6];
minObj=min(vals,[],1);
maxObj=max(vals,[],1);
nVals=(vals-repmat(minObj,size(vals,1),1))./repmat(maxObj-minObj,size(vals,1),1);

[minObj,whichOpt]=min(nVals,[],2);
keep=ismember(whichOpt,care);

cityplot3d(squareform(pdist(pArchs)),keep,pArchs); % verfiy which points to keep
% savefig('contiToy_Cityplot_6objNorms_origObj.fig');

figure
% scatter3(vals(:,1),vals(:,2),vals(:,3),1000,vals(:,4),'.');
scatter3(vals(keep,1),vals(keep,2),vals(keep,3),1000,vals(keep,5),'.');
xlabel('perm');
ylabel('dixon-price');
zlabel('rosenbrock');
colorbar;
% savefig('contiToy_scatter_6objNorms_origObj.fig');

%% make cityplot
cityplot3d(squareform(pdist(pArchs(keep,:))),vals(keep,care),pArchs(keep,:));
% savefig('contiToy_Cityplot_6objNorms_keep3obj.fig');