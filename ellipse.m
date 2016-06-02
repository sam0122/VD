function [x, y] = ellipse( vx, vy , r1, r2 )

t = 0:1:360;
x = vx + r1*cosd(t);
y = vy + r2*sind(t);

end

