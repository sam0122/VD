function x = centroCirculo(brkPoint, linePos)
    
    sitio1 = brkPoint{1,1};%sitio1 y sitio2 son vaiables de tipo Evento
    sitio2 = brkPoint{1,2};
    pix = sitio1.xCoord();
    piy = sitio1.yCoord();
    pjx = sitio2.xCoord();
    pjy = sitio1.yCoord();
    l = linePos;
    
    %syms x
    %prueba = solve((pjx - x)^2 + pjy^2 + (2*linePos - 2*pjy)*((pix-x)^2 + piy^2 - linePos^2)/(2*piy-2*linePos) - linePos^2 == 0,x);
    
    k= (2*l - 2*pjy)/(2*piy - 2*l);
    d = pjy^2 + k*(piy^2 - l^2) - l^2;
    c = pjx^2 + k*pix^2 + d;
    b = -(2*k*pix + 2*pjx);
    a = (k +1);
    x = roots([a b c]);
end
