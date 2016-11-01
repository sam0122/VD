%Rutina de prueba para el DCEL
%Creación de los sitios
s1 = Evento(-0.5, 0.5);
s2 = Evento(0.5, 0.5);
s3 = Evento(-0.5, -0.5);
s4 = Evento(0.5, -0.5);
%Creación de las caras
f1 = Face([],s1);
f2 = Face([],s2);
f3 = Face([],s3);
f4 = Face([],s4);
%Creación de los vértices
v1 = Vertex([],-1,1);
v2 = Vertex([],0,1);
v3 = Vertex([],1,1);
v4 = Vertex([],-1,0);
v5 = Vertex([],0,0);
v6 = Vertex([],1,0);
v7 = Vertex([],-1,-1);
v8 = Vertex([],0,-1);
v9 = Vertex([],1,-1);
%Creación de los bordes
e21 = Edge(v2,f1,[],[],[]);
e14 = Edge(v1,f1,[],[],[]);
e45 = Edge(v4,f1,[],[],[]);
e52 = Edge(v5,f1,[],[],[]);

e56 = Edge(v5,f2,[],[],[]);
e63 = Edge(v6,f2,[],[],[]);
e32 = Edge(v3,f2,[],[],[]);
e25 = Edge(v2,f2,[],[],[]);

e78 = Edge(v7,f3,[],[],[]);
e85 = Edge(v8,f3,[],[],[]);
e54 = Edge(v5,f3,[],[],[]);
e47 = Edge(v4,f3,[],[],[]);

e89 = Edge(v8,f4,[],[],[]);
e96 = Edge(v9,f4,[],[],[]);
e65 = Edge(v6,f4,[],[],[]);
e58 = Edge(v5,f4,[],[],[]);
%Conexión entre elementos
e21.prev = e52;
e21.next = e14;

e14.prev = e21;
e14.next = e45;

e45.prev = e14;
e45.next = e52;
e45.twin = e54;

e52.prev = e45;
e52.next = e21;
e52.twin = e25;
%----------------------------
e32.prev = e63;
e32.next = e25;

e63.prev = e56;
e63.next = e32;

e25.prev = e32;
e25.next = e56;
e25.twin = e52;

e56.prev = e25;
e56.next = e63;
e56.twin = e65;
%----------------------------
e47.prev = e54;
e47.next = e78;

e78.prev = e47;
e78.next = e85;

e85.prev = e78;
e85.next = e54;
e85.twin = e58;

e54.prev = e85;
e54.next = e47;
e54.twin = e45;
%----------------------------
e89.prev = e58;
e89.next = e96;

e96.prev = e89;
e96.next = e65;

e65.prev = e96;
e65.next = e58;
e65.twin = e56;

e58.prev = e65;
e58.next = e89;
e58.twin = e85;
%Conexión vértices
%----------------------------
v1.edge = e14;
v2.edge = e21;
v3.edge = e32;
v4.edge = e45;
v5.edge = e52;
v6.edge = e63;
v7.edge = e78;
v8.edge = e85;
v9.edge = e96;
%Información faces
%----------------------------
f1.edge = e45;
f2.edge = e56;
f3.edge = e78;
f4.edge = e89;
%----------------------------
D = DCEL();
D.addFace(f1);
D.addFace(f2);
D.addFace(f3);
D.addFace(f4);
%Devolver los vertices
poly = D.returnPoly()
