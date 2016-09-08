function C = genMH( np,a,b)
%Parámetro de elongación
E = 0.8;
%Número mínimo de contactos
cMin = 4;
%Número máximo de contactos
cMax = 16;
%Celda que contiene las celdas que conforman los agregados y las celdas que
%conforman los vacíos.
C = cell(np,1);
%Generar arreglo de áreas, ordenadas de mayor a menor.Debe ser función de la granulometría
A = granulomet(np);
%A = sort(A,'descend');
seed = randi([0 10000]);
for j = 1:np
    
    %Semieje mayor
    r1 = sqrt(A(j,1)/(pi()*E));
    %Semieje menor
    r2 = r1 * E;

    %Inclinación de la partícula
    dcP = -37 +(37 + 37)*rand(1);
    
    %Variable que determina si se encontró una elipse dentro de la que se
    %quiere definir
    found = 0;
    count = 0;
    while found == 0 && count < 10000  
        
           %Coordenadas del núcleo
           H = haltonset(2,'Skip',j*1000,'Leap',seed*100);
           H = scramble(H,'RR2');
           vx = a*H(j+count,1);
           vy = b*H(j+count,2);
           %Coordenadas de la elipse del punto generado
           [x,y] = ellipse(vx,vy,r1,r2,dcP);
           %Variable control
           ter = 0;
           for k = 1:(j-1) 
               pt = C{k,1};
               %Revisión de intersecciones entre elipses
               [xa,ya] = ellipse(pt(1,1),pt(1,2),pt(1,3),pt(2,3),pt(3,3));
               Int = InterX([x;y],[xa;ya]);
               %Revisión de distancias entre centros
               d = sqrt((vx - pt(1,1))^2 + (vy - pt(1,2))^2);
               if isempty(Int) == 0
                    ter = 1;
                    break;
               elseif d <=1.1*( r1 + pt(1,3))
                    ter = 1;
                    break;
               end
           end
          
           
           
           if ter == 0
                found = 1;
                 %Vector que contiene los puntos
                p = zeros(cMax + 1,4);
                p(1,1) = vx;
                p(1,2) = vy;
                p(1,4) = 1;
                %Ubicación de la información de la elipse
                p(1,3) = r1;
                p(2,3) = r2;
                p(3,3) = dcP;
                
                %Ubicación de los puntos externos fijos
                for i = 0:cMin-1
                    %xt = vx + r1*cosd(i*90);
                    %yt = vy + r2*sind(i*90);
                    p(i+2,1) =  r1*cosd(i*90)*cosd(dcP) - r2*sind(i*90)*sind(dcP) + vx;
                    p(i+2,2) =  r1*cosd(i*90)*sind(dcP) + r2*sind(i*90)*cosd(dcP) + vy;
                    p(i+2,4) =  1;
                    %p(i+2,1) = vx + r1*cosd(i*90+dcP);
                    %p(i+2,2) = vy + r2*sind(i*90+dcP);
                end
                %Ubicación de los puntos externos móviles
                for i = cMin:cMax
                    H = haltonset(1,'Skip',i*1000,'Leap',j*100);
                    H = scramble(H,'RR2');
                    ang = 360*H(i);
                    %xt = vx + r1*cosd(ang);
                    %yt = vy + r2*sind(ang);
                    p(i+2,1) = r1*cosd(ang)*cosd(dcP) - r2*sind(ang)*sind(dcP) + vx;
                    p(i+2,2) = r1*cosd(ang)*sind(dcP) + r2*sind(ang)*cosd(dcP) + vy;
                    p(i+2,4) = 1;
                end
                C{j,1} = p;
                %{
                H = haltonset(2,'Skip',1e2,'Leap',1e2);
                H = scramble(H,'RR2');
                C = H(1:1:np,:); 
                plot(C(:,1),C(:,2),'*');
                %}



           else

                count = count + 1;
           end

            
    end
    
    
