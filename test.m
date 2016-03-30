function t = test()
%r = cells(10,1);
pj = Evento(7,10,0,[]);
pk = Evento(10.3,8,0,[]);
pi = Evento(4.5,8.2,0,[]);

NodoRaiz = Nodo([],1,[],pj);

%{
NodoRaiz.xCoord(3);
NodoRaiz.giveLeft();
NodoRaiz.giveRight();
NodoRaiz.giveParent();
NodoRaiz.giveSiteEvent();
%}

%Nodo1 = Nodo(NodoRaiz,1,[],pk);
%NodoRaiz.rLink = Nodo1;
%NodoRaiz.refreshState();
%NodoRaiz.status();
%{
brkpoint = {pj,pk};
NodoRaiz.brkPoint = brkpoint;

linepos = pi.yCoord();
NodoRaiz.xCoord(linepos);
Nodo1.site;
%}
t = BST(NodoRaiz);
%Nodo2 = t.searchNode(pi);
%centroCirculo(brkpoint, linepos)

arcs1 = t.insertArc(pi);
t.createCircleEvent(arcs1);
arcs2= t.insertArc(pk);
t.createCircleEvent(arcs2);
%conv = convergence(pi, pj, pk);


end
