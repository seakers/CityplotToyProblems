function [metrics]=downSelLargeEffect(archs)
%%assume arch \in {0,1}^10 as a row vector
%%can accept a list of architectures as a matrix where instances are down
%%rows.
% w=[ 0.1070    0.0050    0.8170    0.0840    0.2600    0.4310    0.1820    0.1460    0.8690    0.5500;
%     0.9620    0.7750    0.8690    0.4000    0.8000    0.9110    0.2640    0.1360    0.5800    0.1450]';

w=ones(10,2);
w=sort(w,'descend'); 
w=w.*10.^(repmat(linspace(0,-3,10)',1,2));
w(:,2)=flipud(w(:,2));
w=w/w(end);

metrics=archs*w;
end