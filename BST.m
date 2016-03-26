classdef BST < handle
    properties
        root; %Nodo raiz del arbol
        height; %Altura del arbol
    end
    
    methods
        %Metodo constuctor de la clase 
        function obj = BST(root)
             obj.root = root;         
        end
        % Busca el arco justo encima del evento p, devuelve el nodo
        % asociado a dicho arco
        function Nodo = searchNode(obj, p)
            pXCoor = p.xCoord();
            linepos = p.yCoord();
            found = 0;
            rt = obj.root;
            brkCoord = rt.xCoord(linepos);
            while found == 0
                if pXCoor < brkCoord   
                    
                    if isempty(rt.lLink)
                        Nodo = rt;
                        found = 1;
                    else
                        rt = rt.lLink;
                    
                    end
                
                else    
                    if isempty(rt.rLink)
                        Nodo = rt;
                        found = 1;
                    else
                        rt = rt.rLink;
                    
                    end
                
                
                end
             end
            
        end
        function insertArc(obj, p)
            tp1 = searchNode(obj, p);
            sj = tp1.giveSiteEvent();
            pj = Nodo(tp1,1,[],sj);
            tp1.lLink = pj;            
            tp1.refreshState();
            si = p;
            bPoint1 = {sj,si};
            tp1.brkPoint = bPoint1;
            
            bPoint2 = {si,sj};
            tp2 = Nodo(tp1,0,bPoint2, []);
            tp1.rLink = tp2;
            
            pi = Nodo(tp2,1,[],si);
            pj2 = Nodo(tp2,1,[],sj);
            
            tp2.lLink = pi;
            tp2.rLink = pj2;  
            
        end
        
             
    end
    

end

