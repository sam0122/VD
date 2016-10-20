classdef Voronoi < handle
    %Clase que representa el diagrama de Voronoi
    %   Detailed explanation goes here
    
    properties
        %Arbol binario
        avl;
        %Lista de bordes doblemente conectadas
        dcel;
        %Lista prioritaria con los eventos
        heap;
        
    end
    
    methods
        %Constructor, n es el número de sitios de Voronoi
        function obj = Voronoi(n)
            obj.avl = AVL();
            obj.dcel = DCEL;
            obj.heap = binHeap(n);
        end
        
        %Método para insertar un arco en la línea playa, manejo de eventos
        %de sitio
        function handleSiteEvent(obj, siteEvent)
             %Si el árbol está vacío lo inicializa
             if obj.avl.size == 0
                newRoot = Node([siteEvent 0]);
                obj.avl.put(newRoot);
             else
                 %Buscar el nodo justo encima del sitio
                 upperNode = obj.avl.getUpperNode(siteEvent.xCoord, siteEvent.yCoord);
                 %Eliminar el evento de circulo asociado al arco
                 if ~isempty(upperNode.circleEvent)
                     upperNode.circleEvent.valido = false;
                     upperNode.circleEvent = [];
                 end
                 %Crea e inserta el subárbol derivado de la inserción del                
                 %arco
                 obj.avl.putBulk(e, upperNode);
                 %Unir los nuevos brkPoints con los nuevos vértices que
                 %empiezan a trazar
                 
                 
             end
             
            
        end
        
    end
    
end

