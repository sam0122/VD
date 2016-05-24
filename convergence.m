%Función que revisa si los breakpoints de las tripletas
%consecutivas pleft, pmiddle y pright convergen. Parámetros de entrada son
%nodos.
function [conv, center] = convergence(pl, pm, pr)
    center =  zeros(1,3);
    %col =  collineal(pl, pm, pr);
    %if col == 1
    %    conv = false;
    %else
        %{
        center = centroCirculo3Puntos(pl,pm,pr);
        conv =  rightLine(pl,pm,center)&& rightLine(pm,pr,center);
        %}
        %pl = a
        %pm = b
        %pr = c
  syd = 2*((pl.site.yCoord - pm.site.yCoord)*(pm.site.xCoord - pr.site.xCoord) - (pm.site.yCoord - pr.site.yCoord)*(pl.site.xCoord - pm.site.xCoord));
    if syd > 0 
        
        syn = (pr.site.xCoord^2 + pr.site.yCoord^2 - pm.site.xCoord^2 - pm.site.yCoord^2)*(pl.site.xCoord - pm.site.xCoord) - (pm.site.xCoord^2 + pm.site.yCoord^2 - pl.site.xCoord^2 - pl.site.yCoord^2)*(pm.site.xCoord - pr.site.xCoord); 
        center(1,2) = syn/syd;
        sxn = (pr.site.xCoord^2 + pr.site.yCoord^2 - pm.site.xCoord^2 - pm.site.yCoord^2)*(pl.site.yCoord - pm.site.yCoord) - (pm.site.xCoord^2 + pm.site.yCoord^2 - pl.site.xCoord^2 - pl.site.yCoord^2)*(pm.site.yCoord - pr.site.yCoord); 
        center(1,1) = sxn/(-1*syd);
        center(1,3) = sqrt((center(1,1) - pl.site.xCoord)^2 + (center(1,2) - pl.site.yCoord)^2);
        conv = true;
    else

        conv = false;
    end

            
        
            
                
end