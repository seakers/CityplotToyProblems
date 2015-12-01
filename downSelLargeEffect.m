function [metrics]=downSelLargeEffect(archs)
%%assume arch \in {0,1}^10 as a row vector
%%can accept a list of architectures as a matrix where instances are down
%%rows.
% result is a sum of weights of 
%   1.000000000000000   0.001000000000000
%   0.464158883361278   0.002154434690032
%   0.215443469003188   0.004641588833613
%   0.100000000000000   0.010000000000000
%   0.046415888336128   0.021544346900319
%   0.021544346900319   0.046415888336128
%   0.010000000000000   0.100000000000000
%   0.004641588833613   0.215443469003188
%   0.002154434690032   0.464158883361278
%   0.001000000000000   1.000000000000000

w=10.^(repmat(linspace(0,-3,10)',1,2));
% w=2.^(repmat(linspace(0,-9,10)',1,2));
w(:,2)=flipud(w(:,2));
w=w/w(end);

metrics=[archs*w,sum(archs<=0,2)];
end