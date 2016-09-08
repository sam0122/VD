function r = boundBox(ancho, alto, sitio1, sitio2)
    %l�nea inferior
    y1 = 0; %x variable
    %l�nea izquierda
    x1 = 0; %y variable

    %l�nea superior
    y2 = alto; %x variable
    %l�nea derecha
    x2 = ancho; %y variable
    %Coordenadas de los sitios
    p = zeros(2,2);
    p(1,1) = sitio1.xCoord();
    p(1,2) = sitio1.yCoord();
    p(2,1) = sitio2.xCoord();
    p(2,2) = sitio2.yCoord();
    %Coordenadas del punto central
    cx = (p(1,1) + p(2,1))*0.5;
    cy = (p(1,2) + p(2,2))*0.5;


end
