classdef Evento < handle
    properties
        %Coordenadas del evento, punto más bajo del círculo
        xCoord;
        yCoord;
        r;%Radio del círculo
        type; %puede ser de sitio "0" o  de circulo "1".
        
        face; %Representa el polígono, cuando es un evento de sitio.
        
        nodo; % Si el evento es un evento de circulo, nodo es un puntero al arco que desaparecerá si el evento ocurre.
        %Control para la lista prioritaria.
        %Flag para determinar si el evento de círculo es válido o no.
        valido;
    end
    
    methods
        %Se hizó una simplificación al método constructor. Revisar en los
        %otros métodos porque se redujo el número de parámetros de entrada
        %necesarios.
        function obj = Evento(xC, yC)
            
                obj.xCoord = xC;
                obj.yCoord = yC;
                obj.type = 0;
                obj.nodo = [];
                obj.r = [];
                obj.face = [];
                obj.valido = true;
            
        end 
        
        function xC = xCoordFun(obj)
            xC = obj.xCoord;
        end
        
         function yC = yCoordFun(obj)
            yC = obj.yCoord;
        end
        
        function t = giveType(obj)
            t = obj.type;
        end
        
        
     end
    
end
