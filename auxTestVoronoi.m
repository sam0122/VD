%Puntos de prueba

n = 200;
p = zeros(n,2);
rng(0.5,'twister');
p(:,1) = rand(n,1);
p(:,2) = rand(n,1);
voronoi(p(:,1), p(:,2));
%[v,c] = voronoin([p(:,1) p(:,2)]);