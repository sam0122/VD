classdef Nodo
    properties(GetAccess = 'public', SetAccess = 'private')
        %Pointers a los nodos a la izquierda y a la derecha
        lLink;
        rLink;
        %Tuple que representa la pareja de sitios que forman el breakpoint
        %si el nodo es interno, es una celda que contiene dos arreglos con
        %las coordenadas resepctivas
        brkPoint;
        %Indica si el nodo es interno o externo
        isArc;
        %Pointer que conecta el nodo, si es un arco, con el evento de vertice donde dicho arco desaparecera 
        circleEvent;
        %Pointer que conecta el nodo, si es interno, con uno de los bordes
        %que estan siendo trazados por el breakpoint
        edge;
        %Pointer al nodo padre
        parent;
    end
    
    methods(Access = public)
        function obj = Nodo(left, right, parent, arc, brkPoint, pointer)
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
                end
            end
        end
        function x = xCoord(obj, linePos)
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
              
     end
    
    
end
