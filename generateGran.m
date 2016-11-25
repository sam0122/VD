function A = generateGran( T, vA, vT, aT, voids)
%Genera una tabla con la distribuci�n de granulometr�a seg�n los par�metros
%de entrada. T = vector con los tama�os de tamiz, vA = vector con la
%distribuci�n de �reas por tama�o de tamiz, vT = vector con el �rea nominal
%de cada tamiz, aT = �rea total de la muestra en las mismas unidades que vT

s = size(T);
A = zeros(s(1,1),4);
A(:,1) = T;
A(:,2) = vA.*(1-voids);
A(:,3) = vT;
A(:,4) =ceil((A(:,2).*aT)./A(:,3));



end

