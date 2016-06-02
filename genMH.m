function C = genMH( np,a,b)
%Par�metro de elongaci�n
E = 0.8;
%Celda que contiene las celdas que conforman los agregados y las celdas que
%conforman los vac�os.
C = cell(np,1);
for j = 1:np
    %�rea del agregado, es funci�n de la granulometr�a
    A = 0.005 +(0.05 - 0.005)*rand(1);
    %Semieje mayor
    r1 = sqrt(A/(pi()*E));
    %Semieje menor
    r2 = r1 * E;

    %Coordenadas del n�cleo
    vx = a*rand(1);
    vy = b*rand(1);
    %Inclinaci�n de la part�cula
    dcP = -37 +(37 + 37)*rand(1);
    %N�mero m�nimo de contactos
    cMin = 4;
    %N�mero m�ximo de contactos
    cMax = 14;

    %Vector que contiene los puntos
    p = zeros(cMax + 1,2);
    p(1,1) = vx;
    p(1,2) = vy;
    %Ubicaci�n de los puntos externos fijos
    for i = 0:cMin-1

        p(i+2,1) = vx + r1*cosd(i*90+dcP);
        p(i+2,2) = vy + r2*sind(i*90+dcP);
    end
    %Ubicaci�n de los puntos externos m�viles
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

