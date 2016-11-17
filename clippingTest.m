%Clipping test
n = 20000;
p1 = zeros(n,2);
rng(0.5,'twister');
p1(:,1) = rand(n,1);
p1(:,2) = rand(n,1);
p2 = zeros(n,2);
rng(2,'twister');
p2(:,1) = rand(n,1);
p2(:,2) = rand(n,1);
ymin = 0;% y = 0
xmax = 13;%x = 13
ymax = 9;%y = 9
xmin = 0;%x = 0
int = zeros(n,2);
for i=1:n
    b = 1;
    t = 1;
    l = 1;
    r = 1;
    xb = lineX(p1(i,1),p1(i,2),p2(i,1),p2(i,2),ymin);
    xt = lineX(p1(i,1),p1(i,2),p2(i,1),p2(i,2),ymax);
    yl = lineY(p1(i,1),p1(i,2),p2(i,1),p2(i,2),xmin);
    yr = lineY(p1(i,1),p1(i,2),p2(i,1),p2(i,2),xmax);
    if xb < xmin || xb > xmax
        b = 0;
    end
    if xt < xmin || xt > xmax
        t = 0;
    end
    if yl < ymin || yl > ymax
        l = 0;
    end
    if yr < ymin || yr > ymax
        r = 0;
    end
    %Selección del punto de intersección
    if b == 1 && l == 1
        d1 = distAprox(xb,ymin,p1(i,1),p1(i,2));
        d2 = distAprox(xmin,yl,p1(i,1),p1(i,2));

        if d1 < d2
            int(i,:) = [xb, ymin];
        else
            int(i,:) = [xmin, yl];
        end
    elseif l == 1 && r == 1
        d1 = distAprox(xmax,yr,p1(i,1),p1(i,2));
        d2 = distAprox(xmin,yl,p1(i,1),p1(i,2));

        if d1 < d2
            int(i,:) = [xmax, yr];
        else
            int(i,:) = [xmin, yl];
        end

    elseif l == 1 && t == 1
        d1 = distAprox(xt,ymax,p1(i,1),p1(i,2));
        d2 = distAprox(xmin,yl,p1(i,1),p1(i,2));

        if d1 < d2
            int(i,:) = [xt, ymax];
        else
            int(i,:) = [xmin, yl];
        end

    elseif b == 1 && r == 1
        d1 = distAprox(xmax,yr,p1(i,1),p1(i,2));
        d2 = distAprox(xb,ymin,p1(i,1),p1(i,2));

        if d1 < d2
            int(i,:) = [xmax, yr];
        else
            int(i,:) = [xb, ymin];
        end

    elseif r == 1 && t == 1
        d1 = distAprox(xmax,yr,p1(i,1),p1(i,2));
        d2 = distAprox(xt,ymax,p1(i,1),p1(i,2));

        if d1 < d2
            int(i,:) = [xmax, yr];
        else
            int(i,:) = [xt, ymax];
        end


    elseif b == 1 && t == 1
        d1 = distAprox(xt,ymax,p1(i,1),p1(i,2));
        d2 = distAprox(xb,ymin,p1(i,1),p1(i,2));

        if d1 < d2
            int(i,:) = [xt, ymax];
        else
            int(i,:) = [xb, ymin];
        end


    end
end
    