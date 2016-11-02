classdef DCEL < handle
    %Clase que representa la lista de bordes doblemente conectada, que
    %guarda el diagrama a medida que se va construyendo
    
    
    properties
        %La lista se modela como tres arreglos que contienen los elementos:
        %semi-bordes, v�rtices y caras.     
        %edges;
        %vertices;
        faces;
        size;
        vertex %Almacenamiento temporal de v�rtices, solo ppara debugging.
        vsize;
    end
    
    methods
        %M�todo constructor. Inicia la clase como un conjunto de arreglos
        %vac�os.
        function obj = DCEL()
            %obj.edges = {};
            %obj.vertices = {};
            obj.faces = {};
            obj.size = 0;
            obj.vertex = {};
            obj.vsize = 0;
        end
        %M�todo que a�ade un nuevo borde 
        %{
        function addEdge(obj,edge)
            
           s = size(obj.edges);
           i = s(1,1) + 1;
           j = 1;
           obj.edges{i,j} = edge;
           
        end
        %}
        %M�todo que a�ade una nueva cara 
        function addFace(obj,face)
            
           %s = size(obj.faces);
           %i = s(1,1) + 1;
           %j = 1;
           obj.size = obj.size + 1;
           obj.faces{obj.size,1} = face;
           
        end
        %Funci�n que devuelve todos los v�rtices de un pol�gono
        function poly = returnPoly(obj)
            poly = cell(obj.size, 2); %Celda que contiene en la primera columna el identificador del pol�gono y en la segunda un vector de nX2 donde n es el n�mero de v�rtices del pol�gono y en cada columna van las coordenadas xy.
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
        
        
        %M�todo que a�ade un nuevo v�rtice
        function addVertex(obj,vertex)
            
           obj.vsize = obj.vsize + 1;
           obj.vertex{obj.vsize,1} = vertex;
           
        end
        %}
        
    end
    
end

