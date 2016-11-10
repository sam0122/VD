classdef Node < handle
    %Clase que representa los nodos del árbol AVL
    %   Detailed explanation goes here
    
    properties
        %Punteros a los sub-árboles izquierdos y derechos del nodo
        leftChild;
        rightChild;
        %Puntero al nodo padre
        parent;
        %Cell con la pareja de sitios cuya intersección forma el brkPoint 
        sites;
        %Evento de círculo donde desaparecerá el nodo hoja. Debe
        %reemplazarse más adelante por un elemento de tipo Evento(círculo).
        circleEvent
        %Evento de sitio que origina el arco representado po el nodo hoja.
        %Por ahora es un par de coordenadas, debe reemplazarse por un
        %elemento de tipo Evento (sitio)
        %site;
        %Factor de balanceo del nodo. Es cero si es un nodo hoja. 
        balanceFactor;
        %Puntero al borde, debería seguir un orden(REVISAR)
        edge;
        
    end
    
    methods
        function obj = Node(sites)
            obj.sites = sites;
            obj.leftChild = [];
            obj.rightChild = [];
            obj.parent = [];
            obj.balanceFactor = 0;
            obj.circleEvent = [];
        end
        %Devuelve el valor del nodo, Si es un nodo hoja devuelve la
        %coordenada del sitio. Si es un brk devuelve la posición de acuerdo
        %a la altura del sweep line usando la función brkCoord(). Esta
        %ultima función puede no estar optimizada.
        function key = key(obj, linePos)
            if obj.isLeaf()            
                site =  obj.sites{1,1};
                key = site.xCoord;
            else
                p1 = obj.sites{1,1};
                p2 = obj.sites{1,2};
                x1 = p1.xCoord;
                y1 = p1.yCoord;
                x2 = p2.xCoord;
                y2 = p2.yCoord;
                key = brkCoord(x1,y1,x2, y2,linePos);
            end
        
        end
        
        function val = isLeftChild(obj)
            if ~isempty(obj.parent)
                lf = obj.parent.leftChild;
                if isequal(obj,lf)
                    val = 1;
                else
                    val = 0;
                end
                
            else
                val = 0;
            end
            
        end
         function val = isRightChild(obj)
            if ~isempty(obj.parent)
                rt = obj.parent.rightChild;
                if isequal(obj,rt)
                    val = 1;
                else
                    val = 0;
                end
                
            else
                val = 0;
            end
            
         end
        
         function val = isRoot(obj)
            if isempty(obj.parent)
                val = 1;
            else
                val = 0;
            end
         end
         
          
         function val = isLeaf(obj)
            if isempty(obj.leftChild) && isempty(obj.rightChild)
                val = 1;
            else
                val = 0;
            end
         end
         
         function val = hasBothChildren(obj)
            if ~isempty(obj.leftChild) && ~isempty(obj.rightChild)
                val = 1;
            else
                val = 0;
            end
         end
         
         
         function val = hasAnyChildren(obj)
            if ~isempty(obj.leftChild) || ~isempty(obj.rightChild)
                val = 1;
            else
                val = 0;
            end
         end
         
         %Métodos auxiliares al método delete
         function succ = findSuccesor(obj)
             succ = [];
           if ~isempty(obj.rightChild)
                succ = obj.rightChild.findMin();
           else
               if ~isempty(obj.parent)
                   if obj.isLeftChild()
                       succ = obj.parent;
                   else
                       obj.parent.rightChild = [];
                       succ = obj.parent.findSuccesor();
                       obj.parent.rightChild = obj;
                   end
               end
           end
           
         end
         
         function current = findMin(obj)
             current = obj;
             while ~isempty(current.leftChild)
                 current = current.leftChild;
             end
         end
         
         function spliceOut(obj)
             if obj.isLeaf()
                if obj.isLeftChild()
                    obj.parent.leftChild = [];
                else
                    obj.parent.rightChild = [];
                end
                
             elseif obj.hasAnyChildren()
                 if ~isempty(obj.leftChild)
                    if obj.isLeftChild()
                        obj.parent.leftChild = obj.leftChild;
                    else
                        obj.parent.rightChild = obj.leftChild;
                    end
                    obj.leftChild.parent = obj.parent;
                 else
                    if obj.isLeftChild()
                        obj.parent.leftChild = obj.rightChild;
                    else
                        obj.parent.rightChild = obj.rightChild;
                    end
                    obj.rightChild.parent = obj.parent;
                    
                 end
                 
                 
             end
             
         end
         %Función auxiliar del método de eliminar un nodo cuando este es la raiz y tiene solo un hijo. 
         function replaceData(obj,sites,lc,rc)
            obj.sites = sites;
            obj.leftChild = lc;
            obj.rightChild = rc;
         end
         
         %Método que busca al nodo que representa al brkPoint secundario
         %asociado al arco representado por el nodo hoja
        function nodeParent = nodeSecParent(obj, prevSite, nextSite)
             if isempty(obj.parent)
                 nodeParent = [];
             elseif  isempty(obj.parent.parent)
                 nodeParent = [];
             else
                 nodeParent = obj.nodeSecParent_(prevSite, nextSite);
             end 
            
        end
        
        function nodeParent = nodeSecParent_(obj, prevSite, nextSite)
            if obj.isLeftChild()
                if obj.parent.isLeftChild()
                    nodeParent = obj.parent.nodeSecParent_(prevSite, nextSite);
                else
                    nodeParent = obj.parent.parent;
                    nodeParent.sites{1,2} = nextSite{1,1};
                end
            else
                 if obj.parent.isRightChild()
                    nodeParent = obj.parent.nodeSecParent_(prevSite, nextSite);
                else
                    nodeParent = obj.parent.parent;
                    nodeParent.sites{1,1} = prevSite{1,1};
                 end
            end
                
        end
        %Métodos para encontrar el nodo arco contiguo al nodo input
        function succ =  findNext(obj)
            if obj.isLeftChild()
                succ = obj.parent.rightChild.goLeft();
            else
                currentNode = obj.parent;
                succ = currentNode.findNext_();
            end
            
        end
        function succ = findNext_(obj)
            if obj.isLeftChild()
                succ = obj.parent.rightChild.goLeft();
            elseif obj.isRoot()
                succ = [];
            else    
                succ = obj.parent.findNext_();
            end
        end
        function leftNode = goLeft(obj)
            if obj.isLeaf()
                leftNode = obj;
            else
                leftNode = obj.leftChild.goLeft();
            end
            
        end
        %Métodos para encontrar el nodo anterior al nodo input
        function prev = findPrev(obj)
            if obj.isRightChild()
                prev = obj.parent.leftChild.goRight();
            else
                currentNode = obj.parent;
                prev = currentNode.findPrev_();
            end
        end
        function prev = findPrev_(obj)
            if obj.isRightChild()
                prev = obj.parent.leftChild.goRight();
            elseif obj.isRoot()
                prev = [];
            else
                prev = obj.parent.findPrev_();
            end
        end
        function rightNode = goRight(obj)
            if obj.isLeaf()
                rightNode = obj;
            else
                rightNode = obj.rightChild.goRight();
            end
            
        end
        
        
    end
    
end

