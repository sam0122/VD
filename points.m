%Función que crea un array de puntos que representan la ubicación de los
%sitios del diagrama, dentro de un bounding box.
%Parámetros: n = número de puntos, a = base caja, b = altura de la caja
function [p] = points(n, a, b)

    p = zeros(n,2);
    p(:,1) = a*rand(n,1);
    p(:,2) = b*rand(n,1);
    %{
    p(1,:) = [0 0];
    p(2,:) = [0.5 0.25];
    p(3,:) = [0.8 0.7];
    p(4,:) = [0.4 2.5];
    p(5,:) = [1 3];
    p(6,:) = [2 2.8];
    p(7,:) = [3 1.5];
    p(8,:) = [2.8 0.5];
    p(9,:) = [1.8 1];
    p(10,:) = [0.25 1.5];
    p(11,:) = [0.2 1];
    p(12,:) = [0.8 0.15];
    %}
    
    plot(p(:,1),p(:,2),'.');
    hold on;
    %box =  boundingBox(a,b);
    %plot(box(:,1),box(:,2),'k');
    %}
    %[V,C] = voronoin(p);
    %voronoi(p(:,1),p(:,2),'k');
    axis equal;
    %Graficar
    
end
