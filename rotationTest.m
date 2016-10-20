%{
A = Node(3);
B = Node(4);
C = Node(5);
D = Node(7);
E = Node(8);
T = AVL();

T.root = B;
B.leftChild = A;
A.parent = B;
B.rightChild = D;
D.parent = B;
D.leftChild = C;
D.rightChild = E;
C.parent = D;
E.parent = D;

B.balanceFactor = -1;
T.rotateLeft(T.root);
%}
A = Node(2);
B = Node(3);
C = Node(5);
D = Node(6);
E = Node(7);
F = Node(8);
T = AVL();
T.put(A);
T.put(B);
T.put(C);
%{
T.root = E;
E.leftChild = C;
E.rightChild = F;
C.parent = E;
F.parent = E;
C.leftChild = B;
C.rightChild = D;
B.parent = C;
D.parent = C;
B.leftChild = A;
A.parent = B;
B.balanceFactor = 1;
C.balanceFactor = 1;
E.balanceFactor = 2;
T.rotateRight(T.root);
%}
