classdef Agregates < handle
    %Clase que representa al polígono del agregado 
    %   Contiene todos los sitios que forman parte de un polígono de tipo
    %   agregado
    
    properties
        sites;%Celda que contiene objetos de la clase site que representan los puntos generadores 
        sz; %Tamaño temporal del arreglo
    end
    
    methods
        %Método constructor que recibe el número de puntos nP que conforman cada agregado 
        function obj = Agregates(nP)
            obj.sites = cell(nP,1);
            obj.sz = 0;
        end
        
        %Método para agregar sitios nuevos al arreglo
        function addSite(obj, site)
            obj.sz = obj.sz + 1;
            obj.sites{obj.sz,1} = site;
        end
        %Método quue recorre y guarda los polígonos de cada una de las
        %caras que componen el agregado
        function polF = processFace(obj,xmin, ymin, xmax, ymax)
            polF = [];
            %Guardar los vértices del puntos central
            centralSite = obj.sites{1,1};
            centralFace = centralSite.face;
            centralVertices = centralFace.processFace(xmin, ymin ,xmax, ymax);
            for i = 2: obj.sz
                currentSite = obj.sites{i,1};
                currentFace = currentSite.face;
                pol = currentFace.processFace(xmin, ymin, xmax, ymax);
                if ~isempty(pol)
                    polF = [polF;pol];
                end
            end
            %Eliminar vertices centrales del arreglo de final de vértices
            polF = setxor(polF, centralVertices, 'rows');
            %Ordena los elementos en CCW
            %Coordenadas del baricentro /podría ser el centroide o las
            %coordenadas del centro del esqueleto
            Cx = mean(polF(:,1));
            Cy = mean(polF(:,1));
            polF = mergeSort(polF, [Cx Cy]);
        end
    end
    
end

