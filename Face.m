classdef Face < handle
    %Clase que representa las celdas de Voronoi. Se toman como la cara izquierda de los bordes
        
    properties
        edge; %Objecto de clase Edge que tienen este objeto como cara izquierda.
        site; %Pointer al sitio generador de la celda. Objeto de tipo evento.
        
    end
    
    methods
        %Método constructor de la clase
        function obj = Face(edge, site)
             obj.edge= edge;
             obj.site = site;
             
        end
        
        %Método que recorre los bordes de una cara, si es un polígono
        %cerrado devuelve un vector con los vertices, si es abierto
        %devuelve el vector con los vertices existentes y los bordes
        %semi-infinitos. Si c = 0 el polígono es cerrado, si c = 1, el
        %polígono es abierto. Si el polígono es abierto edges ~= Nil
        function [c,pol,edges] = traversePolygon(obj)
            initialEdge = obj.edge;
            traversed = 0;
            c = 0;
            currentEdge = initialEdge;
            pol = [];
            edges = {};
            %firstOpen = 0;
            %lastOpen = 0;
            i = 1;
            %Ciclo para recorrer el polígono, si encuentra un borde
            %infinito, termina
            currentVertex = currentEdge.vertex;
            %Revisa el caso donde el borde inicial no tiene anterior
            if ~isempty(currentVertex)
                %Recorrer el polígono hasta que lo completa o llega al
                %borde que no tiene siguiente.
                 while traversed == 0
                    if ~isempty(currentEdge.next)
                        currentVertex = currentEdge.vertex;
                        pol(i,:) = [currentVertex.x, currentVertex.y];
                        i = i + 1;
                        currentEdge = currentEdge.next;
                        %Si llega al inicial
                        if currentEdge == initialEdge
                            pol(i,:) = [pol(1,1), pol(1,2)];
                            traversed = 1;
                        end
                    %Si encuentra que el borde siguiente está vacío
                    else
                        pol = [];
                        c = 1; 
                        %lastOpen = 1;
                        edges{1,2} = currentEdge;
                        edges{1,1} = currentEdge.findPrevEmpty;
                        break


                    end
                 end
            else
                 %firstOpen = 1;
                 c = 1;
                 edges{1,1} = currentEdge;
                 edges{1,2} = currentEdge.findNextEmpty;
                              
            end
                
            
            
            
        end
        %Función que procesa el polígono. Llama a la función de clipping si
        %es necesario. Retorna el vector con los puntos que componen el
        %polígono.
        function polVec = processFace(obj, xmin, ymin, xmax, ymax)
            [c, pol, edges] = obj.traversePolygon();
            if ~c
                polVec = pol;
            else
                %Busca el punto de clipping del primer borde infinito.
                prevEdge = edges{1,1};
                site1 = obj.site;
                if ~isempty(prevEdge.next);
                    p1 = [prevEdge.twin.vertex.x, prevEdge.twin.vertex.y];
                    if isempty(prevEdge.vertex)
                        site2 = prevEdge.twin.face.site;
                        p2 = [(site2.xCoord+site1.xCoord)*0.5, (site2.yCoord + site1.yCoord)*0.5];
                        clipPoint = clipping(xmin,ymin,xmax,ymax,p1,p2);
                        newPrevVertex = Vertex(prevEdge, clipPoint(1,1), clipPoint(1,2));
                        prevEdge.vertex = newPrevVertex;
                    end
                end
                
                %Busca el punto de clipping del segundo borde infinito
                %REVISAR SI EL CLIPPOINT FUE CALCULADO ANTERIORMENTE
                nextEdge = edges{1,2};
                if ~isempty(nextEdge.prev)
                    p1 = [nextEdge.vertex.x, nextEdge.vertex.y];
                    if isempty(nextEdge.twin.vertex);
                        site2 = nextEdge.twin.face.site;
                        p2 = [(site2.xCoord+site1.xCoord)*0.5, (site2.yCoord + site1.yCoord)*0.5];
                        clipPoint = clipping(xmin,ymin,xmax,ymax,p1,p2);
                        newNextVertex = Vertex(nextEdge, clipPoint(1,1), clipPoint(1,2));
                        nextEdge.twin.vertex = newNextVertex;
                    else
                        newNextVertex = nextEdge.twin.vertex;
                    end
                    %Crear el borde nuevo que va a lo largo de la frontera
                    newEdge = Edge(newNextVertex, obj);
                    newEdge.next = prevEdge;
                    prevEdge.prev = newEdge;
                    newEdge.prev = nextEdge;
                    nextEdge.next = newEdge;
                    %LLAMA DE NUEVO LA FUNCIÓN DE TRAVERSING
                    [c, pol, edges] = obj.traversePolygon();
                    if ~c
                        polVec = pol;
                    else
                        error('Problema en el algoritmo de C&T');
                    end
                else
                    polVec = [];
                end
               
            end
        end
        
        
    end
    
end