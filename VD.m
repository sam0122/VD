function [q,T] = VD(n,a,b)
    p = points(n,a,b);
    q = Q([],[]);
    DC = DCEL();
    %Plot de los sitios
    plot(p(:,1),p(:,2),'.');
    
    %e = Evento(p(1,1),p(1,2),0,[],[]);
    %q.head = e;
    %Iniciar estructuras de datos Q y DCEL
    for i = 1:n
        e = Evento(p(i,1),p(i,2),0,[],[],[]);
        q.insertEvent(e);
        f = Face([],e);
        DC.addFace(f);
        e.face = f;
    end
    %Iniciar árbol binario T
    head = q.head;
    root = Nodo([],1,[],head);
    T = BST(root);
    q.removeEvent(head);
    %Algoritmo de Fortune
    counter = 0;
    finish = 0;
    while finish == 0
        if q.head == q.tail
            finish = 1;
        else 
            ev = q.head;
            
            %Manejo de evento de sitio
            if ev.type == 0
                q.removeEvent(ev);
                arcs = T.insertArc(ev,DC);
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
                T.removeArc(ev,q,DC);
                
            else
                
                error('Tipo de evento no permitido');
            end
            
            
        end
        counter  = counter +1;
    end
    %}
    
end