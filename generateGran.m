function A = generateGran( T, vA, vT, aT, voids)
%Genera una tabla con la distribución de granulometría según los parámetros
%de entrada. T = vector con los tamaños de tamiz, vA = vector con la
%distribución de áreas por tamaño de tamiz, vT = vector con el área nominal
%de cada tamiz, aT = área total de la muestra en las mismas unidades que vT

s = size(T);
A = zeros(s(1,1),4);
A(:,1) = T;
A(:,2) = vA.*(1-voids);
A(:,3) = vT;
A(:,4) =ceil((A(:,2).*aT)./A(:,3));



end

