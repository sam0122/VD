function val = compareCW(pointA, pointB, center)
    
    if (pointA(1,1) - center(1,1) >= 0 && pointB(1,1) - center(1,1) < 0)
        val = 1;
        return
    end
    if (pointA(1,1) - center(1,1) < 0 && pointB(1,1) - center(1,1) >= 0)
        val = 0;
        return
    end
    if (pointA(1,1) - center(1,1) == 0 && pointB(1,1) - center(1,1) == 0) 
        if (pointA(1,2) - center(1,2) >= 0 || pointB(1,2) - center(1,2) >= 0)
            val =  pointA(1,2) > pointB(1,2);
            return
        end
        val = pointB(1,2) > pointA(1,2);
        return
    end

    det = (pointA(1,1) - center(1,1)) * (pointB(1,2) - center(1,2)) - (pointB(1,1) - center(1,1)) * (pointA(1,2) - center(1,2));
    if (det < 0)
        val = 1;
        return
    
    elseif (det > 0)
        val = 0;
        return
    else
        d1 = (pointA(1,1) - center(1,1)) * (pointA(1,1) - center(1,1)) + (pointA(1,2) - center(1,2)) * (pointA(1,2) - center(1,2));
        d2 = (pointB(1,1) - center(1,1)) * (pointB(1,1) - center(1,1)) + (pointB(1,2) - center(1,2)) * (pointB(1,2) - center(1,2));
        val =  d1 > d2;
    end

    
end