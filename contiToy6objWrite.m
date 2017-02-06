% %% parameters
% % for Dixon-Price
% indx=1:5;
% [iX,iY]=meshgrid(indx,indx);
% 
% dpMat=iX.^iY;
% 
% %% define objective function--bigger and better
% f=@(x) [sum(sum((dpMat+.5).*((repmat(x,5,1)./iX).^iY-1),2).^2,1);
%         (x(1)-1)^2+dot(indx(2:end),(2*x(2:end).^2-x(1:(end-1))).^2);
%         sum(100*(x(2:end)-x(1:(end-1)).^2).^2+(x(1:(end-1))-1).^2);
%         100*norm(x+3*ones(1,5),1)^4;
%         100*norm(x+[-1,-1,0,1,1])^4;
%         dot(2.5*indx-2.5,abs(x))];
% 
% %% define objective function--original
% % f=@(x) [sum(sum((dpMat+.5).*((repmat(x,5,1)./iX).^iY-1),2).^2,1);
% %         (x(1)-1)^2+dot(indx(2:end),(2*x(2:end).^2-x(1:(end-1))).^2);
% %         sum(100*(x(2:end)-x(1:(end-1)).^2).^2+(x(1:(end-1))-1).^2);
% %         dot(2.5*indx-2.5,abs(x))];
% 
% %% optimize
% options=gaoptimset('PopulationSize',2500, 'generations', (5*100)*2,'InitialPopulation',[1:5;2.^-((2.^[1:5]-2)./2.^[1:5]);ones(1,5);-3*ones(1,5);[-3,-3,0,3,3];zeros(1,5)]);
% [pArchs,vals]=gamultiobj(f,5,[],[],[],[],-5*ones(5,1),5*ones(5,1),options);
% 
% %% post processing
% % take a sample of the pareto front whch spans the space well.
% % eh screw it. my head hurts and this seems to be the topological set cover
% % I think it's related to delauney triangulation but I'll just do random
% targetNum=150;
% savArchs=pArchs;
% savVals=vals;
% 
% smplIndx=randsample(size(savArchs,1),targetNum);
% pArchs=savArchs(smplIndx,:);
% vals=savVals(smplIndx,:);

% load('continuous_inPaperV5_0.mat')
load('continuous_6obj_1500_2pop.mat')

divisor=3.25;
oldClrMap=hsv2rgb([linspace(0,2/3,64)',ones(64,2)]);

writeCityplotStuff('continuous6obj',pArchs,squareform(pdist(pArchs)),vals,{'obj1','obj2','obj3','obj4','obj5','obj6'},[]);