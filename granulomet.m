function A = granulomet( np )
%Genera un arreglo de tamaño np con la granulometría definida dentro de la
%función
%   Definir el rango de tamaños
tm = zeros(5,1);
tm(1,1) = 0.02;
tm(2,1) = 0.01;
tm(3,1)= 0.005;
tm(4,1) = 0.001;
tm(5,1) = 0.0005;

%Definir la proporción de cada tamaño
rg = zeros(5,1);
rg(1,1) = 0.1;
rg(2,1) = 0.25;
rg(3,1) = 0.3;
rg(4,1) = 0.20;
rg(5,1) = 0.15;

npR = zeros(5,1);
for i = 1:5
    npR(i,1) = round(rg(i,1)*np);
end

del = sum(npR) - np;
for i =1:del
    indx = randi([1 5],1);
    npR(indx,1) = npR(indx,1) - 1;
end
A = zeros(np,1);
k = 1;
for i = 1:5
    ite = npR(i,1);
    for j =1:ite
        A(k,1) = tm(i,1);
        k = k + 1;
    end
    

end

end

