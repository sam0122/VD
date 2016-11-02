%nodAr = cell(10,1);
%{
nodAr{1,1} = Node(17);
nodAr{2,1} = Node(5);
nodAr{3,1} = Node(25);
nodAr{4,1} = Node(2);
nodAr{5,1} = Node(11);
nodAr{6,1} = Node(9);
nodAr{7,1} = Node(7);
nodAr{8,1} = Node(16);
nodAr{9,1} = Node(35);
nodAr{10,1} = Node(29);
nodAr{11,1} = Node(38);
%}
%{
nodAr = cell(50000,1);
val = 5000*rand(50000,1);
%}
%T = AVL();
%{
%n = size(nodAr);
for i = 1:3
    %nodAr{i,1} = Node(i);
    T.put(Node(i-1));
end
for i = 3:-1:1
    node = T.get(i-1);
    %nodAr{i,1} = Node(i);
    T.delete(node);
end
%}
%{
a = Node(0);
b = Node(1);
c = Node(2);
d = Node(3);
e = Node(4);
f = Node(5);
g = Node(6);
h = Node(7);
i = Node(8);
j = Node(9);

T.put(a);
T.put(b);
T.put(c);
T.put(d);
T.put(e);
T.put(f);
T.put(g);
T.put(h);
T.put(i);
T.put(j);

T.delete(a);
T.put(b);
T.put(c);
T.put(d);
T.put(e);
T.put(f);
T.put(g);
T.put(h);
T.put(i);
T.put(j);
%}
%{
T.delete(T.root);
T.delete(nodAr{10,1});
T.delete(nodAr{1,1});
T.delete(nodAr{3,1});
T.delete(nodAr{11,1});
T.delete(nodAr{2,1});
T.delete(nodAr{4,1});
%}

%Prueba de putBulk
n = 6;
VD = Voronoi(n);
%Sitios
site1 = Evento(0.5, 0.5);
site2 = Evento(1,1);
site3 = Evento(0.5,2);
site4 = Evento(1.5,1.5);
site5 = Evento(1.6,0.2);
site6 = Evento(2, 1.8);
%Añadir sitio a sitio.
nodo1 = Node({site3 0});
VD.avl.put(nodo1);
upperNode = VD.avl.getUpperNode(site6.xCoord, site6.yCoord);
VD.avl.putBulk(site6,upperNode,[],[]);
upperNode = VD.avl.getUpperNode(site4.xCoord, site4.yCoord);
VD.avl.putBulk(site4,upperNode,[],[]);
