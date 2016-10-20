function s = VD(n,ancho,alto)
    p = points(n,ancho,alto);
    %{
    p = [       
          
        
        
        2.1875    3.6629
        3.6232    3.8824
        3.8300    3.1688
        2.35      4.93
        1.71      4.
        3.8596    3.8380
        1.1140    1.6870
        
       
        
        
        
       
        ];
    %}
     %{
       0.5079    3.8287
         3.2589    0.6305
       0.3902    0.5675
        
   
        
        
    %}    
    %p = sortrows(p,2);    
        %{
      
        
        
        ];
     %}
    
    %{
    p = [
         
         0.76 3.08
         3    2.54];
    %}
    %q = Q([],[]);
    q = binHeap(n);
    DC = DCEL();
    %Plot de los sitios
    plot(p(:,1),p(:,2),'.');
    hold on;
    n = size(p);
    %e = Evento(p(1,1),p(1,2),0,[],[]);
    %q.head = e;
    %Iniciar estructuras de datos Q y DCEL
    p = sortrows(p,-2);
    for i = 1:n(1,1)
        e = Evento(p(i,1),p(i,2),0,[],[],[]);
        q.insertEvent(e);
        f = Face([],e);
        DC.addFace(f);
        e.face = f;
    end
    %Iniciar árbol binario T
    head = q.removeEvent();
    root = Nodo(1,[],head);
    T = BST(root);
     
    %Algoritmo de Fortune
    counter = 0;
    finish = 0;
    while finish == 0
        if q.currentSize == 0
            finish = 1;
        else 
            ev = q.removeEvent();
            
            %Manejo de evento de sitio
            if ev.type == 0
                
                arcs = T.insertArc(ev,q,DC);
                trip = triples(arcs);
                T.createCircleEvent(trip,q);
                %{
                for i=1:counter
                x = -50:0.1:50;
                y = (x.^2 -2.*p(1,1)*x +p(1,1).^2 + p(1,2).^2 - ev.yCoord().^2)/(2.*(p(1,2)-ev.yCoord()));
                plot(x,y);
                end
                %}
            %Manejo de evento de círculo
            elseif ev.type == 1 && ev.valido == true
                T.balanceTree();
                T.removeArc(ev,q,DC);
                
            end
            
            
        end
        counter  = counter +1;
    end
    %}
    %
