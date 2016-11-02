n = 6;
VD = Voronoi(n);
%Sitios
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
%Ciclo algoritmo
while VD.heap.currentSize > 0
    currentEvent = VD.heap.removeEvent();
    %Verifica si el evento es válido
    if ~currentEvent.type
        VD.handleSiteEvent(currentEvent);        
    elseif currentEvent.valido
        VD.handleCircleEvent(currentEvent);  
    end
    
end
