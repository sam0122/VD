function q = test()
%r = cells(10,1);
p1 = Evento(2.35,4.93,0,[],[],[]);
p2 = Evento(1.71,4,0,[],[],[]);
p3 = Evento(3.6232,3.8824,0,[],[],[]);
%p4 = Evento(3.8596, 3.8380,0,[],[],[]);
p4 = Evento( 2.1875,3.6629,0,[],[],[]);
%p6 = Evento( 3.8300, 3.1688,0,[],[],[]);
%p7 = Evento( 1.1140, 1.6870,0,[],[],[]);

       
NodoRaiz = Nodo(1,[],p1);
plot(p1.xCoord,p1.yCoord,'.');
hold on;
plot(p2.xCoord,p2.yCoord,'.');
hold on;
plot(p3.xCoord,p3.yCoord,'.');
hold on;
plot(p4.xCoord,p4.yCoord,'.');
hold on;
%plot(p5.xCoord,p5.yCoord,'.');
%hold on;
%plot(p6.xCoord,p6.yCoord,'.');
%hold on;
%plot(p7.xCoord,p7.yCoord,'.');

x = -50:0.1:50;
y = (x.^2 -2.*p1.xCoord.*x +p1.xCoord.^2 + p1.yCoord.^2 - p4.yCoord.^2)/(2.*(p1.yCoord-p4.yCoord));

hold on;
plot(x,y,'k');
hold on;
plot(p2.xCoord,p2.yCoord,'.');
hold on;
y2 = (x.^2 -2.*p2.xCoord.*x +p2.xCoord.^2 + p2.yCoord.^2 - p4.yCoord.^2)/(2.*(p2.yCoord-p4.yCoord));
hold on;
plot(x,y2,'k');
hold on;
plot(p3.xCoord,p3.yCoord,'.');
y3 = (x.^2 -2.*p3.xCoord.*x +p3.xCoord.^2 + p3.yCoord.^2 - p4.yCoord.^2)/(2.*(p3.yCoord-p4.yCoord));
hold on;
plot(x,y3,'k');
ylim([0 10]);
xlim([-10 10]);

y4 = (x.^2 -2.*p4.xCoord.*x +p4.xCoord.^2 + p4.yCoord.^2 - p4.yCoord.^2)/(2.*(p4.yCoord-p4.yCoord));
hold on;
plot(x,y4,'k');
%{
y5 = (x.^2 -2.*p5.xCoord.*x +p5.xCoord.^2 + p5.yCoord.^2 - p7.yCoord.^2)/(2.*(p5.yCoord-p7.yCoord));
hold on;
plot(x,y5,'b');
y6 = (x.^2 -2.*p6.xCoord.*x +p6.xCoord.^2 + p6.yCoord.^2 - p7.yCoord.^2)/(2.*(p6.yCoord-p7.yCoord));
hold on;
plot(x,y6,'k');

%co = brkCoord(pk.xCoord,pk.yCoord,pj.xCoord,pj.yCoord,pi.yCoord);
%}
%{

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
%{
q = Q([],[]);
N1 = Nodo(1,[],p1);
N2 = Nodo(1,[],p2);
N5 = Nodo(1,[],p5);
N7 = Nodo(1,[],p7);
trips = {[N1,N2,N7],[N7,N2,N5]};
t.createCircleEvent(trips,q );
%arcs1= t.insertArc(p2);
%p = t.searchNode(pi,q);
%arcs2 = t.insertArc(p3);
%arcs3 = t.insertArc(p4);
%{
%p = t.searchNode(pr,q);
t.createCircleEvent(arcs2,q);

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
%}
end