%Rutina para el dibujo de los vértices
    vert = DC.vertices;
    f = size(vert);
    vx = zeros(f(1,1),2);
    for i = 1:f(1,1)
        vx(i,:) = vert{i,1}.pos;
    end
    %
    [s, col] = size(DC.edges);
    k = 1;
    %{
    Revisa si los vértices existentes se encuentran dentro del BBx
    for i = 1:s
        ei = DC.edges{i,1};
        v1 = ei.vertex;
        et = ei.twin;
        v2 = et.vertex;
        
        if ~isempty(v1) && ~isempty(v2)
           if (v1.pos(1,1) > ancho || v1.pos(1,1) < 0 || v1.pos(1,2) > alto || v1.pos(1,2) < 0) && (v2.pos(1,1) > ancho || v2.pos(1,1) < 0 || v2.pos(1,2) > alto || v2.pos(1,2) < 0)
                %Falta :Eliminar ambos vértices
                %Caso donde el borde se encuentra completamnete fuera del box.
                %Ambos vertices estpan fuera. No se agrega dicho borde al nuevo
                %cell array
                
            elseif v1.pos(1,1) > ancho || v1.pos(1,1) < 0 || v1.pos(1,2) > alto || v1.pos(1,2) < 0  
                %Caso donde el vertice se encuentra fuera del box. Deberia
                %convertir el borde en una línea semi-infinita, eliminando
                %el borde exterior
                ei.vertex = [];
                edges2{k,1} = ei;
                k = k + 1;
            elseif v2.pos(1,1) > ancho || v2.pos(1,1) < 0 || v2.pos(1,2) > alto || v2.pos(1,2) < 0
                %Caso donde el vertice se encuentra fuera del box. Deberia
                %convertir el borde en una línea semi-infinita, eliminando
                %el borde exterior
                ei.twin.vertex = [];
                edges2{k,1} = ei;
                k = k + 1;
           else
                %El borde se encuentra completamente dentro del box
                edges2{k,1} = ei;
                k = k + 1;
            end
        
        elseif ~isempty(v1) && isempty(v2)
            %Analiza los casos donde un vértice no existe y el otro se
            %encuentra por fuera.
             if v1.pos(1,1) > ancho || v1.pos(1,1) < 0 || v1.pos(1,2) > alto || v1.pos(1,2) < 0
             else
                edges2{k,1} = ei;
                k = k + 1;    
             end
        elseif ~isempty(v2) && isempty(v1)
            if v2.pos(1,1) > ancho || v2.pos(1,1) < 0 || v2.pos(1,2) > alto || v2.pos(1,2) < 0
            
            else 
                edges2{k,1} = ei;
                k = k + 1;
            end
            
        end
        
    end
    DC.edges = edges2;
    [s, col] = size(DC.edges);
    %Rutina para el dibujo de los bordes
    for i=1:s
        ei = DC.edges{i,1};
        v1 = ei.vertex;
        et = ei.twin;
        v2 = et.vertex;
        
        f1 = ei.face;
        f2 = et.face;

        s1 = f1.site;
        s2 = f2.site;
        
      
        if isempty(v1) 
           
           ccomp = boundBox(ancho,alto,s1,s2,v2);
           v1x = v2.pos(1,1);
           v1y = v2.pos(1,2);
           v2x = ccomp(1,1);
           v2y = ccomp(1,2);
           plot([v1x v2x],[v1y v2y], 'g');
                      
        elseif isempty(v2)
            
           ccomp = boundBox(ancho,alto,s1,s2,v1);
           v1x = ccomp(1,1);
           v1y = ccomp(1,2);
           v2x = v1.pos(1,1);
           v2y = v1.pos(1,2);
           plot([v1x v2x],[v1y v2y], 'g');
        else
            v1x = v1.pos(1,1);
            v1y = v1.pos(1,2);
            v2x = v2.pos(1,1);
            v2y = v2.pos(1,2);
            
            plot([v1x v2x],[v1y v2y], 'g');
        end
    end
    %}
    %{
    Struct donde se guarda la información a  dibujar del diagrama
    B = struct([]);
    faces = DC.faces;
    for i=1:n
        
        fi = faces{i,1};
        e0 = fi.edge;
        ei = e0;
        found = 0;
        j = 1;
        while found == 0    
            v = ei.vertex;
            if isempty(v)
                v1x = NaN;
                v1y = NaN;
            else
                v1x = ei.vertex.pos(1,1);
                v1y = ei.vertex.pos(1,2);
            end
            tw = ei.twin;
            vw = tw.vertex;
            if isempty(vw)
                v2x = NaN;
                v2y = NaN;
            
            else
                v2x = ei.twin.vertex.pos(1,1);
                v2y = ei.twin.vertex.pos(1,2);
            
            end
        
           
            B(i).i.col(j,1) = v1x;
            B(i).i.col(j,2) = v1y;
            B(i).i.col(j,3) = v2x;
            B(i).i.col(j,4) = v2y;
            
            if isnan(v1x) || isnan(v2x)
            
            else
                plot([v1x v2x], [v1y v2y],'g');
            end
            
    
            ei = ei.next;
            j  = j + 1;
            if isequal(ei,e0) || isempty(ei)
                found = 1;
            end
    
            
        end
        
    end
    %}
    
    axis equal;
    plot(vx(:,1),vx(:,2),'g.');
    hold on;
    plot([0 ancho ancho 0 0], [0 0 alto alto 0], 'g');
    %voronoi(p(:,1),p(:,2));
    
end