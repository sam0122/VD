function genP()
%Genera una partícula con número de puntos internos y externos variables
%Parámetro de elongación
E = 0.8;
%Puntos internos
pIn = 12;
%Puntos externos
pEx = 15;
%Celda que contiene las celdas que conforman los agregados y las celdas que
%conforman los vacíos.
%C = cell(np,1);
%Generar arreglo de áreas, ordenadas de mayor a menor.Debe ser función de la granulometría
A = 0.05 +(0.1 - 0.05)*rand(1);
%A = sort(A,'descend');
%Semieje mayor
r1 = sqrt(A/(pi()*E));
%Semieje menor
r2 = r1 * E;
%Inclinación de la partícula
dcP = -37 +(37 + 37)*rand(1);
%Vector que contiene los puntos
p = zeros(pIn+ pEx + 1,2);
%Dimensiones de la caja
a = 1;
b = 1;
%Coordenadas del núcleo
vx = a*rand(1);
vy = b*rand(1);
p(1,1) = vx;
p(1,2) = vy;
%Ubicación de los puntos internos fijos
for i = 0:3
    %xt = vx + r1*cosd(i*90);
    %yt = vy + r2*sind(i*90);
    p(i+2,1) =  r1*cosd(i*90)*cosd(dcP) - r2*sind(i*90)*sind(dcP) + vx;
    p(i+2,2) =  r1*cosd(i*90)*sind(dcP) + r2*sind(i*90)*cosd(dcP) + vy;
    %p(i+2,4) =  1;
    %p(i+2,1) = vx + r1*cosd(i*90+dcP);
    %p(i+2,2) = vy + r2*sind(i*90+dcP);
end
%Ubicación de los puntos internos móviles
for i = 6:pIn
    H = haltonset(1,'Skip',i*1000,'Leap',i*100);
    H = scramble(H,'RR2');
    ang = 360*H(i);
    %ang = 360*rand(1);
    %xt = vx + r1*cosd(ang);
    %yt = vy + r2*sind(ang);
    p(i,1) = r1*cosd(ang)*cosd(dcP) - r2*sind(ang)*sind(dcP) + vx;
    p(i,2) = r1*cosd(ang)*sind(dcP) + r2*sind(ang)*cosd(dcP) + vy;
    %p(i,4) = 1;
end
%Ubicación de los puntos externos
for i = 1:pEx
    %H = haltonset(1,'Skip',i*3000,'Leap',i*300);
    %H = scramble(H,'RR2');
    %ang = 360*H(i);
    ang = 360*rand(1);
    %xt = vx + r1*cosd(ang);
    %yt = vy + r2*sind(ang);
    p(i + pIn,1) = 1.3*r1*cosd(ang)*cosd(dcP) - 1.3*r2*sind(ang)*sind(dcP) + vx;
    p(i + pIn,2) = 1.3*r1*cosd(ang)*sind(dcP) + 1.3*r2*sind(ang)*cosd(dcP) + vy;
    %p(i,4) = 1;
end
for i = 1: (pIn + 1)
    plot(p(i,1),p(i,2),'*');
    hold on

end
for i = (pIn + 2):pEx
    plot(p(i,1),p(i,2),'g.');
    hold on

end

voronoi(p(:,1),p(:,2));
hold on
axis equal    
    


end

