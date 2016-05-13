classdef Vertex < handle
    %Clase que representa los vertices en el diagrama
        
    properties
        edge; %Objeto de clase Edge que tienen este objeto como v�rtice de inicio
        pos; %Array (x,y) que representa las coordenadas del vertice
    end
    
    methods
        %M�todo constructor de la clase
        function obj = Vertex(edge, coord)
             obj.edge= edge;
             obj.pos= coord;
        end
    end
    
end

