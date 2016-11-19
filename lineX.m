function x = lineX(x1,y1,x2,y2,y)
    if x1 == x2
        x = x1;
    else
    m = (y2-y1)/(x2-x1);
    x = (y - y1 + m*x1)/m;
    end
end
