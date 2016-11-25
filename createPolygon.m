function coo = createPolygon(L1, El )
%Función que devuelve los puntos en un polígono en forma de rombo
%   L es la longitud del eje mayor y El es el parámetro de elongoación
%   entre 0 y 1
L2 = L1 * El;
coo = zeros(2,9);
%--------------------------------
coo(1,1) = -L1*0.5;
coo(1,2) = -L1*0.25;
coo(1,3) = 0;
coo(1,4) = L1*0.25;
coo(1,5) = L1*0.5;
coo(1,6) = L1*0.25;
coo(1,7) = 0;
coo(1,8) = -L1*0.25;
coo(1,9) = -L1*0.5;
%--------------------------------
coo(2,1) = 0;
coo(2,2) = L2*0.25;
coo(2,3) = L2*0.5;
coo(2,4) = L2*0.25;
coo(2,5) = 0;
coo(2,6) = -L2*0.25;
coo(2,7) = -L2*0.5;
coo(2,8) = -L2*0.25;
coo(2,9) = 0;

end

