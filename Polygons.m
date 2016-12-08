classdef Polygons < handle
    %Clase que representa el arreglo que contiene los polígonos de
    %agregados
    %       
    properties
        agregados;%Celda de objetos de la clase Agregate
        sz;%Tamaño del arreglo
    end
    
    methods
        function obj = Polygons(nAgg)
            obj.agregados = cell(nAgg,1);
            obj.sz = 0;
        end
        
        function addAgregate(obj, agg)
            obj.sz = obj.sz + 1;
            obj.agregados{obj.sz,1} = agg;
        end
        
        function processFaces(obj, xmin, ymin, xmax, ymax)
            r = 134/255;
            b = 122/255;
            g = b;
            color = [r b g];
            fileResults = fopen('CoordenadasVoronoi.scr', 'w');
            for i = 1:obj.sz
                %AÑADIR RUTINA QUE ESCRIBA EL ARCHIVO DE SALIDA SEPARANDO
                %POR AGG
                currentAgg = obj.agregados{i,1};
                pol = currentAgg.processFace(xmin,ymin,xmax,ymax);
                if ~isempty(pol)
                    fill(pol(:,1),pol(:,2),color);
                    hold on
                end
                fprintf(fileResults,'\n');
                fprintf(fileResults,'%s','pline ');
                fprintf(fileResults,'%2.9f,%2.9f\n',pol');
                
            end
            
        end
        
        
    end
    
end

