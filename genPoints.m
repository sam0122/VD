function [V,D] = genPoints( np,a,b,fA)
C = zeros(np,1);
xp =  0.4*a+(0.6*a-0.4*a)*rand(1);
yp =  0.4*b+(0.6*b-0.4*b)*rand(1);
C(1,1) = xp;
C(1,2) = yp;
n = round(np/4);
N = zeros(4,1);
for i = 1:4
    N(i,1) = n;  
end
dif = n*4 - np;
%Dirección principal -37°< x < 37°
dcP = -50 +(50 + 50)*rand(1);
rP = 0.1*a;
rS = rP/fA;

for i = 1:dif
    indx = randi([1,4],1);
    N(indx,1) = N(indx,1) - 1;
end
r  = 2;
%N(i) representa el número de puntos en el cuadrante i
%Cuadrante I
for i = 1:N(1,1)
    ang = (dcP-45) +((dcP+45) - (dcP-45))*rand(1);
    C(r,1) = cosd(ang)*rP + C(1,1);
    C(r,2) = sind(ang)*rP + C(1,2);
    r = r+1;
end
%Cuadrante II
for i = 1:N(2,1)
    ang =  (dcP+45) +((dcP+135) - (dcP+45))*rand(1);
    C(r,1) = cosd(ang)*rS + C(1,1);
    C(r,2) = sind(ang)*rS + C(1,2);
    r = r+1;
end
%Cuadrante III
for i = 1:N(3,1)
    ang =  (dcP+135) +((dcP+225) - (dcP+135))*rand(1);
    C(r,1) = cosd(ang)*rP + C(1,1);
    C(r,2) = sind(ang)*rP + C(1,2);
    r = r+1;
end
%Cuadrante IV
for i = 1:N(4,1)
    ang =   (dcP+225) +((dcP+315) - (dcP+225))*rand(1);
    C(r,1) = cosd(ang)*rS + C(1,1);
    C(r,2) = sind(ang)*rS + C(1,2);
    r = r+1;
end

plot(C(1,1),C(1,2),'*');
hold on;
plot(C(:,1),C(:,2),'.');
hold on;
voronoi(C(:,1),C(:,2));
[V,D] = voronoin(C);
axis equal


colors = [10 10 10 NaN NaN NaN NaN NaN NaN NaN NaN]';

% To store handles to the generated patches
pHandle = nan(1, numel(D));

for i = 1:numel(D)
if all(D{i}~=1)
    pHandle(i) = patch(V(D{i},1), V(D{i},2), colors(i)); 
end
end
colorbar 
% New colors for the patches (mx3 matrix)
colors = [1 2 NaN NaN 9 NaN NaN 10 NaN NaN ]';

% Recolor the closed regions
closedIdx = find(~isnan(pHandle));
arrayfun(@(i) set(pHandle(i),   'FaceColor','flat','FaceVertexCData',colors(i,:),'CDataMapping','scaled'),closedIdx);

%{
for i = 1:(np-1)
    

end
%}

end

