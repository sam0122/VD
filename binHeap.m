classdef binHeap < handle
    %Clase que representa la cola prioritaria que contiene los eventos
    %   Detailed explanation goes here
    
    properties
        heapList;
        currentSize;
    end
    
    methods
        function obj = binHeap(n) %n es el número inicial de eventos, es decir, el número de puntos de Voronoi
            obj.heapList = cell(n*2,1);
            obj.currentSize = 0;
        end
        
        function percUp(obj,i)
            div = fix(i/2);
            while div > 0
                y1 = obj.heapList{i,1}.y;
                y2 = obj.heapList{div,1}.y;
                if y1 > y2
                    tmp = obj.heapList{div,1};
                    obj.heapList{div,1} = obj.heapList{i,1};
                    obj.heapList{i,1} = tmp;
                end
                i = div;
                div = fix(i/2);
             end
            
        end
        
        function insertEvent(obj,k)
            obj.heapList{obj.currentSize + 1,1} = k;
            obj.currentSize = obj.currentSize + 1;
            obj.percUp(obj.currentSize);
        end
        %{
        function buildHeap(obj, p)
            s = size(p);
            i = fix(s(1,1)/2);
            obj.currentSize = s(1,1);
        end
        %}
        
        function percDown(obj, i)
            
            while (i*2) <= obj.currentSize
                mc = obj.maxChild(i);
                y1 = obj.heapList{i,1}.y;
                y2 = obj.heapList{mc,1}.y;
                if y1  < y2
                    tmp = obj.heapList{i,1};
                    obj.heapList{i,1} = obj.heapList{mc,1};
                    obj.heapList{mc,1} = tmp;
                end
                i = mc;
                
            end
            
        end
        
        function ind = maxChild(obj, i)
            if (i*2 + 1) > obj.currentSize
                ind = i*2;
            else
                y1 = obj.heapList{i*2,1}.y;
                y2 = obj.heapList{i*2 + 1,1}.y;
                if y1 > y2
                    ind = i*2;
                else
                    ind = i*2 + 1;
                end
            end
            
        end
        
        function ev =  removeEvent(obj)
            
            ev = obj.heapList{1,1};
            obj.heapList{1,1} = obj.heapList{obj.currentSize,1};
            obj.heapList{obj.currentSize,1} = [];
            obj.currentSize = obj.currentSize - 1;
            obj.percDown(1);
                        
        end
    end
    
end

