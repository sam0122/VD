classdef DCEL < handle
    %Clase que representa la lista de bordes doblemente conectada, que
    %guarda el diagrama a medida que se va construyendo
    
    
    properties
        %La lista se modela como tres arreglos que contienen los elementos:
        %semi-bordes, v�rtices y caras.     
        edges = [];
        vertices = [];
        faces = [];
    end
    
    methods
        %M�todo constructor. Inicia la clase como un conjunto de arreglos
        %vac�os.
        function obj = DCEL()
        end
        %M�todo que a�ade un nuevo borde 
        function addEdge(obj,edge)
            
           s = size(obj.edges);
           obj.edges(s(1,1)+1,s(1,2)) = edge;
           
        end
        %M�todo que a�ade una nueva cara 
        function addFace(obj,face)
            
           s = size(obj.faces);
           obj.faces(s(1,1)+1,s(1,2)) = face;
           
        end
        
        %M�todo que a�ade un nuevo v�rtice
        function addVertex(obj,vertex)
            
           s = size(obj.vertices);
           obj.vertices(s(1,1)+1,s(1,2)) = vertex;
           
        end
        
        
    end
    
end

