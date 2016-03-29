%Función que revisa si los breakpoints de las tripletas
%consecutivas pleft, pmiddle y pright convergen.
function conv = convergence(pl, pm, pr)
    col =  collineal(pl, pm, pr);
    if col == 1
        conv = false;
    else
        center = centroCirculo3Puntos(pl,pm,pr);
        conv =  rightLine(pl,pm,center)&& rightLine(pm,pr,center);
    end
            
                
end