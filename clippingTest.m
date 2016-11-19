%Clipping test
%{
n = 10;
p1 = zeros(n,2);
rng(0.5,'twister');
p1(:,1) = 13*rand(n,1);
p1(:,2) = 9*rand(n,1);
p2 = zeros(n,2);
rng(2,'twister');
p2(:,1) = 13*rand(n,1);
p2(:,2) = 9*rand(n,1);
%}
p1 = zeros(4,2);
p1(1,:) = [6,1];
p1(2,:) = [2,3];
p1(3,:) = [10,9];
p1(4,:) = [13,4];
p2 = zeros(4,2);
p2(1,:) = [7,2];
p2(2,:) = [1,5];
p2(3,:) = [9,8];
p2(4,:) = [14,4];

ymin = 0;% y = 0
xmax = 15;%x = 13
ymax = 10;%y = 9
xmin = 0;%x = 0
int = zeros(4,2);
for i=1:4
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
    plot(p1(i,1),p1(i,2),'*b');
    hold on
    plot(p2(i,1),p2(i,2),'*r');
    hold on
    plot(int(i,1),int(i,2),'*g');
    hold on
end
    