end
%Número de vacíos
nV = round(1.4*np);
%Vector de vacíos
V = cell(nV,1);
%Arreglo de áreas
A2 = 0.0001 +(0.0005 - 0.0001)*rand(nV,1);
A2 = sort(A2,'descend');
E2 = 0.9;
%Número máximo de puntos usados en vacíos
vpMax = 12; 
for j = 1:nV
    %Semieje mayor
    r1 = sqrt(A2(j,1)/(pi()*E2));
    %Semieje menor
    r2 = r1 * E2;

    %Inclinación de la partícula
    dcP = -37 +(37 + 37)*rand(1);
   
   %Variables de control
   found = 0;
   count = 0;
   
   while found == 0 && count < 10000  
        
           %Coordenadas del centro de la elipse
           vx = a*rand(1);
           vy = b*rand(1);
           %Coordenadas de la elipse del punto generado
           %[x,y] = ellipse(vx,vy,r1,r2,dcP);
           %Variable control
           ter = 0;
           %Ciclo que verifica que el centro del vacío esté lo suficientemente lejos
           %de las partículas
           for k = 1:np 
               pt = C{k,1};
               
               %Revisión de intersecciones entre elipses
               %[xa,ya] = ellipse(pt(1,1),pt(1,2),pt(1,3),pt(2,3),pt(3,3));
               %Int = InterX([x;y],[xa;ya]);
               %Revisión de distancias entre centros
               d = sqrt((vx - pt(1,1))^2 + (vy - pt(1,2))^2);
               %if isempty(Int) == 0
               %     ter = 1;
               %     break;
               if d <=( r1 + pt(1,3))
                    ter = 1;
                    break;
               end
           end
            %Ciclo que verifica que el centro del vacío esté lo suficientemente lejos
           %de los vacíos ya ubicados
           for k = 1:(j-1)
               vt = V{k,1};
               %Coordenadas del centro del vacío k
               xV = vt(1,1);
               yV = vt(1,2);
               
               %Revisión de distancias entre centros
               r = vt(1,3);
               d = sqrt((vx - xV)^2 + (vy - yV)^2);
               
               if d <=( r1 + r)
                    ter = 1;
                    break;
               end
           end
          
                      
            if ter == 0
                found = 1;
                 %Vector que contiene los puntos
                p = zeros(vpMax + 1,4);
                p(1,1) = vx;
                p(1,2) = vy;
                p(1,4) = 0;
                %Ubicación de la información de la elipse
                p(1,3) = r1;
                p(2,3) = r2;
                p(3,3) = dcP;
                
                %Ubicación de los puntos externos fijos
                for i = 0:cMin-1
                    %xt = vx + r1*cosd(i*90);
                    %yt = vy + r2*sind(i*90);
                    p(i+2,1) =  r1*cosd(i*90)*cosd(dcP) - r2*sind(i*90)*sind(dcP) + vx;
                    p(i+2,2) =  r1*cosd(i*90)*sind(dcP) + r2*sind(i*90)*cosd(dcP) + vy;
                    p(i+2,4) =  1;
                    %p(i+2,1) = vx + r1*cosd(i*90+dcP);
                    %p(i+2,2) = vy + r2*sind(i*90+dcP);
                end
                %Ubicación de los puntos externos móviles
                for i = cMin:vpMax
                    H = haltonset(1,'Skip',i*1000,'Leap',j*100);
                    H = scramble(H,'RR2');
                    ang = 360*H(i);
                    %xt = vx + r1*cosd(ang);
                    %yt = vy + r2*sind(ang);
                    p(i+2,1) = r1*cosd(ang)*cosd(dcP) - r2*sind(ang)*sind(dcP) + vx;
                    p(i+2,2) = r1*cosd(ang)*sind(dcP) + r2*sind(ang)*cosd(dcP) + vy;
                    p(i+2,4) = 1;
                end
                V{j,1} = p;
           else

                count = count + 1;
           end

            
    end
   
end

P = [];
x = [];
y = [];
r1 = [];
r2 = [];
in = [];

for i = 1:np    
    p = C{i,1};
          
    P = cat(1,P,p);
    x = cat(1,x,p(1,1));
    y = cat(1,y,p(1,2));
    r1 = cat(1,r1,p(1,3));
    r2 = cat(1,r2,p(2,3));
    in = cat(1,in,p(3,3));
end
for i = 1:nV
    v = V{i,1};
    P = cat(1,P,v);
end

%P = cat (1, P, V); 



%plot(P(:,1),P(:,2),'*');
%hold on
voronoi(P(:,1),P(:,2),'k');
hold on
%{
for i=1:np
[ex , ey] = ellipse(x(i,1),y(i,1),r1(i,1),r2(i,1),in(i,1));
plot(ex,ey);
hold on
end
%}
axis equal;

%Parcheo de los agregados
[B,D] = voronoin(P);

for i = 1:length(D)
    if all(D{i}~=1)
        %col = [rand(1) rand(1) rand(1)];
        %if P(i,4) == 1
            patch(B(D{i},1),B(D{i},2), i);
        %else
         %   patch(B(D{i},1),B(D{i},2), 0);
        %end
        
    end
    
end

end


