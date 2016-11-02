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
  syd = 2*((pl.sites{1,1}.yCoord - pm.sites{1,1}.yCoord)*(pm.sites{1,1}.xCoord - pr.sites{1,1}.xCoord) - (pm.sites{1,1}.yCoord - pr.sites{1,1}.yCoord)*(pl.sites{1,1}.xCoord - pm.sites{1,1}.xCoord));
    if syd > 0 
        
        syn = (pr.sites{1,1}.xCoord^2 + pr.sites{1,1}.yCoord^2 - pm.sites{1,1}.xCoord^2 - pm.sites{1,1}.yCoord^2)*(pl.sites{1,1}.xCoord - pm.sites{1,1}.xCoord) - (pm.sites{1,1}.xCoord^2 + pm.sites{1,1}.yCoord^2 - pl.sites{1,1}.xCoord^2 - pl.sites{1,1}.yCoord^2)*(pm.sites{1,1}.xCoord - pr.sites{1,1}.xCoord); 
        center(1,2) = syn/syd;
        sxn = (pr.sites{1,1}.xCoord^2 + pr.sites{1,1}.yCoord^2 - pm.sites{1,1}.xCoord^2 - pm.sites{1,1}.yCoord^2)*(pl.sites{1,1}.yCoord - pm.sites{1,1}.yCoord) - (pm.sites{1,1}.xCoord^2 + pm.sites{1,1}.yCoord^2 - pl.sites{1,1}.xCoord^2 - pl.sites{1,1}.yCoord^2)*(pm.sites{1,1}.yCoord - pr.sites{1,1}.yCoord); 
        center(1,1) = sxn/(-1*syd);
        center(1,3) = sqrt((center(1,1) - pl.sites{1,1}.xCoord)^2 + (center(1,2) - pl.sites{1,1}.yCoord)^2);
        conv = true;
    else

        conv = false;
    end

            
        
            
                
end