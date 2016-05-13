classdef DCEL < handle
    %Clase que representa la lista de bordes doblemente conectada, que
    %guarda el diagrama a medida que se va construyendo
    
    
    properties
        %La lista se modela como tres arreglos que contienen los elementos:
        %semi-bordes, v�rtices y caras.     
        edges = {};
        vertices = {};
        faces = {};
    end
    
    methods
        %M�todo constructor. Inicia la clase como un conjunto de arreglos
        %vac�os.
        function obj = DCEL()
        end
        %M�todo que a�ade un nuevo borde 
        function addEdge(obj,edge)
            
           s = size(obj.edges);
           i = s(1,1) + 1;
           j = 1;
           obj.edges{i,j} = edge;
           
        end
        %M�todo que a�ade una nueva cara 
        function addFace(obj,face)
            
           s = size(obj.faces);
           i = s(1,1) + 1;
           j = 1;
           obj.faces{i,j} = face;
           
        end
        
        %M�todo que a�ade un nuevo v�rtice
        function addVertex(obj,vertex)
            
           s = size(obj.vertices);
           i = s(1,1) + 1;
           j = 1;
           obj.vertices{i,j} = vertex;
           
        end
        
        
    end
    
end

