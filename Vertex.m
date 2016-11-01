classdef Vertex < handle
    %Clase que representa los vertices en el diagrama
        
    properties
        edge; %Objeto de clase Edge que tienen este objeto como vértice de inicio
        x;%Coordenada x
        y;%Coordenada y
    end
    
    methods
        %Método constructor de la clase
        function obj = Vertex(edge, x, y)
             obj.edge= edge;
             obj.x = x;
             obj.y = y;
        end
    end
    
end

