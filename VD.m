function VD(n)
    x = gallery('uniformdata',[1 n],0);
    y = gallery('uniformdata',[1 n],1);
voronoi(x,y)