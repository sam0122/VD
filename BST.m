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
                
                arcs{1,1}= pj;%Izquierda
                arcs{1,2}= pi;%Centro
                arcs{1,3}= pj2;%Derecha
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
                
                arcs{1,1}= pj;%Derecha
                arcs{1,2}= pi;%Centro
                arcs{1,3}= pj2;%Izquierda
                
            end
            
        end
       
        
        
        function createCircleEvent(~,arcs,q)
            %Cell cuyo primer elemento es la tripleta con pi a la
            %izquierda. El segundo elemento es la tripleta con pi a la
            %derecha.           
            trip = triples(arcs);
            if isempty(trip{1,1})== 0
                conv1 = convergence(trip{1,1}(1,1),trip{1,1}(1,2),trip{1,1}(1,3));
                if conv1 == 1 %do add Q to trip{1,1}(1,2)
                    cc = centroCirculo3Puntos(trip{1,1}(1,1),trip{1,1}(1,2),trip{1,1}(1,3));
                    r = cc(1,3);
                    % Punteros entre el nodo medio y el evento de circulo
                    % donde desaparecerá
                    ce = Evento(cc(1,1),cc(1,2)+r,1,trip{1,1}(1,2));
                    trip{1,1}(1,2).circleEvent = ce;
                    q.insertEvent(ce);
                end
                
            end
            if isempty(trip{1,2})== 0
                conv2 = convergence(trip{1,2}(1,1),trip{1,2}(1,2),trip{1,2}(1,3));
                if conv2 == 1 %do add Q to trip{1,1}(1,2)
                    cc = centroCirculo3Puntos(trip{1,2}(1,1),trip{1,2}(1,2),trip{1,2}(1,3));
                    r = cc(1,3);
                    % Punteros entre el nodo medio y el evento de circulo
                    % donde desaparecerá
                    ce = Evento(cc(1,1),cc(1,2)+r,1,trip{1,2}(1,2));
                    trip{1,2}(1,2).circleEvent = ce;
                    q.insertEvent(ce);
                end
                
            end
        
        end
        
        %Elimina el arco que va a desaparecer cuando ocurre el evento de círculo ce 
        function  removeArc(~, ce, Q)
          
            px = ce.nodo;
            p = px.parent;
            pp = p.parent;
            Q.removeEvent(ce);
            px.circleEvent = [];
            
            
          %Rutina para eliminar el arco asociado a ce y actualizar el árbol    
            if px == p.lLink
                bp = p.brkPoint;
                n2 = bp{1,2};
                ev = n2.circleEvent;
                Q.removeEvent(ev);%Rutina para eliminar todos los eventos de círculo asociados a px
                n2.circleEvent = [];
                ps = p.rLink;
            elseif px == p.rLink
                bp = p.brkPoint;
                n2 = bp{1,1};
                ev = n2.circleEvent;
                Q.removeEvent(ev);%Rutina para eliminar todos los eventos de círculo asociados a px
                n2.circleEvent = [];
                ps = p.lLink;
            end
            
            if p == pp.lLink
                
                bp = pp.brkPoint;
                n2 = bp{1,2};
                ev = n2.circleEvent;
                Q.removeEvent(ev);%Rutina para eliminar todos los eventos de círculo asociados a px
                n2.circleEvent = [];
                
                pp.lLink = ps;
                found = 0;
                pk = ps.rLink;
                while found == 0
                    if isempty(pk.rLink) == 1
                        found = 1;
                    else
                        pk = pk.rLink;
                    end
                end
                pp.brkPoint{1,1} = pk;
            elseif p == pp.rLink
                
                bp = pp.brkPoint;
                n2 = bp{1,1};
                ev = n2.circleEvent;
                Q.removeEvent(ev);%Rutina para eliminar todos los eventos de círculo asociados a px
                n2.circleEvent = [];
                
                pp.rLink = ps;
                found = 0;
                pk = ps.lLink;
                while found == 0
                    if isempty(pk.lLink) == 1
                        found = 1;
                    else
                        pk = pk.lLink;
                    end
                end
                pp.brkPoint{1,2} = pk;
                
            end
            
            ps.parent = pp;
            
            

        end
        
        
        
             
    end
    

end

