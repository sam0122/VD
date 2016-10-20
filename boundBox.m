function as = boundBox(ancho, alto, sitio1, sitio2, v)%Ancho y alto son escalares; sitio1 y sitio2 son variables de tipo Evento; v es una variable de tipo Vertex
    %línea inferior
    y1 = 0; %x variable
    %línea izquierda
    x1 = 0; %y variable

    %línea superior
    y2 = alto; %x variable
    %línea derecha
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
    %Vector soluciones
    r = zeros(1,8);
    %Parámetros de verificación de división por cero
    dn1 = 2*p(1,1) - 2*p(2,1);
    dn2 = 2*p(1,2) - 2*p(2,2);
    
    j = 1;
     if dn1 == 0
        %Se verifica el caso 2 y 4 

        r(j,1) = NaN;
        r(j,2) = NaN;

        r(j,3) = x1;
        r(j,4) = (p(1,1)^2 + p(1,2)^2 - p(2,1)^2- p(2,2)^2 - 2*p(1,1)*x1 + 2*p(2,1)*x1)/dn2; 

        r(j,5) = NaN;
        r(j,6) = NaN;

        r(j,7) = x2;
        r(j,8) = (p(1,1)^2 + p(1,2)^2 - p(2,1)^2- p(2,2)^2 - 2*p(1,1)*x2 + 2*p(2,1)*x2)/dn2; 

    elseif dn2 == 0
        r(j,1) = (p(1,1)^2 + p(1,2)^2 - p(2,1)^2- p(2,2)^2 - 2*p(1,2)*y1 + 2*p(2,2)*y1)/dn1;
        r(j,2) = y1;

        r(j,3) = NaN;
        r(j,4) = NaN; 

        r(j,5) = (p(1,1)^2 + p(1,2)^2 - p(2,1)^2- p(2,2)^2 - 2*p(1,2)*y2 + 2*p(2,2)*y2)/dn1;
        r(j,6) = y2;

        r(j,7) = NaN;
        r(j,8) = NaN;
    else
        r(j,1) = (p(1,1)^2 + p(1,2)^2 - p(2,1)^2- p(2,2)^2 - 2*p(1,2)*y1 + 2*p(2,2)*y1)/dn1;
        r(j,2) = y1;

        r(j,3) = x1;
        r(j,4) = (p(1,1)^2 + p(1,2)^2 - p(2,1)^2- p(2,2)^2 - 2*p(1,1)*x1 + 2*p(2,1)*x1)/dn2; 

        r(j,5) = (p(1,1)^2 + p(1,2)^2 - p(2,1)^2- p(2,2)^2 - 2*p(1,2)*y2 + 2*p(2,2)*y2)/dn1;
        r(j,6) = y2;

        r(j,7) = x2;
        r(j,8) = (p(1,1)^2 + p(1,2)^2 - p(2,1)^2- p(2,2)^2 - 2*p(1,1)*x2 + 2*p(2,1)*x2)/dn2; 
    end

%Rutina que descarta los puntos imposibles
pp = zeros(2,2); %Guarda las coordendas de los puntos posibles
k = 1;
for i = 1:2:8
    if r(j,i) > ancho || r(j,i) < 0
    elseif r(j,i + 1) > alto || r(j,i + 1) < 0
    else
        pp(k,1) = r(j,i);
        pp(k,2) = r(j,i + 1);
        k  = k + 1;
    end
    
end


%Rutina que compara los puntos posibles con el vértice dado y el centro de
%la pareja de sitios
as = zeros(1,2);
%Distancia entre el primer pp y el centro de los sitios
d1 = sqrt((pp(1,1) - cx)^2+(pp(1,2)-cy)^2);
d2 = sqrt((pp(2,1) - cx)^2+(pp(2,2)-cy)^2);
if d1 > d2
    as(1,1) = pp(2,1);
    as(1,2) = pp(2,2);
else
    as(1,1) = pp(1,1);
    as(1,2) = pp(1,2);
end

%{
pos = v.pos;
vx = pos(1,1);
vy = pos(1,2);

if cx > vx
    if cy > vy
        if pp(1,1) > cx && pp(1,2) > cy
            as(1,1) = pp(1,1);
            as(1,2) = pp(1,2);
        else
            as(1,1) = pp(2,1);
            as(1,2) = pp(2,2);
        end
    else
        if pp(1,1) > cx && pp(1,2) < cy
            as(1,1) = pp(1,1);
            as(1,2) = pp(1,2);
        else
            as(1,1) = pp(2,1);
            as(1,2) = pp(2,2);
        end
    end
else
    if cy > vy
        if pp(1,1) < cx && pp(1,2) > cy
            as(1,1) = pp(1,1);
            as(1,2) = pp(1,2);
        else
            as(1,1) = pp(2,1);
            as(1,2) = pp(2,2);
        end
    else
        if pp(1,1) < cx && pp(1,2) < cy
            as(1,1) = pp(1,1);
            as(1,2) = pp(1,2);
        else
            as(1,1) = pp(2,1);
            as(1,2) = pp(2,2);
        end
        
    end
end
%}

   

end
