classdef Edge < handle
    %Clase que representa las lineas del diagrama
        
    properties
        vertex; %Objeto de clase Vertex que representa el v�rtice de origen del objeto. Punto final del gemelo
        face; %Objeto de clase Face la cara externa (izquierda) del objeto.
        twin; %Objeto de clase Edge que corresponde al semi-borde gemelo del objeto.
        next; %Objeto de clase Edge que corresponde al semi-borde izquierdo siguiente al objeto.
        prev; %Objeto de clase Edge que corresponde al half-edge izquierdo anterior al objeto.        
        %node; %Objeto de clase Nodo que representa el nodo interno que est� trazando el borde. 
    end
    
    methods
        %M�todo constructor de la clase
        function obj = Edge(vertex, face)
             
             obj.vertex = vertex;
             obj.face = face;
             obj.twin = [];
             obj.next= [];
             obj.prev = [];
             %obj.node =  [];
        end
        %Funci�n que devuelve el borde infinito en un pol�gono
        function infiniteEdge  = findNextEmpty(obj)
            if isempty(obj.next)
                infiniteEdge = obj;
            else
                infiniteEdge = findNextEmpty(obj.next);
            end
            
        end
        
        %Funci�n que devuelve el segundo borde infinito en un pol�gono
        function infiniteEdge  = findPrevEmpty(obj)
            if isempty(obj.prev)
                infiniteEdge = obj;
            else
                infiniteEdge = findPrevEmpty(obj.prev);
            end
            
        end
 
        
    end
    
end