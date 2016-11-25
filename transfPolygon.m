function cooFin = transfPolygon( coo, rot, x, y )
%Función que recibe las coordenadas de un polígono centrado en el origen,
%lo rota y lo desplaza al centro nuevo.
%   Tiene como entrada las coordenadas centradas en el origen, el ángulo de
%   rotación y las coordenadas x,y del nuevo centro
n = 9;
matRot = [cosd(rot) -sind(rot); sind(rot) cosd(rot)];
cooRot = zeros(2,n);
for i=1:n
    cooRot(:,i) = matRot*coo(:,i);
end
cooFin(1,:) = cooRot(1,:) + x;
cooFin(2,:) = cooRot(2,:) + y;
end

