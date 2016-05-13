classdef Evento < handle
    properties
        %Coordenadas del evento, punto más bajo del círculo
        x;
        y;
        r;%Radio del círculo
        type; %puede ser de sitio "0" o  de circulo "1".
        
        face; %Representa el polígono, cuando es un evento de sitio.
        
        nodo; % Si el evento es un evento de circulo, nodo es un puntero al arco que desaparecerá si el evento ocurre.
        %Control para la lista prioritaria.
        prev;
        next;
    end
    
    methods
        function obj = Evento(xC, yC, t,nodo, radio, fc)
            
                obj.x = xC;
                obj.y = yC;
                obj.type = t;
                obj.nodo = nodo;
                obj.r = radio;
                obj.face = fc;
                
                obj.prev = [];
                obj.next = [];
               
            
        end 
        
        function xC = xCoord(obj)
            xC = obj.x;
        end
        
         function yC = yCoord(obj)
            yC = obj.y;
        end
        
        function t = giveType(obj)
            t = obj.type;
        end
        
        
     end
    
end
