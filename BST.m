classdef BST
    properties(GetAccess = 'public', SetAccess = 'private')
        root; %Nodo raiz del arbol
        height; %Altura del arbol
    end
    
    methods(Access = public)
        %Metodo constuctor de la clase 
        function obj = BST(root)
             obj.root = root;         
        end
        % Busca el arco justo encima del evento p, devuelve el nodo
        % asociado a dicho arco
        function Nodo = searchNode(obj, p , linePos)
            pXCoor = p.giveX();
            f = 0;
            rt = obj.root;
            while f == 0
                if rt.xCoord(linePos)< pXCoor
                    if rt.giveLeft() == []
                        
                    end
                    
                
                end
                
            end
            
        end
        
        
             
             
    end
    

end
