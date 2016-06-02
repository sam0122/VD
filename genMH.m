function C = genMH( np,a,b)
%Parámetro de elongación
E = 0.8;
%Celda que contiene las celdas que conforman los agregados y las celdas que
%conforman los vacíos.
C = cell(np,1);
for j = 1:np
    %Área del agregado, es función de la granulometría
    A = 0.005 +(0.05 - 0.005)*rand(1);
    %Semieje mayor
    r1 = sqrt(A/(pi()*E));
    %Semieje menor
    r2 = r1 * E;

    %Coordenadas del núcleo
    vx = a*rand(1);
    vy = b*rand(1);
    %Inclinación de la partícula
    dcP = -37 +(37 + 37)*rand(1);
    %Número mínimo de contactos
    cMin = 4;
    %Número máximo de contactos
    cMax = 14;

    %Vector que contiene los puntos
    p = zeros(cMax + 1,2);
    p(1,1) = vx;
    p(1,2) = vy;
    %Ubicación de los puntos externos fijos
    for i = 0:cMin-1

        p(i+2,1) = vx + r1*cosd(i*90+dcP);
        p(i+2,2) = vy + r2*sind(i*90+dcP);
    end
    %Ubicación de los puntos externos móviles
    for i = cMin:cMax
        ang = 360*rand(1);
        p(i+2,1) = vx + r1*cosd(ang+dcP);
        p(i+2,2) = vy + r2*sind(ang+dcP);
    end
    C{j,1} = p;
    %{
    H = haltonset(2,'Skip',1e2,'Leap',1e2);
    H = scramble(H,'RR2');
    C = H(1:1:np,:); 
    plot(C(:,1),C(:,2),'*');
    %}


end
for i = 1:np    
    p = C{i,1};
    plot(p(:,1),p(:,2),'*');
    hold on
    %voronoi(p(:,1),p(:,2));
    axis equal;
end
end

