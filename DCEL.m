classdef DCEL < handle
    %Clase que representa la lista de bordes doblemente conectada, que
    %guarda el diagrama a medida que se va construyendo
    
    
    properties
        %La lista se modela como tres arreglos que contienen los elementos:
        %semi-bordes, vértices y caras.     
        edges = [];
        vertices = [];
        faces = [];
    end
    
    methods
        %Método constructor. Inicia la clase como un conjunto de arreglos
        %vacíos.
        function obj = DCEL()
        end
        %Método que añade un nuevo borde 
        function addEdge(obj,edge)
            
           s = size(obj.edges);
           obj.edges(s(1,1)+1,s(1,2)) = edge;
           
        end
        %Método que añade una nueva cara 
        function addFace(obj,face)
            
           s = size(obj.faces);
           obj.faces(s(1,1)+1,s(1,2)) = face;
           
        end
        
        %Método que añade un nuevo vértice
        function addVertex(obj,vertex)
            
           s = size(obj.vertices);
           obj.vertices(s(1,1)+1,s(1,2)) = vertex;
           
        end
        
        
    end
    
end

