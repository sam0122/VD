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
        %Método de inserta el evento en la lista ordenada
        function insertEvent(obj, event)
           if isempty(obj.head) || isempty(obj.tail)
               
               if isempty(obj.head)
                  obj.head = event;  
               elseif isempty(obj.tail)
                   if event.yCoord() > obj.head.yCoord()
                       obj.tail = obj.head;
                       obj.head = event;
                       event.next = obj.tail;
                       obj.tail.prev = event;
                   else
                       obj.tail =event;
                       obj.head.next = event;
                       event.prev = obj.head;
                   end
               end
               
               
           else     
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
                    %ei = obj.head.next;
                    ei = obj.head;
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
        end
        %Método que elimina el evento de la lista ordenada
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
                        ej = ei;
                        ei = ek;
                        ek = ei.next;
                        %{
                        ei = ek;
                        ej = ei.prev;
                        ek = ei.next;
                        %}
                        yi = ei.yCoord();
                        
                    end
                end
                
            
            end
            
            
        
        end
        
        
        
    end
    
end
