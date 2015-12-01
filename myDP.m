function [output]=myDP(xRow)
outerSum=0;
for(i=1:size(xRow,2))
    innerSum=0;
    for(j=1:size(xRow,2))
        innerSum=innerSum+(j^i+.5)*((xRow(j)/j)^i-1);
    end
    outerSum=outerSum+innerSum^2;
end
output=outerSum;
end
    