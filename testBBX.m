function b = testBBX()
    a = 5; %ancho
    c = 5; %alto
    %línea inferior
    y1 = 0; %x variable
    %línea izquierda
    x1 = 0; %y variable
    
    %línea superior
    y2 = c; %x variable
    %línea derecha
    x2 = a; %y variable

    %puntos de prueba
    p = zeros (6,2);
    p(1,1) = a*0.1;
    p(1,2)= c*0.1;

    p(2,1)  = a*0.12;
    p(2,2)= c*0.11;

    p(3,1) = a*0.80;
    p(3,2) = c*0.2;

    p(4,1) = a*0.81;
    p(4,2) = c*0.23;

    p(5,1) = a*0.80;
    p(5,2) = c*0.9;

    p(6,1) = a*0.84;
    p(6,2) = c*0.89;

    b = zeros(3,8);
    j = 1;
    plot(p(:,1),p(:,2),'g.');
    hold on
    for i = 1:2:6
        %{
        k= (2*l - 2*pjy)/(2*piy - 2*l);
        d = pjy^2 + k*(piy^2 - l^2) - l^2;
        c = pjx^2 + k*pix^2 + d;
        b = -(2*k*pix + 2*pjx);
        a = (k +1);
        x = roots([a b c]);
        %}
        %{
        Caso 1
        k= (2*y1 - 2*p(i+1,2))/(2*p(i,2) - 2*y1);
        d = p(i+1,2)^2 + k*(p(i,2)^2 - y1^2) - y1^2;
        c = p(i+1,1)^2 + k*p(i,1)^2 + d;
        b2 = -(2*k*p(i,1) + 2*p(i+1,1));
        a = (k + 1);
        x = roots([a b2 c]);
        %}
        %b(j,2) = y1;
        %plot(b(i,1),b(i,2),'g.');
        %Parámetros de verificación de división por cero
        dn1 = 2*p(i,1) - 2*p(i+1,1);
        dn2 = 2*p(i,2) - 2*p(i+1,2);
        if dn1 == 0
            %Se verifica el caso 2 y 4 
            
            b(j,1) = NaN;
            b(j,2) = NaN;
            
            b(j,3) = x1;
            b(j,4) = (p(i,1)^2 + p(i,2)^2 - p(i + 1,1)^2- p(i + 1,2)^2 - 2*p(i,1)*x1 + 2*p(i + 1,1)*x1)/dn2; 
            
            b(j,5) = NaN;
            b(j,6) = NaN;
            
            b(j,7) = x2;
            b(j,8) = (p(i,1)^2 + p(i,2)^2 - p(i + 1,1)^2- p(i + 1,2)^2 - 2*p(i,1)*x2 + 2*p(i + 1,1)*x2)/dn2; 
                        
        elseif dn2 == 0
            b(j,1) = (p(i,1)^2 + p(i,2)^2 - p(i + 1,1)^2- p(i + 1,2)^2 - 2*p(i,2)*y1 + 2*p(i + 1,2)*y1)/dn1;
            b(j,2) = y1;
            
            b(j,3) = NaN;
            b(j,4) = NaN; 
            
            b(j,5) = (p(i,1)^2 + p(i,2)^2 - p(i + 1,1)^2- p(i + 1,2)^2 - 2*p(i,2)*y2 + 2*p(i + 1,2)*y2)/dn1;
            b(j,6) = y2;
            
            b(j,7) = NaN;
            b(j,8) = NaN;
        else
            b(j,1) = (p(i,1)^2 + p(i,2)^2 - p(i + 1,1)^2- p(i + 1,2)^2 - 2*p(i,2)*y1 + 2*p(i + 1,2)*y1)/dn1;
            b(j,2) = y1;
            
            b(j,3) = x1;
            b(j,4) = (p(i,1)^2 + p(i,2)^2 - p(i + 1,1)^2- p(i + 1,2)^2 - 2*p(i,1)*x1 + 2*p(i + 1,1)*x1)/dn2; 
            
            b(j,5) = (p(i,1)^2 + p(i,2)^2 - p(i + 1,1)^2- p(i + 1,2)^2 - 2*p(i,2)*y2 + 2*p(i + 1,2)*y2)/dn1;
            b(j,6) = y2;
            
            b(j,7) = x2;
            b(j,8) = (p(i,1)^2 + p(i,2)^2 - p(i + 1,1)^2- p(i + 1,2)^2 - 2*p(i,1)*x2 + 2*p(i + 1,1)*x2)/dn2; 
        end
        
            
        j = j +1;
    end
plot(b(:,1),b(:,2),'b.');
hold on
plot(b(:,3),b(:,4),'b.');
hold on
plot(b(:,5),b(:,6),'b.');
hold on
plot(b(:,7),b(:,8),'b.');
hold on
end
