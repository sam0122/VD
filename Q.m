classdef Q < handle
    %Clase que maneja la lista ordenada de eventos
    properties
        head;
        tail;
    end
    
    methods
        %Método constructor de la clase
        function obj = Q(head, tail)
            
            obj.head = head;
            obj.tail = tail;
        
        end
        
        function insertEvent(obj, event)
            yn = event.yCoord();
            yh = obj.head.yCoord();
            yt = obj.tail.yCoord();
            
            if yn > yh 
                
                event.next = obj.head;
                obj.head.prev = event;
                obj.head = event;
                event.prev = [];
                
            elseif yn < yt
                event.prev = obj.tail;
                obj.tail.next = event;
                obj.tail = event;
                event.next = [];
                
            else   
                u = false;
                ei = obj.head.next;
                ej = ei.next;
                
                yi = ei.yCoord();
                yj = ej.yCoord();
                
                while u == 0
                    if yn < yi && yn > yj
                        ei.next = event;
                        event.prev = ei;
                        
                        ej.prev = event;
                        event.next = ej;
                        
                        u = 1;
                    else
                        ei = ej;
                        ej = ei.next;
                
                        yi = ei.yCoord();
                        yj = ej.yCoord();
                        
                    
                    end
                    
                    
                end
                
                
            end
            
            
        end
        
        function removeEvent(obj, event)
            
            yn = event.yCoord();
            yh = obj.head.yCoord();
            yt = obj.tail.yCoord();
            
            if yn == yh 
                obj.head = obj.head.next;
                obj.head.prev = [];
                
            elseif yn == yt
                
                obj.tail = obj.tail.prev;
                obj.tail.next = [];
            else
                
                u = false;
                ei = obj.head.next;
                ej = ei.prev;
                ek = ei.next;
                
                yi = ei.yCoord();
                while u == 0
                    if yn == yi
                        ej.next = ek;
                        ek.prev = ej;
                        ei.next = [];
                        ei.prev = [];
                        u = 1;
                    else
                        ei = ek;
                        ej = ei.prev;
                        ek = ei.next;
                
                        yi = ei.yCoord();
                        
                    end
                end
                
            
            end
            
            
        
        end
        
        
        
    end
    
end
