% Revisa si tres puntos son colineales, pi, pj pk son instancias de la
% clase Evento
function col =  collineal(pi, pj, pk)
    tol = 1E-7;
    
    pix = pi.xCoord();
    piy = pi.yCoord();
    pjx = pj.xCoord();
    pjy = pj.yCoord();
    pkx = pk.xCoord();
    pky = pk.yCoord();

    A = (pix*(pjy-pky)+pjx*(pky-piy) + pkx*(piy - pjy))/2;
    if -tol <= A && A <= tol
        col = true;
    else
        col = false;
    end
    
end
