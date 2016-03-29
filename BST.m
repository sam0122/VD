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
        %Funcion que inserta el arco correspondiente al nuevo sitio p.
        function arcs = insertArc(obj, p)
            
            arcs = cell(1,3);
            tp1 = searchNode(obj, p);
            sj = tp1.giveSiteEvent();
            pj = Nodo(tp1,1,[],sj);
            si = p;
            tpx = sj.xCoord();
            pix = si.xCoord();
            
            if pix > tpx
                %Subarbol que inserta el nuevo arco cuando el sitio nuevo está a
                %la derecha del sitio que genera el arco ya existente.
                tp1.lLink = pj;            
                tp1.refreshState();
            
                bPoint1 = {sj,si};
                tp1.brkPoint = bPoint1;
                
                bPoint2 = {si,sj};
                tp2 = Nodo(tp1,0,bPoint2, []);
                tp1.rLink = tp2;
                
                pi = Nodo(tp2,1,[],si);
                pj2 = Nodo(tp2,1,[],sj);
                
                tp2.lLink = pi;
                tp2.rLink = pj2;
                
                arcs(1,1)= pj;%Izquierda
                arcs(1,2)= pi;%Centro
                arcs(1,3)= pj2;%Derecha
            else 
                %Subarbol que inserta el nuevo arco cuando el sitio nuevo está a
                %la izquierda del sitio que genera el arco ya existente.
                tp1.rLink = pj;            
                tp1.refreshState();
            
                bPoint1 = {si,sj};
                tp1.brkPoint = bPoint1;
                
                bPoint2 = {sj,si};
                tp2 = Nodo(tp1,0,bPoint2, []);
                tp1.lLink = tp2;
                
                pi = Nodo(tp2,1,[],si);
                pj2 = Nodo(tp2,1,[],sj);
                
                tp2.rLink = pi;
                tp2.lLink = pj2;
                
                arcs(1,1)= pj2;%Izquierda
                arcs(1,2)= pi;%Centro
                arcs(1,3)= pj;%Derecha
                
            end
            
        end
        %Funcion que encuentra los arcos consecutivos 
        function trip = triples(obj,arcs)
            
            trip =  cell(1,2);
            
            pj= arcs{1,1};
            pi= arcs{1,2};
            pj2 = arcs{1,3}; 
        
            n1 = pj2.parent;
            found = false;
            
            %Primer elemento de la celda guarda la tripleta en la que pi es
            %el nodo izquierdo.Segundo elemento guarda la tripleta enla que
            %pi es el nodo derecho.
            if eq(pj2,n1.lLink)
                n2 = n1.rLink;
                while found == false
                    if n2.isArc == 0
                        n2 = n2.lLink;
                    else
                        pk = n2;
                        found = true;
                        trip{1,1} = [pi,pj2,pk];
                        
                    end
                    
                end
            else
                n2 = n1.lLink;
                while found == false
                    if n2.isArc == 0
                        n2 = n2.rLink;
                    else
                        pk = n2;
                        found = true;
                        trip{1,2} = [pk,pj2,p1];
                    end
                    
                end
                
                
            end
            
            n3 = pi.parent;
            n4 = n3. parent;
            n5 = n4.parent;
            
            if isempty(n5)== 0
                if eq(n4,n5.rLink)
                n6 = n5.lLink;
                    while found == false
                        if n6.isArc == 0
                             n6 = n6.rLink;
                        else
                             pm = n6;
                             found = true;
                             trip{1,2} = [pm,pj,pi];
                        
                         end
                    
                    end
                else
                    n6 = n5.rLink;
                    while found == false
                         if n6.isArc == 0
                             n6 = n6.lLink;
                         else
                              pm = n6;
                              found = true;
                              trip{1,1} = [pi,pj,pm];
                        
                         end
                    
                    end
                    
                end
                
                
                
            end
        end
        
        
        
             
    end
    

end

