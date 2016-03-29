function center = centroCirculo3Puntos(pi, pj, pk)
    pix = pi.xCoord();
    piy = pi.yCoord();
    pjx = pj.xCoord();
    pjy = pj.yCoord();
    pkx = pk.xCoord();
    pky = pk.yCoord();
    center = zeros(1,2);
    
    center(1,1) = (1/2)*(pix^2*pjy-pix^2*pky-pjx^2*piy+pjx^2*pky+pkx^2*piy-pkx^2*pjy+piy^2*pjy-piy^2*pky-piy*pjy^2+piy*pky^2+pjy^2*pky-pjy*pky^2)/(pix*pjy-pix*pky-pjx*piy+pjx*pky+pkx*piy-pkx*pjy);
    center(1,2) = -(1/2)*(pix^2*pjx-pix^2*pkx-pix*pjx^2+pix*pkx^2-pix*pjy^2+pix*pky^2+pjx^2*pkx-pjx*pkx^2+pjx*piy^2-pjx*pky^2-pkx*piy^2+pkx*pjy^2)/(pix*pjy-pix*pky-pjx*piy+pjx*pky+pkx*piy-pkx*pjy);
end
