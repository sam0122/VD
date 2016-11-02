classdef DCEL < handle
    %Clase que representa la lista de bordes doblemente conectada, que
    %guarda el diagrama a medida que se va construyendo
    
    
    properties
        %La lista se modela como tres arreglos que contienen los elementos:
        %semi-bordes, vértices y caras.     
        %edges;
        %vertices;
        faces;
        size;
        vertex %Almacenamiento temporal de vértices, solo ppara debugging.
        vsize;
    end
    
    methods
        %Método constructor. Inicia la clase como un conjunto de arreglos
        %vacíos.
        function obj = DCEL()
            %obj.edges = {};
            %obj.vertices = {};
            obj.faces = {};
            obj.size = 0;
            obj.vertex = {};
            obj.vsize = 0;
        end
        %Método que añade un nuevo borde 
        %{
        function addEdge(obj,edge)
            
           s = size(obj.edges);
           i = s(1,1) + 1;
           j = 1;
           obj.edges{i,j} = edge;
           
        end
        %}
        %Método que añade una nueva cara 
        function addFace(obj,face)
            
           %s = size(obj.faces);
           %i = s(1,1) + 1;
           %j = 1;
           obj.size = obj.size + 1;
           obj.faces{obj.size,1} = face;
           
        end
        %Función que devuelve todos los vértices de un polígono
        function poly = returnPoly(obj)
            poly = cell(obj.size, 2); %Celda que contiene en la primera columna el identificador del polígono y en la segunda un vector de nX2 donde n es el número de vértices del polígono y en cada columna van las coordenadas xy.
            for i = 1:obj.size
                round = false;
                f = obj.faces{i,1};
                e = f.edge;
                j = 1;
                vector = [e.vertex.x e.vertex.y];
                next = e.next;
                while ~round
                    if isequal(next,e)
                        round = true;
                    else
                        j = j + 1;
                        vector(j,:) = [next.vertex.x next.vertex.y];
                        next = next.next;
                    end
                    
                end
                poly{i,1} = i;
                poly{i,2} = vector;
                
             end
            
        end
        
        
        %Método que añade un nuevo vértice
        function addVertex(obj,vertex)
            
           obj.vsize = obj.vsize + 1;
           obj.vertex{obj.vsize,1} = vertex;
           
        end
        %}
        
    end
    
end

