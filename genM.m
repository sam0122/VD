function [V,D] = genM( np, a, b )
%C = cell(np,1);
%Area promedio polígono 
ap = (a*b)/np;
%Parámetro de desviación ajustable
ds = 0.3*ap;
p = [];
k = 0;
for i = 1:np
    fin = 0;
    con = 0;
    %Número de celdas de Voronoi que forman el polígono
    nc = randi([2 , 4],1);
    %Radio asociado al área del agregado
    A = ap + ds*randn(1);
    r = sqrt(A)/pi();
    while fin == 0 && con < 10000
        con = con + 1;
        %Coordenadas del centroide
        vx =  a*rand(1);
        vy =  b*rand(1);

        %Ciclo que verifica si existe algún punto dentro del circulo que se va a
        %definir.
    
        s = size(p);
        ter = 0;
        for j = 1:s(1,1)
           x = p(j,1);
           y = p(j,2);
           if (x - vx)^2 + (y - vy)^2 <= r^2
               ter = 1;
               break;
           end
        end
        if ter == 0
            fin = 1;
            %Inclinación agregado
            dcP = -37 +(37 + 37)*rand(1);
            if nc == 2
                a1 = -45 + (45 + 45)*rand(1);
                a2 = 135 + (225 - 135)*rand(1);
               
                vx1 = vx + r*cosd(dcP + a1);
                vx2 = vx + r*cosd(dcP + a2);
                
                vy1 = vy + r*sind(dcP + a1);
                vy2 = vy + r*sind(dcP + a1);
                p(i + k,1) = vx1;
                p(i + k,2) = vy1;
                k = k + 1;
                p(i + k,1) = vx2;
                p(i + k,2) = vy2;
            elseif nc == 3
                a1 = -25 + (25 + 25)*rand(1);
                a2 = 90 + (170 - 90)*rand(1);
                a3 = 190 + (270 - 190)*rand(1);
                
                vx1 = vx + r*cosd(dcP + a1);
                vx2 = vx + r*cosd(dcP + a2);
                vx3 = vx + r*cosd(dcP + a3);
                
                vy1 = vy + r*sind(dcP + a1);
                vy2 = vy + r*sind(dcP + a2);
                vy3 = vy + r*sind(dcP + a3);
                
                p(i + k,1) = vx1;
                p(i + k,2) = vy1;
                k = k + 1;
                p(i + k,1) = vx2;
                p(i + k,2) = vy2;
                k = k + 1;
                p(i + k,1) = vx3;
                p(i + k,2) = vy3;
                
            elseif nc == 4
                a1 = 15 + (45 - 15)*rand(1);
                a2 = 135 + (165 - 135)*rand(1);
                a3 = 195 + (225 - 195)*rand(1);
                a4 = 315 + (395 - 315)*rand(1);
                
                vx1 = vx + r*cosd(dcP + a1);
                vx2 = vx + r*cosd(dcP + a2);
                vx3 = vx + r*cosd(dcP + a3);
                vx4 = vx + r*cosd(dcP + a4);
                
                vy1 = vy + r*sind(dcP + a1);
                vy2 = vy + r*sind(dcP + a2);
                vy3 = vy + r*sind(dcP + a3);
                vy4 = vy + r*sind(dcP + a4);
                
                p(i + k,1) = vx1;
                p(i + k,2) = vy1;
                k = k + 1;
                p(i + k,1) = vx2;
                p(i + k,2) = vy2;
                k = k + 1;
                p(i + k,1) = vx3;
                p(i + k,2) = vy3;
                k = k + 1;
                p(i + k,1) = vx4;
                p(i + k,2) = vy4;
                
                
            end
            
            
        end
        
    end
end

voronoi(p(:,1),p(:,2));
axis equal;
[V,D] = voronoin(p);

for i = 1:length(D)
    if all(D{i}~=1)
        %col = [rand(1) rand(1) rand(1)];
        patch(V(D{i},1),V(D{i},2), i);
    end
    
end

end

