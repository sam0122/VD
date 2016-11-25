n = 10000;
VD = Voronoi(n);

%{
Sitios
site1 = Evento(0.5, 0.5);
site2 = Evento(1,1);
site3 = Evento(0.5,2);
site4 = Evento(1.5,1.5);
site5 = Evento(1.6,0.2);
site6 = Evento(2, 1.8);
%Inicializar cola prioritaria
VD.heap.insertEvent(site1);
VD.heap.insertEvent(site2);
VD.heap.insertEvent(site3);
VD.heap.insertEvent(site4);
VD.heap.insertEvent(site5);
VD.heap.insertEvent(site6);
%}

%Crear los puntos
p = zeros(n,2);
%rng(0.5,'twister');
p(:,1) = 0.98*rand(n,1);
p(:,2) = 0.98*rand(n,1);
%voronoi(p(:,1),p(:,2));
%found = 0;
for i = 1:n
    e = Evento(p(i,1),p(i,2));
    VD.heap.insertEvent(e);
end
%}CONTADOR TEMPORAL
counter1 = 0;
counter2 = 0;
xmin = 0;
xmax = 1;
ymin = 0;
ymax = 1;

%Ciclo algoritmo
while VD.heap.currentSize > 0
    currentEvent = VD.heap.removeEvent();
    %Verifica si el evento es v�lido
    if ~currentEvent.type      
        VD.handleSiteEvent(currentEvent); 
        counter1 = counter1 + 1;        
    elseif currentEvent.valido
        VD.handleCircleEvent(currentEvent, xmin, ymin, xmax, ymax);  
        counter2 = counter2 + 1;
    end
    
end
%Procesar los pol�gonos y graficarlos
VD.dcel.processFaces(xmin, ymin, xmax, ymax);
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