classdef Nodo < handle
    properties
        %Pointers a los nodos a la izquierda y a la derecha, si es un
        %BREAKPOINT (NODO INTERNO)
        lLink;
        rLink;
        %Tuple que representa la pareja de sitios que forman el breakpoint
        %si el nodo es interno,es vector con los sitios que
        %lo forman. Es un arreglo con elementos de tipo Evento(sitio).
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
        %Pointers a la izquierda y a la derecha si el nodo es un ARC(NODO
        %EXTERNO)
        prev;
        next;
        
    end
    
    methods
        function obj = Nodo( arc, brkPoint,site)
            %Metodo constructor de la clase
            if nargin>0
               
                if arc == 0
                    obj.brkPoint = brkPoint;
                    obj.isArc = 0;
                    %obj.edge = pointer;
                else 
                    obj.isArc = 1;
                    %obj.circleEvent = pointer;
                    obj.site = site;
                end
            end
        end
        function x = xCBreakPoint(obj, linePos)
                %Calcula la coordenada x del breakpoint teniendo como
                %parametro la posición de la sweep line.
                x = centroCirculo (obj.brkPoint, linePos);
        end
        %Funcion retorna el tipo de nodo
        function s = status(obj)
            s = obj.isArc;
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
        function set.lLink(obj, nodo)
            obj.lLink = nodo;
        end
        %Funcion que inserta un nodo a la derecha
        %function set.rLink(obj, nodo)
        %    obj.rLink = nodo;
        %end
        %Funcion que cambia el nodo padre del nodo actual
        function set.parent(obj, nodo)
            obj.parent = nodo;
            
        end
        function set.isArc(obj,valor )
            obj.isArc = valor;
            
        end
       %Funcion que retorna el evento generador del nodo actual
        function Evento = giveSiteEvent(obj)
             Evento = obj.site;
        end
       %Funcion que retorna el evento de circulo del nodo actual
        function evento = giveCircleEvent(obj)
             evento = obj.circleEvent;
        end
        
        function set.circleEvent(obj, evento)
            obj.circleEvent = evento;
            
        end
        
        %Función que devuelve la coordenada x del nodo si es un brkpoint o
        %del sitio es es un arco
        function x = xCoord(obj, linePos)
            if obj.isArc == 0
                pj = obj.brkPoint(1,1);
                pi = obj.brkPoint(1,2);
                
                x = brkCoord(pj.xCoord,pj.yCoord,pi.xCoord,pi.yCoord ,linePos);
            else 
                sit = obj.site;
                x = sit.xCoord();
            end
            
        end
        % Actualiza la condición del nodo
        function refreshState(obj)
            if isempty(obj.lLink) && isempty(obj.rLink)
                obj.isArc = 1;
            else 
                obj.isArc = 0;
                obj.site  = [];
                obj.prev = [];
                obj.next = [];
                
            end
            
            
        end
        
        %Elimina el cicle event asociado al nodo 
        
        function deleteCE (obj)
            obj.circleEvent = [];
        end
        
        function y = yCoord(obj)
            sit = obj.site;
            y = sit.yCoord();
        end
        
        
     end
    
    
end
