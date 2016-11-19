function y = lineY(x1,y1,x2,y2,x)
    if y1 == y2
        y = y1;
    else
        m = (y2 - y1)/(x2 - x1);    
        y = m*x-m*x1+y1;
    end
end
