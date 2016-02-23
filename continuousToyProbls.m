%% find the pareto frontier. Notice that the rosenbrock and dixon price functions are convex.
%lets make x in R^5 where x_i in [-5,5]
addpath('../VisCodes');
addpath('../stdTestProbs/simonFrasier')

%%define functions
multiObj=@(x) [permdb(x');dixonprice(x');rosenbrock(x');linspace(0,10,5)*abs(x)'];

%% find pareto
% options = gaoptimset('PopulationSize',65,'PlotFcns',{@gaplotpareto,@gaplotscorediversity});
options = gaoptimset('PopulationSize',550);
[paretoArchs,vals]=gamultiobj(multiObj,5,[],[],[],[],-5*ones(5,1),5*ones(5,1),options);
[paretoArchs,pInd]=unique(paretoArchs,'rows');
vals=vals(pInd,:);

% make plots
% save('continuousDataset.mat');

% scatter3(vals(:,1),vals(:,2),vals(:,3),[],vals(:,3),'.','MarkerSize',1000);
scatter3(vals(:,1),vals(:,2),vals(:,3),1000,vals(:,3),'.');
xlabel('perm');
ylabel('dixon-price');
zlabel('rosenbrock');
colorbar;
% savefig('contiToyScatter.fig');
% print('-dmeta','contiToyScatter.emf');

cityplot3d(squareform(pdist(paretoArchs)),multiObj(paretoArchs)',paretoArchs);
% savefig('contiToyCityplot.fig');
% print('-dmeta','contiToyCityplot.emf');

cityplot3dInterpreter(squareform(pdist(paretoArchs)),multiObj(paretoArchs)',paretoArchs);
% savefig('contiToyCityplot_interp.fig');
% print('-dmeta','contiToyCityplot_interp.emf');