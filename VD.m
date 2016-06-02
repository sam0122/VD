function DC = VD(n,a,b)
    p = points(n,a,b);
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
    q = Q([],[]);
    DC = DCEL();
    %Plot de los sitios
    plot(p(:,1),p(:,2),'.');
    hold on;
    n = size(p);
    %e = Evento(p(1,1),p(1,2),0,[],[]);
    %q.head = e;
    %Iniciar estructuras de datos Q y DCEL
    for i = 1:n(1,1)
        e = Evento(p(i,1),p(i,2),0,[],[],[]);
        q.insertEvent(e);
        f = Face([],e);
        DC.addFace(f);
        e.face = f;
    end
    %Iniciar árbol binario T
    head = q.head;
    root = Nodo(1,[],head);
    T = BST(root);
    q.removeEvent(head);
    %Algoritmo de Fortune
    counter = 0;
    finish = 0;
    while finish == 0
        if isempty(q.head) && isempty(q.tail)
            finish = 1;
        else 
            ev = q.head;
            
            %Manejo de evento de sitio
            if ev.type == 0
                q.removeEvent(ev);
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
            elseif ev.type == 1
                T.balanceTree();
                T.removeArc(ev,q,DC);
                
            else
                
                error('Tipo de evento no permitido');
            end
            
            
        end
        counter  = counter +1;
    end
    %}
    vert = DC.vertices;
    f = size(vert);
    vx = zeros(f(1,1),2);
    for i = 1:f(1,1)
        vx(i,:) = vert{i,1}.pos;
    end
    
    axis equal;
    plot(vx(:,1),vx(:,2),'g.');
    hold on;
    voronoi(p(:,1),p(:,2));
    
end