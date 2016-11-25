function cooFin = transfPolygon( coo, rot, x, y )
%Funci�n que recibe las coordenadas de un pol�gono centrado en el origen,
%lo rota y lo desplaza al centro nuevo.
%   Tiene como entrada las coordenadas centradas en el origen, el �ngulo de
%   rotaci�n y las coordenadas x,y del nuevo centro
n = 9;
matRot = [cosd(rot) -sind(rot); sind(rot) cosd(rot)];
cooRot = zeros(2,n);
for i=1:n
    cooRot(:,i) = matRot*coo(:,i);
end
cooFin(1,:) = cooRot(1,:) + x;
cooFin(2,:) = cooRot(2,:) + y;
end

