function cd =  rightLine(start,en,point)%start, y end son nodos externos, point es el centro del circulo.
    ax1 = (en.site.xCoord-start.site.xCoord)*(point(1,2)-start.site.yCoord) - (en.site.yCoord- start.site.yCoord)*(point(1,1)- start.site.xCoord);
    if ax1 <= 0
        cd = true;
    else
        cd = false;
    end
    
end
