classdef AVL < handle
    %Clase para el árbol binario balanceado que representa la línea playa
    %   Detailed explanation goes here
    properties(Constant)
        %Constantes para la representación del estado de balanceo del
        %árbol. Si el factor del nodo es igual a BAL, está perfectamete balanceado. Si es mayor a 1, está descompensado hacia la izquierda; si es menor a -1 está desbalanceado hacia la derecha.
        BAL = 0;
        DER = -1;
        IZQ = 1;
    end
    properties
        %Objeto de la clase Nodo que sirve como raíz del árbol
        root;
        %Entero que guarda el número de nodos en el árbol
        size;
    end
    
    methods
    %Método constructor
        function obj = AVL()
            obj.root = [];
            obj.size = 0;
            
        end
            
    %Métodos para insertar un nodo al árbol. Requiere modificaciones
    %especiales para voronoi
 
        %Función para insertar un nodo a la vez
        function put(obj, node, linePos)
            if ~isempty(obj.root)%Si no está vacío llama la función auxiliar put_()
                obj.put_(node, obj.root, linePos);
            else %Si está vacío el nodo se convierte en la raíz
                obj.root = node;
            end
            obj.size = obj.size + 1; 
        end
        %Función para insertar un conjunto de nodos al tiempo. Asociada a
        %Voronoi
        function nodeNewArc = putBulk(obj, newSite, upperNode, leftEdge, rightEdge)
            %Tomar los sitios del arco existente
            %linePos = newSite.yCoord;
            sites = upperNode.sites;
            existingSite = sites{1,1};
            %{
            upperNode.sites = {newSite existingSite};
            upperNodeRight = Node({existingSite 0});
            obj.put(upperNodeRight, linePos); 
            upperNode.edge = rightEdge;
            newBrk = Node({existingSite newSite});
            obj.put(newBrk,linePos);
            newBrk.edge = leftEdge;
            newLeft = Node({existingSite 0 });
            obj.put(newLeft,linePos);
            newRight = Node({newSite 0});
            obj.put(newRight,linePos);
            nodeNewArc = newRight;
            %}
            
            if upperNode.isLeftChild()
                %Nuevo nodo derecho y modificación de la información de
                %upperNode
                upperNode.sites = {newSite existingSite};
                upperNodeRight = Node({existingSite 0});
                upperNodeRight.parent = upperNode;
                upperNode.rightChild = upperNodeRight;
                %Conexión con el nuevo borde que traza
                upperNode.edge = rightEdge;
                
                %Nuevo nodo de brkPoint
                newBrk = Node({existingSite newSite});
                newBrk.parent = upperNode;
                upperNode.leftChild = newBrk;
                obj.updateBalance(upperNode);
                %Conexión con el nuevo borde que traza
                newBrk.edge = leftEdge;
                %COMPROBACIÓN ERRORES. ELIMINAR CUANDO SE ENCUENTRE EL BUG
                if ~upperNode.hasBothChildren()    
                    error('Problema al insertar la primera pareja de nodos');
                end
                
                %Nodos arcos restantes
                %Arco izquierdo
                newLeft = Node({existingSite 0 });
                newLeft.parent = newBrk;
                newBrk.leftChild = newLeft;
                %Arco derecho
                newRight = Node({newSite 0});
                newRight.parent = newBrk;
                newBrk.rightChild = newRight;
                obj.updateBalance(newBrk);
                %Devolver el nodo que representa al arco nuevo.
                nodeNewArc = newRight;
                %COMPROBACIÓN ERRORES. ELIMINAR CUANDO SE ENCUENTRE EL BUG
                if ~newBrk.hasBothChildren()    
                    error('Problema al insertar la primera pareja de nodos');
                end
                          
                
            else
                
                %Nuevo nodo izquierdo y modificación de la información de
                %upperNode
                upperNode.sites = {existingSite newSite};
                upperNodeLeft = Node({existingSite 0});
                upperNodeLeft.parent = upperNode;
                upperNode.leftChild = upperNodeLeft;
                %Conexión con el nuevo borde que traza
                upperNode.edge = leftEdge;
                
                %Nuevo nodo de brkPoint
                newBrk = Node({newSite existingSite});
                newBrk.parent = upperNode;
                upperNode.rightChild = newBrk;
                obj.updateBalance(upperNode);
                %Conexión con el nuevo borde que traza
                newBrk.edge = rightEdge;
                %COMPROBACIÓN ERRORES. ELIMINAR CUANDO SE ENCUENTRE EL BUG
                if ~upperNode.hasBothChildren()    
                    error('Problema al insertar la primera pareja de nodos');
                end
                %Nodos arcos restantes
                %Arco izquierdo
                newLeft = Node({newSite 0 });
                newLeft.parent = newBrk;
                newBrk.leftChild = newLeft;
                %Arco derecho
                newRight = Node({existingSite 0});
                newRight.parent = newBrk;    
                newBrk.rightChild = newRight;
                obj.updateBalance(newBrk);              
                %Devolver el nodo que representa al arco nuevo.
                nodeNewArc = newLeft;
                %COMPROBACIÓN ERRORES. ELIMINAR CUANDO SE ENCUENTRE EL BUG
                if ~newBrk.hasBothChildren()    
                    error('Problema al insertar la primera pareja de nodos');
                end
                
            end
            obj.size = obj.size + 4;
            %}
            
        end
    %Función auxiliar para el método de inserción
        function put_(obj, node, currentNode, linePos)%El nodo tiene que haber sido creado. Se sabe de antemano el sitio o sitios que dan la información de la posición del nodo si el nodo es interno (brk) o externo (arco)
            key = node.key(linePos);
            if key < currentNode.key(linePos)
                if ~isempty(currentNode.leftChild)
                    obj.put_(node, currentNode.leftChild, linePos);
                else
                    currentNode.leftChild = node;
                    node.parent = currentNode;
                    obj.updateBalance(node);
                end
                
            else
                if ~isempty(currentNode.rightChild)
                    obj.put_(node, currentNode.rightChild,linePos);
                else
                    currentNode.rightChild = node;
                    node.parent = currentNode;
                    obj.updateBalance(node);
                end
            end
            
        end
        %Método auxiiliar que actualiza los factores de balance y llama al
        %metodo con las rotaciones
        function updateBalance(obj, node)
            
            if node.balanceFactor > 1 || node.balanceFactor < -1
                obj.rebalance(node);
                return
            end
            
            if ~isempty(node.parent)
                if node.isLeftChild()
                    node.parent.balanceFactor = node.parent.balanceFactor + 1;
                elseif node.isRightChild()
                     node.parent.balanceFactor = node.parent.balanceFactor - 1;
                end
                
                if node.parent.balanceFactor ~= 0
                    obj.updateBalance(node.parent);
                end
             end
            
        end
        %Función para rebalancear cuando se inserta un bloque entero
        function updateBalanceBulk(obj, node)
            
            if node.balanceFactor > 1 || node.balanceFactor < -1
                obj.rebalance(node);
                return
            end
            
            if ~isempty(node.parent)
                if node.isLeftChild()
                    node.parent.balanceFactor = node.parent.balanceFactor + 2;
                elseif node.isRightChild()
                     node.parent.balanceFactor = node.parent.balanceFactor - 2;
                end
                
                if node.parent.balanceFactor ~= 0
                    obj.updateBalance(node.parent);
                end
             end
            
        end
        
        function rebalance(obj,node)
           if node.balanceFactor < 0
             if node.rightChild.balanceFactor > 0
                obj.rotateRight(node.rightChild);
                obj.rotateLeft(node);
             else
                obj.rotateLeft(node);
             end
                      
         elseif node.balanceFactor > 0
             if node.leftChild.balanceFactor < 0
                obj.rotateLeft(node.leftChild);
                obj.rotateRight(node);
             else
                obj.rotateRight(node);
             end
           end
        end
         
        function rotateLeft(obj,rotRoot)
            newRoot = rotRoot.rightChild;
            rotRoot.rightChild = newRoot.leftChild;
            if ~isempty(newRoot.leftChild)
                newRoot.leftChild.parent = rotRoot;
            end
            newRoot.parent = rotRoot.parent;
            if rotRoot.isRoot()
                obj.root = newRoot;
            else
                if rotRoot.isLeftChild()
                        rotRoot.parent.leftChild = newRoot;
                else
                    rotRoot.parent.rightChild = newRoot;
                end
            end
            newRoot.leftChild = rotRoot;
            rotRoot.parent = newRoot;
            rotRoot.balanceFactor = rotRoot.balanceFactor + 1 - min(newRoot.balanceFactor, 0);
            newRoot.balanceFactor = newRoot.balanceFactor + 1 + max(rotRoot.balanceFactor, 0);
        end

        function rotateRight(obj,rotRoot)
            newRoot = rotRoot.leftChild;
            rotRoot.leftChild = newRoot.rightChild;
            if ~isempty(newRoot.rightChild)
                newRoot.rightChild.parent = rotRoot;
            end
            newRoot.parent = rotRoot.parent;
            if rotRoot.isRoot()
                obj.root = newRoot;
            else
                if rotRoot.isLeftChild()
                    rotRoot.parent.leftChild = newRoot;
                else
                    rotRoot.parent.rightChild = newRoot;
                end
            end
            newRoot.rightChild = rotRoot;
            rotRoot.parent = newRoot;
            rotRoot.balanceFactor = rotRoot.balanceFactor - 1 + min(-newRoot.balanceFactor, 0);
            newRoot.balanceFactor = newRoot.balanceFactor - 1 + min(rotRoot.balanceFactor, 0);
        end
        
        %Devuelve el nodo hoja que se encuentra justo encima del sitio con
        %coordenada x  = key;
        function node = getUpperNode(obj, key, linePos)
            if ~isempty(obj.root)
                node = obj.getUpperNode_(key,obj.root, linePos);
            else
                node = [];
            end
            
        end
        %Función auxiliar para encontrar el arco superior
        function node = getUpperNode_(obj, key, currentNode,linePos)
            if currentNode.isLeaf()
                node = currentNode;
            else    
                if key < currentNode.key(linePos)
                   node = obj.getUpperNode_(key, currentNode.leftChild, linePos);
                    
                else
                    node = obj.getUpperNode_(key, currentNode.rightChild, linePos);
                end
                
            end
        end
        %Método para eliminar un elemento
        function delete(obj,node)
        
            if obj.size > 1
                obj.remove(node);
                obj.size = obj.size - 1;
            elseif obj.size == 1 && isequal(obj.root,node)
                obj.root = [];
                obj.size = obj.size - 1;
            else
                error('No existe nodo en el árbol');
            end
        end
        %Función que elimina el arco asociado al evento de círculo y el
        %brkPoint. Retorna el nodo remanente
        function remainingNode =  deleteArc(obj, node)
            if obj.size > 1
                remainingNode = obj.removeArc(node);
                obj.size = obj.size - 2;
            elseif obj.size == 1 && isequal(obj.root,node)
                obj.root = [];
                obj.size = obj.size - 1;
            else
                error('No existe nodo en el árbol');
            end
        end
        function remainingNode = removeArc(obj,node)
            %{
            Elimina el arco
            
            if node.isLeftChild()
                    node.parent.leftChild = [];
                    remainingNode = node.parent.rightChild;
            else
                    node.parent.rightChild = [];
                    remainingNode = node.parent.leftChild;
            end
            %}
            %Elimina el brkPoint
            brk = node.parent;
            if node.isRightChild()
                   if brk.isLeftChild()
                       brk.leftChild.parent = brk.parent;
                       brk.parent.leftChild = brk.leftChild;
                   elseif brk.isRightChild()
                       brk.leftChild.parent = brk.parent;
                       brk.parent.rightChild = brk.leftChild;
                   else
                       %Caso en el que el nodo a eliminar es la raiz
                       brk.replaceData(brk.leftChild.sites, brk.leftChild.leftChild, brk.leftChild.rightChild); 
                   end
                   remainingNode = brk.leftChild;
                   
            else
                    if brk.isLeftChild()
                       brk.rightChild.parent = brk.parent;
                       brk.parent.leftChild = brk.rightChild;
                   elseif brk.isRightChild()
                       brk.rightChild.parent = brk.parent;
                       brk.parent.rightChild = brk.rightChild;
                   
                   else
                       %Caso en el que el nodo a eliminar es la raiz
                       brk.replaceData(brk.rightChild.sites, brk.rightChild.leftChild, brk.rightChild.rightChild); 
                       
                   end
                   remainingNode = brk.rightChild;
                    
            end
            obj.updateBalanceDel(remainingNode);%RemainingNode puede ser un nodo hoja o brkPoint  
            %COMPROBACIÓN ERRORES. ELIMINAR CUANDO SE ENCUENTRE EL BUG
            if ~remainingNode.parent.hasBothChildren()    
                    error('Problema al eliminar el arco');
            end
        end
        
        %---------------------------------------------------------------------------------------------
        function remove(obj, node)
            if node.isLeaf()
            %Caso 1, el nodo a eliminar es una hoja
                %Rebalance
                obj.updateBalanceDel(node);
                if node.isLeftChild()
                    node.parent.leftChild = [];
                else
                    node.parent.rightChild = [];
                end
                
            %Caso 2, Nodo tiene dos hijos
            elseif node.hasBothChildren()
                succ = node.findSuccesor();
                %Rebalance
                obj.updateBalanceDel(succ);
                succ.spliceOut();
                node.sites = succ.sites;
                
            %Caso 3, Nodo tiene 1 solo hijo
            else
                if ~isempty(node.leftChild)
                   if node.isLeftChild()
                       obj.updateBalanceDel(node);
                       node.leftChild.parent = node.parent;
                       node.parent.leftChild = node.leftChild;
                   elseif node.isRightChild()
                       obj.updateBalanceDel(node);
                       node.leftChild.parent = node.parent;
                       node.parent.rightChild = node.leftChild;
                   
                   else
                       %Caso en el que el nodo a eliminar es la raiz
                       obj.updateBalanceDel(node.leftChild);
                       node.replaceData(node.leftChild.sites, node.leftChild.leftChild, node.leftChild.rightChild); 
                   end
                else
                    if node.isLeftChild()
                       obj.updateBalanceDel(node);
                       node.rightChild.parent = node.parent;
                       node.parent.leftChild = node.rightChild;
                   elseif node.isRightChild()
                       obj.updateBalanceDel(node);
                       node.rightChild.parent = node.parent;
                       node.parent.rightChild = node.rightChild;
                   
                    else
                       %Caso en el que el nodo a eliminar es la raiz
                       obj.updateBalanceDel(node.rightChild);
                       node.replaceData(node.rightChild.sites, node.rightChild.leftChild, node.rightChild.rightChild); 
                       
                   end
                    
                    
                end
               
            end
            
        end
        
        function updateBalanceDel(obj, node)
            
            if node.balanceFactor > 1 || node.balanceFactor < -1
                obj.rebalance(node);
                return
            end
            
            if ~isempty(node.parent)
                
                if node.parent.balanceFactor ~= 0
                    if node.isLeftChild()
                        node.parent.balanceFactor = node.parent.balanceFactor - 1;
                    elseif node.isRightChild()
                        node.parent.balanceFactor = node.parent.balanceFactor + 1;
                    end
                    obj.updateBalanceDel(node.parent);
                else
                    if node.isLeftChild()
                        node.parent.balanceFactor = node.parent.balanceFactor - 1;
                    elseif node.isRightChild()
                        node.parent.balanceFactor= node.parent.balanceFactor + 1;
                    end
                end
                            
            end
            
        end
        %Métodos para obtener un nodo dada la información de los sitios
        function res = get(obj,sites)
            if ~isempty(obj.root)
                res = obj.get_(sites,obj.root);
            else
                res = [];
            end
                
        end
        
        function res = get_(obj, sites, currentNode)
            if isempty(currentNode)
                res = [];
            elseif currentNode.sites == sites
                res = currentNode;
            elseif sites < currentNode.sites
                res = obj.get_(sites, currentNode.leftChild);
            else
                res = obj.get_(sites, currentNode.rightChild);
            end
            
        end
        
        
    end
    
    
    
    %Método para balancear por derecha
    %Método para balancear por izquierda
    
    
end

