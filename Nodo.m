classdef Nodo
    properties(GetAccess = 'public', SetAccess = 'private')
        %Pointers a los nodos a la izquierda y a la derecha
        lLink;
        rLink;
        %Tuple que representa la pareja de sitios que forman el breakpoint
        %si el nodo es interno, es una celda que contiene dos arreglos con
        %las coordenadas respectivas
        brkPoint;
        %Indica si el nodo es interno o una rama
        isArc;
        %Pointer que conecta el nodo, si es un arco, con el evento de vertice donde dicho arco desaparecera 
        circleEvent;
        %Pointer que conecta el nodo, si es interno, con uno de los bordes
        %que estan siendo trazados por el breakpoint
        edge;
        %Pointer al nodo padre
        parent;
        %Pointer al sitio que origina el nodo si este es una rama (arco) Es
        %un objeto de tipo Evento
        site
    end
    
    methods(Access = public)
        function obj = Nodo(left, right, parent, arc, brkPoint, pointer, site)
            %Metodo constructor de la clase
            if nargin>0
                obj.parent = parent;
                if arc == 0
                    obj.brkPoint = brkPoint;
                    obj.lLink = left;
                    obj.rLink = right;
                    obj.isArc = 0;
                    obj.edge = pointer;
                else 
                    obj.isArc = 1;
                    obj.circleEvent = pointer;
                    obj.site = site;
                end
            end
        end
        function x = xCBreakPoint(obj, linePos)
                %Calcula la coordenada x del breakpoint teniendo como
                %parametro la posición de la sweep line.
                x = centroCirculo (obj.brkPoint, linePos);
        end
        %Funcion que devuelve el nodo izquierdo del nodo actual
        function Nodo = giveLeft(obj)
            Nodo = obj.lLink;
        end
        %Funcion que devuelve el nodo derecho del nodo actual
        function Nodo = giveRight(obj)
            Nodo = obj.rLink;
        end
        %Funcion que devuelve el nodo padre del nodo actual
        function Nodo = giveParent(obj)
            Nodo = obj.parent;
        end
        %Funcion que inserta un nodo a la izquierda
        function setLeft(obj, nodo)
            obj.lLink = nodo; %#ok<MCHV2>
        end
        %Funcion que inserta un nodo a la derecha
        function setRight(obj, nodo)
            obj.rLink = nodo;
        end
        %Funcion que cambia el nodo padre del nodo actual
        function setParent(obj, nodo)
            obj.parent = nodo;
        end
        %Función que devuelve la coordenada x si el nodo es una rama
        function x = xCoorArc(obj)
            sit = obj.site;
            x = sit.retCoordX();
        end
        %Función que devuelve la coordenada x del nodo si es un brkpoint o
        %del sitio es es un arco
        function x = xCoord(obj, linePos)
            if obj.isArc == 0
                x = centroCirculo (obj.brkPoint, linePos);
            else 
            sit = obj.site;
            x = sit.xCoord();
            end
            
        end
        % Actualiza la condición del nodo
        function refreshState(obj)
            if obj.lLink && obj.rLink == []
                obj.isArc = 1;
            else 
                obj.isArc = 0;
            end
            
            
        end
        
        
     end
    
    
end
