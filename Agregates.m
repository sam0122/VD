classdef Agregates < handle
    %Clase que representa al pol�gono del agregado 
    %   Contiene todos los sitios que forman parte de un pol�gono de tipo
    %   agregado
    
    properties
        sites;%Celda que contiene objetos de la clase site que representan los puntos generadores 
        sz; %Tama�o temporal del arreglo
    end
    
    methods
        %M�todo constructor que recibe el n�mero de puntos nP que conforman cada agregado 
        function obj = Agregates(nP)
            obj.sites = cell(nP,1);
            obj.sz = 0;
        end
        
        %M�todo para agregar sitios nuevos al arreglo
        function addSite(obj, site)
            obj.sz = obj.sz + 1;
            obj.sites{obj.sz,1} = site;
        end
        %M�todo quue recorre y guarda los pol�gonos de cada una de las
        %caras que componen el agregado
        function polF = processFace(obj,xmin, ymin, xmax, ymax)
            polF = [];
            %Guardar los v�rtices del puntos central
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
            %Eliminar vertices centrales del arreglo de final de v�rtices
            polF = setxor(polF, centralVertices, 'rows');
            %Ordena los elementos en CCW
            %Coordenadas del baricentro /podr�a ser el centroide o las
            %coordenadas del centro del esqueleto
            Cx = mean(polF(:,1));
            Cy = mean(polF(:,1));
            polF = mergeSort(polF, [Cx Cy]);
        end
    end
    
end

