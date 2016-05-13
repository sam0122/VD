classdef Vertex < handle
    %Clase que representa los vertices en el diagrama
        
    properties
        edge; %Objeto de clase Edge que tienen este objeto como vértice de inicio
        pos; %Array (x,y) que representa las coordenadas del vertice
    end
    
    methods
        %Método constructor de la clase
        function obj = Vertex(edge, coord)
             obj.edge= edge;
             obj.pos= coord;
        end
    end
    
end

