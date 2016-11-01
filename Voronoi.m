classdef Voronoi < handle
    %Clase que representa el diagrama de Voronoi
    %   Detailed explanation goes here
    
    properties
        %Arbol binario
        avl;
        %Lista de bordes doblemente conectadas
        dcel;
        %Lista prioritaria con los eventos
        heap;
        
    end
    
    methods
        %Constructor, n es el número de sitios de Voronoi
        function obj = Voronoi(n)
            obj.avl = AVL();
            obj.dcel = DCEL;
            obj.heap = binHeap(n);
        end
        
        %Método para insertar un arco en la línea playa, manejo de eventos
        %de sitio
        function handleSiteEvent(obj, siteEvent)
             %Si el árbol está vacío lo inicializa
             if obj.avl.size == 0
                newRoot = Node([siteEvent 0]);
                obj.avl.put(newRoot);
                %Creación del polígono inicial
                newFace = Face([],siteEvent);
                siteEvent.face = newFace;
                obj.dcel.addFace(newFace);
                %Agregar la cara nueva
             else
                 %Buscar el nodo justo encima del sitio
                 upperNode = obj.avl.getUpperNode(siteEvent.xCoord, siteEvent.yCoord);
                 %Guarda el sitio relacionado con el nodo arco
                 upperNodeSites = upperNode.sites;
                 existingSite = upperNodeSites(1,1);
                 existingFace = existingSite.face;
                 %Unir los nuevos brkPoints con los nuevos vértices que
                 %empiezan a trazar
                 %----------Nueva cara
                 newFace = Face([],siteEvent);
                 %----------Añadir cara nueva al array
                 obj.dcel.addFace(newFace);
                 %---------Crear los bordes
                 leftEdge = Edge([],newFace);
                 rightEdge = Edge([],existingFace);
                 rightEdge.twin = leftEdge;
                 leftEdge.twin = rightEdge;
                 %----------Unir bordes y caras
                 newFace.edge = leftEdge;
                 existingFace.edge = rightEdge;
                 %Eliminar el evento de circulo asociado al arco
                 if ~isempty(upperNode.circleEvent)
                     upperNode.circleEvent.valido = false;
                     upperNode.circleEvent = [];
                 end
                 %Crea e inserta el subárbol derivado de la inserción del                
                 %arco. 
                 nodeNewArc = obj.avl.putBulk(siteEvent, upperNode, leftEdge, rightEdge);
                 %Verificación de nuevas tripletas, con nodeNewArc a la
                 %izquierda y a la derecha
                 %Tripleta 1
                 nextNode = nodeNewArc.findNext();
                 nextNextNode = nextNode.findNext();
                 obj.checkCircleEvent(nodeNewArc, nextNode, nextNextNode);
                 %Tripleta 2
                 prevNode = nodeNewArc.findPrev();
                 prevPrevNode = prevNode.findPrev();
                 obj.checkCircleEvent(prevPrevNode, prevNode, nodeNewArc);
              end
             
            
        end
        
        function handleCircleEvent(obj, circleEvent)
        %Eliminar nodo del árbol
            nodeEliminate = circleEvent.node;
            parentEliminate = nodeEliminate.parent;
            %Guardar información importante relacionada al nodo que se va a
            %eliminar
            secondParent = nodeEliminate.nodeSecParent();
            nextNode = nodeEliminate.findNext();
            prevNode = nodeEliminate.findPrev();
            %Actualizar la información del segundo padre y se guarda la
            %información de los bordes que estaban siendo trazados
            if nodeEliminate.isLeftChild()
                secondParent.sites(1,2) = nextNode.sites(1,1);
                rightEdge = nodeEliminate.parent.edge;
                leftEdge = secondParent.edge;
            else
                secondParent.sites(1,1) = prevNode.sites(1,1);
                rightEdge = secondParent.edge;
                leftEdge = nodeEliminate.parent.edge;
            end
            %Eliminar eventos de círculo asociados
            nextCircleEvent = nextNode.circleEvent;
            nextCircleEvent.valid = false;
            prevCircleEvent = prevNode.circleEvent;
            prevCircleEvent.valid = false;
            %Crear vértice nuevo
            r = circleEvent.r;
            xV = circleEvent.x;
            yV = circleEvent.y + r;
            %Crear el vértice y bordee.
            newVertex = Vertex([],xV,yV);
            newEdge = Edge(newVertex,[]);
            newEdgeTwin = Edge([],[]);
            newEdge.twin = newEdgeTwin;
            newEdgeTwin.twin = newEdge;
            %Unir con caras existentes
            leftSite = prevNode.sites(1,1);
            rightSite = nextnode.sites(1,1);
            leftFace = leftSite.face;
            rightFace = rightSite.face;
            newEdge.face = rightFace;
            newEdgeTwin.face = leftFace;
            %Unir con bordes que estaban siendo trazados
            leftEdge.next = rightEdge.twin;
            rightEdge.twin.prev = leftEdge;
            leftEdge.twin.vertex = newVertex;
            newEdgeTwin.next = leftEdge.twin;
            leftEdge.twin.prev = newEdgeTwin;
            %------------------------------------
            rightEdge.next = newEdge;
            newEdge.prev = rightEdge;
            rightEdge.twin.vertex = newVertex;
            %------------------------------------
            %Eliminar los nodos del árbol            
            obj.avl.delete(nodeEliminate);
            obj.avl.delete(parentEliminate);
            %------------------------------------
            %Revisar nuevas tripletas
            %Tripleta 1 prevNode, nextNode, nextNextNode
            nextNextNode = nextNode.findNext();
            obj.checkCircleEvent(prevNode, nextNode, nextNextNode);
            %Tripleta 2 prevPrevNode, prevNode,nextNode
            prevPrevNode = prevnode.findPrev();
            obj.checkCircleEvent(prevPrevNode, prevNode,nextNode);
            
            
        end
        %Función auxiliar que revisa si una tripleta converge. Si lo hace
        %crea el evento de círculo y lo añade al binHeap.
        function checkCircleEvent(obj,node1, node2, node3)
            if ~isempty(node1) && ~isempty(node2) &&  ~isempty(node3)
                     [conv, cc] = convergence(node1, node2, node3);
                     if conv == 1
                         r = cc(1,3);
                         %Crear nuevo evento de círculo para el nextNode
                         circleEvent = Evento(cc(1,1),cc(1,2)-r);
                         circleEvent.r = r;
                         circleEvent.type = 1;
                         circleEvent.node = node2;
                         node2.circleEvent = circleEvent;
                         %Agregar a la lista prioritaria
                         obj.heap.insertEvent(circleEvent);
                     end
             end
        end
        
        
    end
    
end

