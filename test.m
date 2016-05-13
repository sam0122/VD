function conv1 = test()
%r = cells(10,1);
p1 = Evento(2.35,4.93,0,[],[],[]);
p2 = Evento(1.71,4.66,0,[],[],[]);
p3 = Evento(0.76,3.08,0,[],[],[]);
%pr = Evento(4,5,0,[],[],[]);
NodoRaiz = Nodo([],1,[],p1);

x = -50:0.1:50;
y = (x.^2 -2.*p1.xCoord.*x +p1.xCoord.^2 + p1.yCoord.^2 - p3.yCoord.^2)/(2.*(p1.yCoord-p3.yCoord));
plot(p1.xCoord,p1.yCoord,'.');
hold on;
plot(x,y);
hold on;
plot(p2.xCoord,p2.yCoord,'.');
hold on;
y2 = (x.^2 -2.*p2.xCoord.*x +p2.xCoord.^2 + p2.yCoord.^2 - p3.yCoord.^2)/(2.*(p2.yCoord-p3.yCoord));
hold on;
plot(x,y2);
hold on;
plot(p3.xCoord,p3.yCoord,'.');
ylim([0 20]);
xlim([-10 10]);
%co = brkCoord(pk.xCoord,pk.yCoord,pj.xCoord,pj.yCoord,pi.yCoord);
%}
%{
y3 = (x.^2 -2.*pi.xCoord.*x +pi.xCoord.^2 + pi.yCoord.^2 - pr.yCoord.^2)/(2.*(pi.yCoord-pr.yCoord));
hold on;
plot(x,y3);
%}

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
brkpoint = {pj.site,pk.site};
NodoRaiz.brkPoint = brkpoint;

linepos = pi.yCoord();
NodoRaiz.xCoord(linepos);
Nodo1.site;
%}
%t = BST(NodoRaiz);
%Nodo2 = t.searchNode(pi);
%centroCirculo(brkpoint, linepos)

%q = Q([],[]);

%t.createCircleEvent(arcs1);
%arcs1= t.insertArc(pk);
%p = t.searchNode(pi,q);
%arcs2 = t.insertArc(pi);
%{
%p = t.searchNode(pr,q);
t.createCircleEvent(arcs2,q);
arcs3 = t.insertArc(pr);
tr = triples (arcs3);
conv1 = convergence(tr{1,1}(1,1),tr{1,1}(1,2),tr{1,1}(1,3));
%t.createCircleEvent(arcs3,q);
%conv = convergence(pi, pj, pk);
plot(pj.xCoord,pj.yCoord,'.');
hold on;
plot(pk.xCoord,pk.yCoord,'.');
hold on;
plot(pi.xCoord,pi.yCoord,'.');
hold on;
plot(pr.xCoord,pr.yCoord,'.');
%}
end
