classdef Evento < handle
    properties
        %Coordenadas del evento
        x;
        y;
        type; %puede ser de sitio "0" o  de circulo "1".
    end
    
    methods
        function obj = Evento(xC, yC, t)
            obj.x = xC;
            obj.y = yC;
            obj.type = t;
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
