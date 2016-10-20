classdef Evento < handle
    properties
        %Coordenadas del evento, punto m�s bajo del c�rculo
        xCoord;
        yCoord;
        r;%Radio del c�rculo
        type; %puede ser de sitio "0" o  de circulo "1".
        
        face; %Representa el pol�gono, cuando es un evento de sitio.
        
        nodo; % Si el evento es un evento de circulo, nodo es un puntero al arco que desaparecer� si el evento ocurre.
        %Control para la lista prioritaria.
        %Flag para determinar si el evento de c�rculo es v�lido o no.
        valido;
    end
    
    methods
        %Se hiz� una simplificaci�n al m�todo constructor. Revisar en los
        %otros m�todos porque se redujo el n�mero de par�metros de entrada
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
