classdef BST < handle
    properties
        root; %Nodo interno medio del �rbol
        height; %Altura del arbol
    end
    
    methods
        %Metodo constuctor de la clase 
        function obj = BST(root)
             obj.root = root;         
        end
        % Busca el arco justo encima del evento p, devuelve el nodo
        % asociado a dicho arco
        function Nodo = searchNode(obj, p,Q)
            pXCoor = p.xCoord();
            linepos = p.yCoord();
            found = 0;
            rt = obj.root;
                        
            while found == 0
                
                if rt.isArc == 1
                    Nodo = rt;
                    found = 1;
                else
                    brkCoord = rt.xCoord(linepos);
                    if pXCoor < brkCoord   
                        prevbk = rt.prev;
                        if isempty(prevbk) == 0

                            if pXCoor < rt.prev.xCoord(linepos)
                                rt = rt.prev;

                            else
                               Nodo = rt.lLink;
                               found = 1;

                            end
                        else
                           Nodo = rt.lLink;
                           found = 1;
                                
                        end
                        
                    else  
                        nextbp = rt.next;
                        if isempty(nextbp) == 0
                            if  pXCoor > rt.next.xCoord(linepos)
                                 rt = rt.next;

                            else
                                Nodo = rt.rLink;
                                found = 1;
                            end
                        else
                            Nodo = rt.rLink;
                            found = 1;
                        end
                    end
                
                    
                end
           end
            
           %Eliminar el evento de circulo asociado al nodo, ya que es una
            %falsa alarma
            ce = Nodo.circleEvent;
            if isempty(ce) == 0
                Nodo.circleEvent = [];
                Q.removeEvent(ce);
            end
            
            
           %{
            Verdadero
            while found == 0
                brkCoord = rt.xCoord(linepos);
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
            %}
            
            
           
        end
        %Funcion que inserta el arco correspondiente al nuevo evento de sitio p.
        function arcs = insertArc(obj, p, q, D)
            
            arcs = cell(1,3);
            pR = searchNode(obj, p, q);%Nodo externo(arco) que va a convertirse en nodo interno(brkPoint)
            sj = pR.giveSiteEvent();%Sitio del nodo 
            si = p; %Evento de sitio siendo agregado
            %Nodos nuevos
            pj2 = Nodo(1,[],sj);%Nuevo nodo externo con el mismo sitio del existente
            pi = Nodo(1,[],si); %Nuevo nodo externo con el sitio que se est� agregando;
            nodoInternoji = Nodo(0,[sj,si],[]); %Nodo interno izquierdo
            nodoInternoij = Nodo(0,[si,sj],[]); %Nodo interno derecho
            if obj.root.isArc == 1
                obj.root = nodoInternoji;
            end
            
            %Conexiones entre arcos
            pNext = pR.next;
            pR.next = pi;
            pi.prev = pR;
            pi.next = pj2;
            pj2.prev = pi;
            if isempty(pNext) == 0
                pj2.next = pNext;
                pNext.prev = pj2;
            else
                pj2.next = [];
            end
            %Conexiones entre nodos internos
            bp1 = pR.lLink;
            bp2 = pR.rLink;
            if isempty(bp1) == 0
                nodoInternoji.prev = bp1;
                bp1.next =  nodoInternoji;
            else
                 nodoInternoji.prev = [];
            end
            nodoInternoji.next =  nodoInternoij;
            nodoInternoij.prev = nodoInternoji;
            if isempty(bp2) == 0
                nodoInternoij.next = bp2;
                bp2.prev =  nodoInternoij;
            else
                nodoInternoij.next = [];
            end
            %Conexiones entre nodos internos y externos
            pR.rLink = nodoInternoji;
            nodoInternoji.lLink = pR;
            pi.lLink = nodoInternoji;
            nodoInternoji.rLink = pi;
            pi.rLink = nodoInternoij;
            nodoInternoij.lLink = pi;
            pj2.lLink = nodoInternoij;
            nodoInternoij.rLink = pj2;
            if isempty(bp2) == 0
                pj2.rLink = bp2;
                bp2.lLink = pj2;
            else
                pj2.rLink = [];
            end
            %Arcos para la verificaci�n de tripletas convergentes
            
            arcs{1,1}= pR;%Izquierda
            arcs{1,2}= pi;%Centro
            arcs{1,3}= pj2;%Derecha
            
           
            %Rutina que agrega el borde que empieza a ser trazado por
            %los dos nuevos breakpoints
            f = sj.face;
            e = Edge([],f,[],[],[]);
            ft = si.face;
            et = Edge([],ft,e,[],[]);
            e.twin = et;
            f.edge = e;
            ft.edge = et;

            e.node = nodoInternoji; %Conexi�n con el nodo interno que traza el borde. Los dos breakpoints trazan el mismo borde. Se asigna 1 al borde y el otro al gemelo.
            et.node = nodoInternoij;
            nodoInternoji.edge = e;
            nodoInternoij.edge = et;

            D.addEdge(e);
            
                
            %{    
            nodoInterno1.lLink = pi;
            pi.parent =  nodoInterno1;
            nodoInterno1.rLink = pj;
            pj.parent =  nodoInterno1;
            
            pR.lLink = pj2;
            pj2.parent =  pR;
            
            pR.rLink =  nodoInterno1;
            nodoInterno1.parent = pR;
            
            
            pPrev = pR.prev;
            pNext = pR.next;
            if isempty(pPrev)
                pj2.prev = [];
            else
                pj2.prev = pPrev;
                pPrev.next = pj2;
            end
            
            if isempty(pNext)
                pj.next = [];
            else
                pj.next = pNext;
                pNext.prev = pj;
            end
            
            pj2.next = pi;
            pi.prev = pj2;
            pi.next = pj;
            pj.prev = pi;
            
            %Transformaci�n de pR en nodo interno
            pR.brkPoint = [sj,si];
            pR.refreshState();
            
            arcs{1,1}= pj2;%Izquierda
            arcs{1,2}= pi;%Centro
            arcs{1,3}= pj;%Derecha
            %Rutina que agrega el borde que empieza a ser trazado por
                %los dos nuevos breakpoints
                f = sj.face;
                e = Edge([],f,[],[],[]);
                ft = si.face;
                et = Edge([],ft,e,[],[]);
                e.twin = et;
                f.edge = e;
                ft.edge = et;
                
                e.node = pR; %Conexi�n con el nodo interno que traza el borde. Los dos breakpoints trazan el mismo borde. Se asigna 1 al borde y el otro al gemelo.
                et.node = nodoInterno1;
                pR.edge = e;
                nodoInterno1.edge = et;
                
                D.addEdge(e);
                D.addFace(f);
            %}
            %{
            tpx = sj.xCoord();%Coordenadas
            pix = si.xCoord();
            
            if pix > tpx
                %Subarbol que inserta el nuevo arco cuando el sitio nuevo est� a
                %la derecha del sitio que genera el arco ya existente.
                tp1.lLink = pj;            
                tp1.refreshState();
            
                bPoint1 = {sj,si};
                tp1.brkPoint = bPoint1;%Nodo interno 
                
                bPoint2 = {si,sj};
                tp2 = Nodo(tp1,0,bPoint2, []);%Nodo interno
                tp1.rLink = tp2;
                
                pi = Nodo(tp2,1,[],si);
                pj2 = Nodo(tp2,1,[],sj);
                
                tp2.lLink = pi;
                tp2.rLink = pj2;
                
                arcs{1,1}= pj;%Izquierda
                arcs{1,2}= pi;%Centro
                arcs{1,3}= pj2;%Derecha
                
                %Conexiones entre nodos externos
                pi.prev = pj;
                pj.next = pi;
                
                pi.next = pj2;
                pj2.prev = pi;
                
                %Rutina que agrega el borde que empieza a ser trazado por
                %los dos nuevos breakpoints
                f = pi.site.face;
                e = Edge([],f,[],[],[]);
                ft = pj.site.face;
                et = Edge([],ft,e,[],[]);
                e.twin = et;
                f.edge = e;
                ft.edge = et;
                
                e.node = tp1; %Conexi�n con el nodo interno que traza el borde. Los dos breakpoints trazan el mismo borde. Se asigna 1 al borde y el otro al gemelo.
                et.node = tp2;
                tp1.edge = e;
                tp2.edge = et;
                
                %D.addEdge(e);
                %D.addFace(f);
                
                
            else 
                %Subarbol que inserta el nuevo arco cuando el sitio nuevo est� a
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
                
                %Conexiones entre nodos externos
                pi.prev = pj;
                pj.next = pi;
                
                pi.next = pj2;
                pj2.prev = pi;
                
                %Rutina que agrega el borde que empieza a ser trazado por
                %los dos nuevos breakpoints
                f = pj.site.face;
                e = Edge([],f,[],[],[]);
                ft = pi.site.face;
                et = Edge([],ft,e,[],[]);
                e.twin = et;
                f.edge = e;
                ft.edge = et;
                
                e.node = tp1; %Conexi�n con el nodo interno(brkPoint) que traza el borde.
                et.node = tp2;
                tp1.edge = e;
                tp2.edge = et;
                
                %D.addEdge(e);
                %D.addFace(f);
                
            end
            %}
            %}
        end
       
        
        
        function createCircleEvent(~,trip,Q)
            %Cell cuyo primer elemento es la tripleta con pi a la
            %izquierda. El segundo elemento es la tripleta con pi a la
            %derecha.           
            
            if isempty(trip{1,1})== 0
                [conv1, cc] = convergence(trip{1,1}(1,1),trip{1,1}(1,2),trip{1,1}(1,3));
                if conv1 == 1 %do add Q to trip{1,1}(1,2)
                    %cc = centroCirculo3Puntos(trip{1,1}(1,1),trip{1,1}(1,2),trip{1,1}(1,3));
                    r = cc(1,3);
                    % Punteros entre el nodo medio y el evento de circulo
                    % donde desaparecer�
                    ce = Evento(cc(1,1),cc(1,2)-r,1,trip{1,1}(1,2),r,[]);
                    trip{1,1}(1,2).circleEvent = ce;
                    Q.insertEvent(ce);
                end
                
            end
            if isempty(trip{1,2})== 0
                [conv2, cc] = convergence(trip{1,2}(1,1),trip{1,2}(1,2),trip{1,2}(1,3));
                if conv2 == 1 %do add Q to trip{1,1}(1,2)
                    %cc = centroCirculo3Puntos(trip{1,2}(1,1),trip{1,2}(1,2),trip{1,2}(1,3));
                    r = cc(1,3);
                    % Punteros entre el nodo medio y el evento de circulo
                    % donde desaparecer�
                    ce = Evento(cc(1,1),cc(1,2)-r,1,trip{1,2}(1,2),r,[]);
                    trip{1,2}(1,2).circleEvent = ce;
                    Q.insertEvent(ce);
                end
                
            end
        
        end
        
        %Elimina el arco que va a desaparecer cuando ocurre el evento de c�rculo ce 
        function  removeArc(obj, ce, Q,D)
            %1 Actualizaci�n del �rbol al eliminar pi
            %Nodo(arco) que va a desaparecer y sus nodos anterior y
            %siguiente
            pi = ce.nodo;
            %Nodos que representan los nodos adyacentes
            pj = pi.prev;
            pk = pi.next;
            ecPrev = pj.circleEvent;
            ecNext = pk.circleEvent;
            %Remover los eventos de c�rculo asociados a los nodos
            %adyacentes
            if isempty(ecPrev) == 0
                     Q.removeEvent(ecPrev);
                     pj.circleEvent = [];
            end
            if isempty(ecNext) == 0
                     Q.removeEvent(ecNext);
                     pk.circleEvent = [];
            end
            %Nodos que representan los brkpoints y los brkpoints siguientes
            pjpi = pi.lLink;
            pipk = pi.rLink;
            bp1 = pipk.next;
            %Actualizaci�n del �rbol
            pjpi.brkPoint(1,2) = pk.site;
            %Conexiones entre nodos internos
            pj.next = pk;
            pk.prev = pj;
            %Conexiones entre nodos externos
            pjpi.next = bp1;
            bp1.prev = pjpi;
            %Conexiones entre nodos internos y externos
            pj.rLink = pjpi;
            pjpi.lLink = pj;
            pjpi.rLink = pk;
            pk.lLink = pjpi;
            
            %Coordenadas del v�rtice, centro del evento de c�rculo
            rd = ce.r;
            xv = ce.x;
            yv = ce.y + rd;
            %Crear el v�rtice, el borde que empieza a crearse a�n no se
            %ha definido
            v = Vertex([],[xv,yv]);
            %V�rtices que fueron definidos por los breakpoints y que
            %terminan en el v�rtice.
            e1 = pjpi.edge;
            e2 = pipk.edge;
            e1tw = e1.twin;
            e2tw = e2.twin;
            %Se define el punto de origen de los bordes gemelos(punto final
            %de los bordes) como el v�rtice.
            e1tw.vertex = v;
            e2tw.vertex = v;
            %Remueve el evento de c�rculo de la lista de eventos Q.
            Q.removeEvent(ce);
            pi.circleEvent = [];
            D.addVertex(v);
            
            %Definici�n del nuevo borde que empieza a ser trazado por el
            %nuevo brkPoint pjpk
            
            newEdge = Edge(v,[],[],[],pjpi);
            pjpi.edge = newEdge;%Conexi�n borde con su nodo interno.
            newEdgeTw = Edge([],[],newEdge,[],pjpi);%Borde gemelo.
            newEdge.twin = newEdgeTw;%Conexi�n entre el borde y su gemelo.
            v.edge = newEdge;%Conexi�n entre el borde y su v�rtice

            leftFaceSite = pjpi.brkPoint(1,2); %Sitio del Face del borde
            leftFaceSiteTw = pjpi.brkPoint(1,1); %Sitio del Face del gemelo del borde
            leftFace = leftFaceSite.face; %Face del borde
            leftFace.edge = newEdge;
            leftFaceTw = leftFaceSiteTw.face; %Face del gemelo
            leftFaceTw.edge = newEdgeTw;

            newEdge.face = leftFace; % Conexi�n de los Faces con los bordes.
            newEdgeTw.face = leftFaceTw;

            %Conexi�n con los bordes consecutivos
            e2.next =  newEdge;
            e1.next = e2.twin;
            newEdgeTw.next = e1.twin;
            D.addEdge(newEdge);
            
            %Verificaci�n de nuevos eventos de c�rculo
            trip =  cell(1,2);
            if isempty(pj.prev)
                 trip{1,1} = [];
            else
                trip{1,1} = [pj.prev, pj, pk];
            end
            
            if isempty(pk.next)
                 trip{1,2} = [];
            else
               trip{1,2} = [pj, pk, pk.next];
            end
            
            
            obj.createCircleEvent(trip,Q);
            
            
            
            %{
            %Nodos padre internos
            piParent = pi.parent;
            prevParent = pPrev.parent;
            nextParent = pNext.parent;
            %Nodo padre superior
            pp = piParent.parent;
            
            sj = pPrev.site;
            si = pi.site;
            sk = pNext.site;
            %Actualizaci�n del �rbol
            if prevParent == piParent
                pp.brkPoint(1,1) = sj;
                pp.lLink = pPrev;
                pPrev.parent = pp;
                e1 = piParent.edge; %Definici�n de los bordes
                e2 = pp.edge;
            elseif nextParent == piParent
                pp.brkPoint(1,2) = sk;
                pp.rLink = pNext;
                pNext.parent = pp;
                e1 = pp.edge; %Definici�n de los bordes
                e2 = piParent.edge;
            else
                error('La cagaste pibe');
            end
            %Desconexi�n del arco que se elimina
            piParent.parent = [];
            piParent.rLink = [];
            piParent.lLink = [];
            
            %Conexi�n entre nuevos nodos externos
            pPrev.next = pNext;
            pNext.prev = pPrev;
            %Remover eventos de c�rculo asociados a nodos adyacentes
            ecPrev = pPrev.circleEvent;
            ecNext = pNext.circleEvent;
            
            if isempty(ecPrev) == 0
                     Q.removeEvent(ecPrev);
                     pPrev.circleEvent = [];
            end
            if isempty(ecNext) == 0
                     Q.removeEvent(ecNext);
                     pNext.circleEvent = [];
            end
            
            %Coordenadas del v�rtice, centro del evento de c�rculo
            rd = ce.r;
            xv = ce.x;
            yv = ce.y - rd;
            %Crear el v�rtice, el v�rtice que empieza a crearse a�n no se
            %ha definido
            v = Vertex([],[xv,yv]);
            %V�rtices que fueron definidos por los breakpoints y que
            %terminan en el v�rtice.
            
            e1tw = e1.twin;
            e2tw = e2.twin;
            %Se define el punto de origen de los bordes gemelos(punto final
            %de los bordes) como el v�rtice.
            e1tw.vertex = v;
            e2tw.vertex = v;
            %Remueve el evento de c�rculo de la lista de eventos Q.
            Q.removeEvent(ce);
            pi.circleEvent = [];
            D.addVertex(v);
            
            %Definici�n del nuevo borde que empieza a ser trazado por el
            %nuevo brkPoint pp
            
            newEdge = Edge(v,[],[],[],pp);
            pp.edge = newEdge;%Conexi�n borde con su nodo interno.
            newEdgeTw = Edge([],[],newEdge,[],pp);%Borde gemelo.
            newEdge.twin = newEdgeTw;%Conexi�n entre el borde y su gemelo.
            v.edge = newEdge;%Conexi�n entre el borde y su v�rtice

            leftFaceSite = pp.brkPoint(1,2); %Sitio del Face del borde
            leftFaceSiteTw = pp.brkPoint(1,1); %Sitio del Face del gemelo del borde
            leftFace = leftFaceSite.face; %Face del borde
            leftFace.edge = newEdge;
            leftFaceTw = leftFaceSiteTw.face; %Face del gemelo
            leftFaceTw.edge = newEdgeTw;

            newEdge.face = leftFace; % Conexi�n de los Faces con los bordes.
            newEdgeTw.face = leftFaceTw;

            %Conexi�n con los bordes consecutivos, cambia dependiendo
            %de si el �rbol va a la izquierda o a la derecha.
            e2.next =  newEdge;
            e1.next = e2.twin;
            newEdgeTw.next = e1.twin;
            D.addEdge(newEdge);
            
            %Verificaci�n de nuevos eventos de c�rculo
            trip =  cell(1,2);
            trip{1,1} = [pPrev.prev, pPrev, pNext];
            trip{1,2} = [pPrev, pNext, pNext.next];
            obj.createCircleEvent(trip,Q);
            
            %{
            %Se toman los nodos (internos y externos) asociados al arco que
            %va  a desaparecer y los breakpoints que trazan los bordes que terminan en el centro del c�rculo. 
            px = ce.nodo;
            p = px.parent;
            pp = p.parent;
            %Coordenadas del v�rtice, centro del evento de c�rculo
            rd = ce.r;
            xv = ce.x;
            yv = ce.y - rd;
            %Crear el v�rtice, el v�rtice que empieza a crearse a�n no se
            %ha definido
            v = Vertex([],[xv,yv]);
            %V�rtices que fueron definidos por los breakpoints y que
            %terminan en el v�rtice.
            e1 = p.edge;
            e2 = pp.edge;
            e1tw = e1.twin;
            e2tw = e2.twin;
            %Se define el punto de origen de los bordes gemelos(punto final
            %de los bordes) como el v�rtice.
            e1tw.vertex = v;
            e2tw.vertex = v;
            %Remueve el evento de c�rculo de la lista de eventos Q.
            Q.removeEvent(ce);
            px.circleEvent = [];
            D.addVertex(v);
            
            
          %Rutina para eliminar el arco asociado a ce y actualizar el �rbol    
            if px == p.lLink
                %bp = p.brkPoint;
                %n2 = bp{1,2};
                pr = p.rLink;
                found = 0;
                
                while found == 0
                    if isempty(pr.lLink) == 1
                        found = 1;
                    else
                        pr = pr.lLink;
                    end
                end
                ev = pr.circleEvent;
                if isempty(ev) == 0
                     Q.removeEvent(ev);
                     pr.circleEvent = [];
                end
                
                %Rutina para eliminar todos los eventos de c�rculo asociados a px
                
                ps = p.rLink;
                
            elseif px == p.rLink
                %bp = p.brkPoint;
                %n2 = bp{1,1};
                pl = p.lLink;%Arbol a la izquierda de p.
                found = 0;
                while found == 0
                    if isempty(pl.rLink) == 1
                        found = 1;
                    else
                        pl = pl.rLink;
                    end
                end
                ev = pl.circleEvent;
                if isempty(ev) == 0
                    Q.removeEvent(ev);
                    pl.circleEvent = [];
                end
                %Rutina para eliminar todos los eventos de c�rculo asociados a px
               
                ps = p.lLink;
                
            end
            
            if p == pp.lLink
                
                pr2 = pp.rLink;%Arbol a la derecha de pp.
                found = 0;
                
                while found == 0
                    if isempty(pr2.lLink) == 1
                        found = 1;
                    else
                        pr2 = pr2.lLink;
                    end
                end
                %Rutina para eliminar todos los eventos de c�rculo asociados a px
                ev = pr2.circleEvent;
                if isempty(ev)== 0
                     Q.removeEvent(ev);
                     pr2.circleEvent = [];
                end
                         
                %Actualizaci�n del �rbol
                pp.lLink = ps;
                ev2 = pl.site;
                pp.brkPoint{1,1} = ev2;
                
                %pp es el nuevo breakpoint que est� trazando el nuevo borde
                ps.parent = pp;

                %Definici�n del nuevo borde.
                newEdge = Edge(v,[],[],[],pp);
                pp.edge = newEdge;%Conexi�n borde con su nodo interno.
                newEdgeTw = Edge([],[],newEdge,[],pp);%Borde gemelo.
                newEdge.twin = newEdgeTw;%Conexi�n entre el borde y su gemelo.
                v.edge = newEdge;%Conexi�n entre el borde y su v�rtice

                leftFaceSite = pp.brkPoint{1,2}; %Sitio del Face del borde
                leftFaceSiteTw = pp.brkPoint{1,1}; %Sitio del Face del gemelo del borde

                leftFace = leftFaceSite.face; %Face del borde
                leftFace.edge = newEdge;
                leftFaceTw = leftFaceSiteTw.face; %Face del gemelo
                leftFaceTw.edge = newEdgeTw;

                newEdge.face = leftFace; % Conexi�n de los Faces con los bordes.
                newEdgeTw.face = leftFaceTw;
                
                %Conexi�n con los bordes consecutivos, cambia dependiendo
                %de si el �rbol va a la izquierda o a la derecha.
                e2.next =  newEdge;
                e1.next = e2.twin;
                newEdgeTw.next = e1.twin;
                D.addEdge(newEdge);
                %{
                found = 0;
                pk = ps.rLink;
                while found == 0
                    if isempty(pk.rLink) == 1
                        found = 1;
                    else
                        pk = pk.rLink;
                    end
                end
                
                %}
            elseif p == pp.rLink
                
                pl2 = pp.lLink;%Arbol a la izquierda de pp.
                found = 0;
                
                while found == 0
                    if isempty(pl2.rLink) == 1
                        found = 1;
                    else
                        pl2 = pl2.rLink;
                    end
                end
                %Rutina para eliminar todos los eventos de c�rculo asociados a px
                ev = pl2.circleEvent;
                if isempty(ev) == 0
                    Q.removeEvent(ev);                
                    pl2.circleEvent = [];
                end
                
                
                %Actualizaci�n del �rbol
                pp.rLink = ps;
                ev2 = pr.site;
                pp.brkPoint{1,2} = ev2;
                
                 %pp es el nuevo breakpoint que est� trazando el nuevo borde
                ps.parent = pp;

                %Definici�n del nuevo borde.
                newEdge = Edge(v,[],[],[],pp);
                pp.edge = newEdge;%Conexi�n borde con su nodo interno.
                newEdgeTw = Edge([],[],newEdge,[],pp);%Borde gemelo.
                newEdge.twin = newEdgeTw;%Conexi�n entre el borde y su gemelo.
                v.edge = newEdge;%Conexi�n entre el borde y su v�rtice

                leftFaceSite = pp.brkPoint{1,2}; %Sitio del Face del borde
                leftFaceSiteTw = pp.brkPoint{1,1}; %Sitio del Face del gemelo del borde

                leftFace = leftFaceSite.face; %Face del borde
                leftFace.edge = newEdge; 
                leftFaceTw =  leftFaceSiteTw.face; %Face del gemelo
                leftFaceTw.edge = newEdgeTw;

                newEdge.face = leftFace; % Conexi�n de los Faces con los bordes.
                newEdgeTw.face = leftFaceTw;
                
                %Conexi�n con los bordes consecutivos, cambia dependiendo
                %de si el �rbol va a la izquierda o a la derecha.
                e1.next =  newEdge;
                e2.next = e1.twin;
                newEdgeTw.next = e2.twin; 
                D.addEdge(newEdge);
                %{
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
                %}
                
            end
            
            %}  
            %}
        end
        
    function  balanceTree(obj)
        rt = obj.root;
        found = 0;
        n = 1;
        while found == 0
            if isempty(rt.prev) == 0
                rt = rt.prev;
            else
                found = 1;
            end
        end
        first = rt;
        fin = 0;
        while fin == 0
            if isempty(rt.next) == 0
                rt = rt.next;
                n = n + 1;
            else
                fin = 1;
            end
            
        end
        i = 1;
        n = round(n/2);
        while i <= n
            first = first.next;
            i = i + 1;
        end
        obj.root = first;
        
            
        
    
    end
    
     
             
    end
    

end

