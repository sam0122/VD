function t = test()
%r = cells(10,1);
pj = Evento(4,10,0);
pk = Evento(6,7,0);
pi = Evento(8,5,0);

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

t.insertArc(pk);
t.insertArc(pi);

end
