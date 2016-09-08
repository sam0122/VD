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
            %Revisa si la lista está vacía
           if isempty(obj.head) && isempty(obj.tail)
               obj.head = event;
               obj.tail = event;
               %{
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
               %}
               
           else     
               %Si no está vacía verifica
                yn = event.yCoord();
                yh = obj.head.yCoord();
                yt = obj.tail.yCoord();
                %Revisa si lla coordenada del evento es mayor que la
                %coordenada de la cabeza de la lista
                if yn > yh 

                    event.next = obj.head;
                    obj.head.prev = event;
                    obj.head = event;
                    event.prev = [];
                %Revisa si el evento queda después de la cola
                elseif yn < yt
                    event.prev = obj.tail;
                    obj.tail.next = event;
                    obj.tail = event;
                    event.next = [];
                %Si está entre la cabeza y la cola
                else   
                    u = false;
                    %ei = obj.head.next;
                    ei = obj.head;
                    ej = ei.next;

                    %yi = ei.yCoord();
                    yj = ej.yCoord();
                    %Iteración para encontrar la posición del evento
                    while u == 0
                        if  yn > yj
                            ei.next = event;
                            event.prev = ei;

                            ej.prev = event;
                            event.next = ej;

                            u = 1;
                        elseif yn == yj
                            xn = event.xCoord();
                            xj = ej.xCoord();
                            if xn > xj
                                ei.next = event;
                                event.prev = ei;

                                ej.prev = event;
                                event.next = ej;

                                u = 1;
                                
                            elseif xn < xj
                                ei = ej;
                                ej = ei.next;

                                yj = ej.yCoord();

                            else
                                error('No puede tener dos puntos con la mismas coordenadas');
                            end
                            
                        else
                            ei = ej;
                            ej = ei.next;

                            %yi = ei.yCoord();
                            yj = ej.yCoord();


                        end


                    end


                end
            
            
           end
        end
        %Método que elimina el evento de la lista ordenada
        function removeEvent(obj, event)
            
            yn = event.yCoord();
            xn = event.xCoord();
            
            yh = obj.head.yCoord();
            xh = obj.head.xCoord();
            
            yt = obj.tail.yCoord();
            xt = obj.tail.xCoord();
            
            if obj.head == obj.tail
                obj.head = [];
                obj.tail = [];
            else
                if yn == yh && xn == xh 
                    next = obj.head.next;
                    obj.head.next = [];
                    obj.head.prev = [];
                    obj.head = next;
                    obj.head.prev = [];
                   

                elseif yn == yt && xn == xt
                    prev = obj.tail.prev;
                    obj.tail.next = [];
                    obj.tail.prev = [];
                    obj.tail = prev;
                    obj.tail.next = [];
                    
                else

                    u = false;
                    ei = obj.head.next;
                    ej = ei.prev;
                    ek = ei.next;

                    yi = ei.yCoord();
                    xi = ei.xCoord();
                    
                    while u == 0
                        if yn == yi && xn == xi 
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
                            xi = ei.xCoord();    
                        end
                    end


                end 
            end
            
                
               


        end
            
         
        
        
        
    end
    
end
