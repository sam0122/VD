%Devuelve el punto donde la línea definida por los puntos p1 y p2 (vértice
%borde y punto medio de los sitios a ambos lados del borde) corta la caja
%definida por las coordenadas xmin, ymin, xmax, ymax
function int = clipping(xmin, ymin, xmax, ymax, p1, p2)
    int = zeros(1,2);
    %---------------------------------------------------------------
    b = 1;
    t = 1;
    l = 1;
    r = 1;
    xb = lineX(p1(1,1),p1(1,2),p2(1,1),p2(1,2),ymin);
    xt = lineX(p1(1,1),p1(1,2),p2(1,1),p2(1,2),ymax);
    yl = lineY(p1(1,1),p1(1,2),p2(1,1),p2(1,2),xmin);
    yr = lineY(p1(1,1),p1(1,2),p2(1,1),p2(1,2),xmax);
    if xb < xmin || xb > xmax || isnan(xb)
        b = 0;
    end
    if xt < xmin || xt > xmax || isnan(xt)
        t = 0;
    end
    if yl < ymin || yl > ymax || isnan(yl)
        l = 0;
    end
    if yr < ymin || yr > ymax || isnan(yr)
        r = 0;
    end
    %Selección del punto de intersección
    if b == 1 && l == 1
        d1 = distAprox(xb,ymin,p1(1,1),p1(1,2));
        d2 = distAprox(xmin,yl,p1(1,1),p1(1,2));

        if d1 < d2
            int(1,:) = [xb, ymin];
        else
            int(1,:) = [xmin, yl];
        end
    elseif l == 1 && r == 1
        d1 = distAprox(xmax,yr,p1(1,1),p1(1,2));
        d2 = distAprox(xmin,yl,p1(1,1),p1(1,2));

        if d1 < d2
            int(1,:) = [xmax, yr];
        else
            int(1,:) = [xmin, yl];
        end

    elseif l == 1 && t == 1
        d1 = distAprox(xt,ymax,p1(1,1),p1(1,2));
        d2 = distAprox(xmin,yl,p1(1,1),p1(1,2));

        if d1 < d2
            int(1,:) = [xt, ymax];
        else
            int(1,:) = [xmin, yl];
        end

    elseif b == 1 && r == 1
        d1 = distAprox(xmax,yr,p1(1,1),p1(1,2));
        d2 = distAprox(xb,ymin,p1(1,1),p1(1,2));

        if d1 < d2
            int(1,:) = [xmax, yr];
        else
            int(1,:) = [xb, ymin];
        end

    elseif r == 1 && t == 1
        d1 = distAprox(xmax,yr,p1(1,1),p1(1,2));
        d2 = distAprox(xt,ymax,p1(1,1),p1(1,2));

        if d1 < d2
            int(1,:) = [xmax, yr];
        else
            int(1,:) = [xt, ymax];
        end


    elseif b == 1 && t == 1
        d1 = distAprox(xt,ymax,p1(1,1),p1(1,2));
        d2 = distAprox(xb,ymin,p1(1,1),p1(1,2));

        if d1 < d2
            int(1,:) = [xt, ymax];
        else
            int(1,:) = [xb, ymin];
        end


    end


end
