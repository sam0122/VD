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
        %Metodo que busca un nodo dentro del arbol, devuelve true si lo encuentra y false si no existe.
        function exists = search(Nodo)
            exists = 0;
            
            
            
        end
        
             
             
    end
    

end
