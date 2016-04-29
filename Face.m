classdef Face < handle
    %Clase que representa las celdas de Voronoi. Se toman como la cara izquierda de los bordes
        
    properties
        edge; %Objecto de clase Edge que tienen este objeto como cara externa (izquierda).
        site; %Pointer al sitio generador de la celda
        
    end
    
    methods
        %Método constructor de la clase
        function obj = Face(edge, site)
             obj.edge= edge;
             obj.site = site;
             
        end
    end
    
end