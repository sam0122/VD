%Función que crea un array de puntos que representan la ubicación de los
%sitios del diagrama, dentro de un bounding box.
%Parámetros: n = número de puntos, a = base caja, b = altura de la caja
function [p] = points(n, a, b)

    p = zeros(n,2);
    p(:,1) = (0.8*a)*rand(n,1);
    p(:,2) = (0.8*b)*rand(n,1);

    %{
    plot(p(:,1),p(:,2),'.');
    hold on;
    box =  boundingBox(a,b);
    plot(box(:,1),box(:,2));
    %}
    %[V,C] = voronoin(p);
    %voronoi(p(:,1),p(:,2));
    %axis equal;
    %Graficar
    
end
