function x = centroCirculo(brkPoint, linePos)
    pix = brkPoint{1,1}(1,1);
    piy = brkPoint{1,1}(1,2);
    pjx = brkPoint{1,2}(1,1);
    pjy = brkPoint{1,2}(1,2);
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
