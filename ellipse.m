function [x, y, t] = ellipse( vx, vy , r1, r2 ,In)

t = 0:1:360;
%x = vx + r1*cosd(t);
%y = vy + r2*sind(t);
x = r1*cosd(t)*cosd(In) - r2*sind(t)*sind(In) + vx;
y = r1*cosd(t)*sind(In) + r2*sind(t)*cosd(In) + vy;

end

