function cd =  rightLine(start,en,point)%start, y end son eventos de sitio, point es el centro del circulo.
    ax1 = (en.xCoord()-start.xCoord())*(point(1,2)-start.yCoord()) - (en.yCoord()- start.yCoord())*(point(1,1)- start.xCoord());
    if ax1 <= 0
        cd = true;
    else
        cd = false;
    end
    
end
