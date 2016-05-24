% Revisa si tres puntos son colineales, pi, pj pk son instancias de la
% clase Nodo
function col =  collineal(pi, pj, pk)
    tol = 1E-7;
    
    pix = pi.site.xCoord;
    piy = pi.site.yCoord;
    pjx = pj.site.xCoord;
    pjy = pj.site.yCoord;
    pkx = pk.site.xCoord;
    pky = pk.site.yCoord;

    A = (pix*(pjy-pky)+pjx*(pky-piy) + pkx*(piy - pjy))/2;
    if -tol <= A && A <= tol
        col = true;
    else
        col = false;
    end
    
end
