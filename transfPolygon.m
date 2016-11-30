function cooFin = transfPolygon( coo, rot, x, y, t, extraPoints )
%Función que recibe las coordenadas de un polígono centrado en el origen,
%lo rota y lo desplaza al centro nuevo.
%   Tiene como entrada las coordenadas centradas en el origen, el ángulo de
%   rotación y las coordenadas x,y del nuevo centro
matRot = [cosd(rot) -sind(rot); sind(rot) cosd(rot)];
if t && ~extraPoints
    n = 9;
    cooRot = zeros(2,n);
    for i=1:n
        cooRot(:,i) = matRot*coo(:,i);
    end
    cooFin(1,:) = cooRot(1,:) + x;
    cooFin(2,:) = cooRot(2,:) + y;
elseif t && extraPoints
    n = 13;
    cooRot = zeros(2,n);
    for i=1:n
        cooRot(:,i) = matRot*coo(:,i);
    end
    cooFin(1,:) = cooRot(1,:) + x;
    cooFin(2,:) = cooRot(2,:) + y;
    
else
    n = 5;
    cooRot = zeros(2,n);
    for i=1:n
        cooRot(:,i) = matRot*coo(:,i);
    end
    cooFin(1,:) = cooRot(1,:) + x;
    cooFin(2,:) = cooRot(2,:) + y;
end

end

