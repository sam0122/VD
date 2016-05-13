%Función que devuelve las coordenadas de los vértices del rectángulo que
%contiene el diagrama, dados el ancho y el alto.
function cb = boundingBox(a,b)
    cb = zeros (5,2);
    cb(1,1) = 0;
    cb(1,2) = 0;
    
    cb(2,1) = a;
    cb(2,2) = 0;
    
    cb(3,1) = a;
    cb(3,2) = b;
    
    cb(4,1) = 0;
    cb(4,2) = b;
    
    cb(5,1) = 0;
    cb(5,2) = 0;
end
