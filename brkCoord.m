function x = brkCoord( pjx,pjy,pix,piy,ly )
%Función que calcula la coordenada del breakpoint entre dos puntos. Puede
%no ser una función óptima.
%
k1 = 2*(pjy - ly);
k2 = 2*(piy - ly);

a = (1/k1 - 1/k2);
b = (2*pix/k2 - 2*pjx/k1);
c = (pjx^2 + pjy^2 - ly^2)/k1 - (pix^2 + piy^2 -ly^2)/k2;
x = (-b + sqrt(b^2 - 4*a*c))/(2*a);
%x2 = (-b - sqrt(b^2 - 4*a*c))/(2*a);
%x = (1/2)*(k1*pix-2*k2*pjx+sqrt(4*k1^2*ly^2-3*k1^2*pix^2-4*k1^2*piy^2-8*k1*k2*ly^2+4*k1*k2*pix^2-4*k1*k2*pix*pjx+4*k1*k2*piy^2+4*k1*k2*pjx^2+4*k1*k2*pjy^2+4*k2^2*ly^2-4*k2^2*pjy^2))/(-k2+k1);

end

