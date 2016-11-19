s1 = Evento(13.5,13.5);
f1 = Face([], s1);
s2 = Evento(8.5,13.5);
f2 = Face([], s2);
s3 = Evento(18.5,13.5);
f3 = Face([], s3);
%------------------------------------------------------
v1 = Vertex([],11,12);
v2 = Vertex([],16,12);
e1 = Edge(v1, f1);
e2 = Edge(v2, f1);
e4 = Edge([], f1);
e2t = Edge([],f3);
e4t = Edge(v1,f2);
%-----------------------------------------------------
f1.edge = e1;
f2.edge = e4t;
f3.edge = e2t;
%------------------------------------------------------
v1.edge = e1;
v2.edge = e2;
%-----------------------------------------------------
e1.next = e2;
e2.next = [];
%e3.next = e4;
e4.next = e1;
e1.prev = e4;
e4.prev = [];
%e3.prev = e2;
e2.prev = e1;
%-------------------------------------------------------
e2.twin = e2t;
e2t.twin = e2;
e4.twin = e4t;
e4t.twin = e4;
%--------------------------------------------------------
xmin = 0;
ymin= 0;
xmax= 20;
ymax = 15;
%----------------------------------------------------------
pol = f1.processFace(xmin, ymin, xmax, ymax)