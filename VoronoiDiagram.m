%Cargar los puntos de los archivos Vacios.txt y Agregados.txt
nAgg = 12;%Número de agregados 
nV = 4;%Número de vacíos
vecAgg = [];
vecVacios = [];
fileAgg = fopen('Agregados.txt');
%Ciclo que recorre cada una de las filas del archivo de texto
for i=1:nAgg*2
    temp = textscan(fileAgg, '%f %f %f %f %f %f %f %f %f %f %f',1);
    vecAgg(i,1) = cell2mat(temp(1,11));
    vecAgg(i,2:11) = cell2mat(temp(1,1:10));
end
fileVacios = fopen('Vacíos.txt');
for i=1:nV*2
    temp = textscan(fileVacios, '%f %f %f %f %f %f %f',1);
    vecVacios(i,1) = cell2mat(temp(1,7));
    vecVacios(i,2:7) = cell2mat(temp(1,1:6));
end
n = nAgg + nV;
VD = Voronoi(n, nAgg);
%----------------------------------------------------------------------------------------------------
%Crear los sitios a partir de la información importada
%p = zeros(n,2);
%rng(0.5,'twister');
%p(:,1) = 0.98*rand(n,1);
%p(:,2) = 0.98*rand(n,1);
%voronoi(p(:,1),p(:,2));
%found = 0;
temp = size(vecAgg);
col = (temp(1,2)-2);
%acum = 1;
%p = [];

for i = 1:2:nAgg*2
    agregado = Agregates(col);
    VD.polygons.addAgregate(agregado);
    for j=1:col
        %p(acum,1) = vecAgg(i,j);
        %p(acum,2) =  vecAgg(i+1,j);
        %acum = acum + 1;
        %Asocia el sitio al polígono de agg. El primero es el centro        
        e = Evento(vecAgg(i,j),vecAgg(i+1,j));
        agregado.addSite(e);
        VD.heap.insertEvent(e);
    end
end
temp = size(vecVacios);
col = (temp(1,2)-2);
for i = 1:2:nV*2
    for j=1:col
        %p(acum,1) = vecVacios(i,j);
        %p(acum,2) =  vecVacios(i+1,j);
        %acum = acum + 1;
        e = Evento(vecVacios(i,j),vecVacios(i+1,j));
        VD.heap.insertEvent(e);
    end
end
%voronoi(p(:,1),p(:,2));
%}CONTADOR TEMPORAL
counter1 = 0;
counter2 = 0;
xmin = 0;
xmax = 30;
ymin = 0;
ymax = 30;

%Ciclo algoritmo
while VD.heap.currentSize > 0
    currentEvent = VD.heap.removeEvent();
    %Verifica si el evento es válido
    if ~currentEvent.type      
        VD.handleSiteEvent(currentEvent); 
        counter1 = counter1 + 1;        
    elseif currentEvent.valido
        VD.handleCircleEvent(currentEvent, xmin, ymin, xmax, ymax);  
        counter2 = counter2 + 1;
    end
    
end
%Procesar los polígonos y graficarlos
VD.polygons.processFaces(xmin, ymin, xmax, ymax);
axis equal
%{
ver = VD.dcel.vertex;
m = size(ver);
m = m(1,1);
for i = 1:m
    point = ver{i,1};
    plot(point.x, point.y, '*g');
    hold on
end
%}
%voronoi(p(:,1),p(:,2));