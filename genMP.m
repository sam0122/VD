function  genMP( np,a,b,fA )
%Generar agregados usando 3 sitios de Voronoi
%Vértice central del cluster de agregados
vx = 0.5*a;
vy = 0.5*b;
%Radio asociado al área del agregado
r = 0.1*(a+b)*0.5;
%Número de sitios que conforman el agregado
sAg = 4;
C = zeros(sAg,2);
%{
for i = 1:sAg
    ang = (360)*rand(1);
    C(i,1) = vx + cosd(ang)*r;
    C(i,2) = vy + sind(ang)*r;
end
%}
%Ensayo con tres puntos 90°
    ang = 80;
    C(1,1) = vx + cosd(ang)*r;
    C(1,2) = vy + sind(ang)*r;
    ang = 110;
    C(2,1) = vx + cosd(ang)*r;
    C(2,2) = vy + sind(ang)*r;
    ang = 260;
    C(3,1) = vx + cosd(ang)*r;
    C(3,2) = vy + sind(ang)*r;
    ang = 280;
    C(4,1) = vx + cosd(ang)*r;
    C(4,2) = vy + sind(ang)*r;
plot(C(:,1),C(:,2),'.');
hold on;
%{
th = 0:pi/50:2*pi;
xunit = r * cos(th) + vx;
yunit = r * sin(th) + vy;
plot(xunit, yunit);
axis equal;
%}
%Agregados exteriores
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
rw  = sAg + 1;
%N(i) representa el número de puntos en el cuadrante i
%Cuadrante I
for i = 1:N(1,1)
    ang = (dcP-45) +((dcP+45) - (dcP-45))*rand(1);
    C(rw,1) = cosd(ang)*2*r + vx;
    C(rw,2) = sind(ang)*2*r + vy;
    rw = rw+1;
end
%Cuadrante II
for i = 1:N(2,1)
    ang =  (dcP+45) +((dcP+135) - (dcP+45))*rand(1);
    C(rw,1) = cosd(ang)*2.5*r + vx;
    C(rw,2) = sind(ang)*2.5*r + vy;
    rw = rw+1;
end
%Cuadrante III
for i = 1:N(3,1)
    ang =  (dcP+135) +((dcP+225) - (dcP+135))*rand(1);
    C(rw,1) = cosd(ang)*2.5*r + vx;
    C(rw,2) = sind(ang)*2.5*r+ vy;
    rw = rw+1;
end
%Cuadrante IV
for i = 1:N(4,1)
    ang =   (dcP+225) +((dcP+315) - (dcP+225))*rand(1);
    C(rw,1) = cosd(ang)*2.5*r + vx;
    C(rw,2) = sind(ang)*2.5*r + vy;
    rw = rw+1;
end


%Dibujo del diagrama

plot(C(:,1),C(:,2),'.');
hold on;
voronoi(C(:,1),C(:,2));
[V,D] = voronoin(C);
axis equal
colors = zeros(1,np + sAg);
for j = 1:(np + sAg)

    if j <= sAg
        colors(1,j) = 0;
    else
        colors(1,j) = NaN;
    end
end
% To store handles to the generated patches


for i = 1:numel(D)
if all(D{i}~=1)
   p = patch;
   patch(V(D{i},1), V(D{i},2), colors(i)); 
   p.FaceColor = [rand(1) rand(1) rand(1)];
end
end
%colorbar 
% New colors for the patches (mx3 matrix)
%colors = [1 1 1 NaN NaN NaN NaN NaN NaN NaN NaN ]';

%{
 Recolor the closed regions
closedIdx = find(~isnan(pHandle));
arrayfun(@(i) set(pHandle(i),   'FaceColor','flat','FaceVertexCData',colors(i,:),'CDataMapping','scaled'),closedIdx)
%}
end

