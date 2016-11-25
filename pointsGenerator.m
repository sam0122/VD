rng(0.5, 'twister');
%Rutina para la generaci�n y ubicaci�n de los esqueletos
El = 0.8; %Variable de elongaci�n de las part�culas.
%Distribuci�n de puntos y �reas seg�n granulometr�a
%Vector de di�metros
vD = [12.5;9.5;4.75;2.36;1.18;0.6;0.3];
vT = vD.^2*pi()*0.25;
vA = [0.047255;0.061587;0.565567;0.280371;0.042375;0.002792;0.000052];
aT = 110*110;
voids = 0.2;
G = generateGran(vD, vA, vT, aT, voids);
%N�mero de puntos por esqueleto de agregado
nP = 9;
%TEST MODIFICACI�N DEL N�MERO DE POL�GONOS DE G
%G(:,4) = [1;1;21;43;26;7;1];
G(:,4) = [2;	5;	169;	340;	206;	53;	4];
%G(:,4) = [1;	1;	4;	7;	5;	2;	1];
nAg = sum(G);
nAg = nAg(1,4);
%Rutina para la generaci�n inicial de los pol�gonos centrados en el origen.
%Las 3 �ltimas columan guardan el tama�o de tamiz y las coordenadas del
%centro
vecAgg = zeros(nAg*2,nP+3);
ciclo1 = size(vD);
ciclo1 = ciclo1(1,1);
%Ciclo externo que revisa el n�mero de rangos de tama�os
accum = 1;%Variable que acumula el n�mero de pol�gonos procesados
for i = 1:ciclo1
    %Ciclo interno que itera en el n�mero de part�culas 
    ciclo2 = G(i,4);
    L1 = G(i,1);
    for j = 1:ciclo2
        vecAgg(accum:accum+1,1:nP) = createPolygon(L1,El);
        vecAgg(accum,nP + 1) = L1;
        accum = accum + 2;
    end
end
    
%--------------------------------------------------
%Generar y ubicar los pol�gonos que representan los esqueletos de los
%agregados
%Definici�n del tama�o de la caja
xmin = 0;
ymin = 0;
xmax = 110;
ymax = 110;
%----------------------------------------------------------------------------------
%Definici�n de los bordes de los pol�gonos. �ltimo t�rmino es el primero
%repetido--> tener pol�gono cerrado
cuadranteI = [xmax*0.5 xmax xmax xmax*0.5 xmax*0.5; ymax*0.5 ymax*0.5 ymax ymax ymax*0.5];
cuadranteII = [xmin xmax*0.5 xmax*0.5 xmin xmin; ymax*0.5 ymax*0.5 ymax ymax ymax*0.5];
cuadranteIII = [xmin xmax*0.5 xmax*0.5 xmin xmin; ymin ymin ymax*0.5 ymax*0.5 ymin];
cuadranteIV = [xmax*0.5 xmax xmax xmax*0.5 xmax*0.5; ymin ymin ymax*0.5 ymax*0.5 ymin]; 
%Almacenaje de pol�gonos por cuadrante
polI = [];
polII = [];
polIII = [];
polIV = [];
I = 1;
II = 1;
III = 1;
IV = 1;
%M�ximas iteraciones permitidas antes de abandonar el intento de ubicar un
%pol�gono
tol = 500;
%Revisi�n del cuadrante del pol�gono
for i = 1:2:(nAg*2)
    found = 0;
    counter = 1;
    while found == 0
        xCen = xmax*rand(1,1);
        yCen  = ymax*rand(1,1);
        rot = randi([-45 45], 1, 1);
        if xCen > xmax*0.5
            if yCen > ymax*0.5
                %Cuadrante I
                %Revisi�n de cruce con cuadrante I
                vecAgg(i:i+1,1:nP) = transfPolygon(vecAgg(i:i+1,1:nP),rot, xCen, yCen);
                int = polyxpoly(vecAgg(i,1:nP), vecAgg(i+1,1:nP), cuadranteI(1,:), cuadranteI(2,:));
                if isempty(int)
                    %Buscar intersecciones con los pol�gonos ya a�adidos a la lista
                    %del cuadrante
                    if isempty(polI)
                        polI(I:I+1,:) = vecAgg(i:i+1,1:nP);
                        I = I + 2;
                        plot(vecAgg(i,1:nP), vecAgg(i+1,1:nP), cuadranteI(1,:), cuadranteI(2,:));
                        hold on
                        found = 1;
                    else
                        fit = 1;
                        for k = 1:2:(I-1)
                            int =  polyxpoly(vecAgg(i,1:nP), vecAgg(i+1,1:nP), polI(k,:), polI(k+1,:));
                            [in, on] = inpolygon(vecAgg(i,1), vecAgg(i+1,1),polI(k,:), polI(k+1,:));
                            if ~isempty(int) || in ~=0 || on ~= 0
                                 fit = 0;
                                counter = counter + 1;
                                if counter >= tol
                                    found  = 1;
                                end
                                vecAgg(i:i+1,1:nP) = createPolygon(vecAgg(i,nP+1),El);
                                break %CALCULAR UN NUEVO CENTRO
                            end
                        end
                        if fit
                            polI(I:I+1,:) = vecAgg(i:i+1,1:nP);
                            I = I + 2;
                            plot(vecAgg(i,1:nP), vecAgg(i+1,1:nP), cuadranteI(1,:), cuadranteI(2,:));
                            hold on
                            found = 1;
                        end


                    end

                else
                    counter = counter + 1;
                    if counter >= tol
                        found  = 1;
                    end
                   vecAgg(i:i+1,1:nP) = createPolygon(vecAgg(i,nP+1),El);
                end

            else
                %CuadranteIV
                vecAgg(i:i+1,1:nP) = transfPolygon(vecAgg(i:i+1,1:nP),rot, xCen, yCen);
                int = polyxpoly(vecAgg(i,1:nP), vecAgg(i+1,1:nP), cuadranteIV(1,:), cuadranteIV(2,:));
                if isempty(int)
                    %Buscar intersecciones con los pol�gonos ya a�adidos a la lista
                    %del cuadrante
                    if isempty(polIV)
                        polIV(IV:IV+1,:) = vecAgg(i:i+1,1:nP);
                        IV = IV + 2;
                        plot(vecAgg(i,1:nP), vecAgg(i+1,1:nP), cuadranteIV(1,:), cuadranteIV(2,:));
                        hold on
                        found = 1;
                    else
                        fit = 1;
                        for k = 1:2:(IV-1)
                            int =  polyxpoly(vecAgg(i,1:nP), vecAgg(i+1,1:nP), polIV(k,:), polIV(k+1,:));
                            [in, on] = inpolygon(vecAgg(i,1), vecAgg(i+1,1),polIV(k,:), polIV(k+1,:));
                            if ~isempty(int) || in ~= 0 || on ~= 0
                                fit = 0;
                                counter = counter + 1;
                                if counter >= tol
                                    found  = 1;
                                end
                                vecAgg(i:i+1,1:nP) = createPolygon(vecAgg(i,nP+1),El);
                                break %CALCULAR UN NUEVO CENTRO
                            end
                        end
                        if fit
                            polIV(IV:IV+1,:) = vecAgg(i:i+1,1:nP);
                            IV = IV + 2;
                            plot(vecAgg(i,1:nP), vecAgg(i+1,1:nP), cuadranteIV(1,:), cuadranteIV(2,:));
                            hold on
                            found = 1;
                        end


                    end
                else

                    counter = counter + 1;
                    if counter >= tol
                        found  = 1;
                    end
                    vecAgg(i:i+1,1:nP) = createPolygon(vecAgg(i,nP+1),El);
                end
            end
        else
            if yCen > ymax*0.5
                %Cuadrante II
                vecAgg(i:i+1,1:nP) = transfPolygon(vecAgg(i:i+1,1:nP),rot, xCen, yCen);
                int = polyxpoly(vecAgg(i,1:nP), vecAgg(i+1,1:nP), cuadranteII(1,:), cuadranteII(2,:));
                if isempty(int)
                   %Buscar intersecciones con los pol�gonos ya a�adidos a la lista
                    %del cuadrante
                    if isempty(polII)
                        polII(II:II+1,:) = vecAgg(i:i+1,1:nP);
                        II = II + 2;
                        plot(vecAgg(i,1:nP), vecAgg(i+1,1:nP), cuadranteII(1,:), cuadranteII(2,:));
                        hold on
                        found = 1;
                    else
                        fit = 1;
                        for k = 1:2:(II-1)
                            int =  polyxpoly(vecAgg(i,1:nP), vecAgg(i+1,1:nP), polII(k,:), polII(k+1,:));
                            [in, on] = inpolygon(vecAgg(i,1), vecAgg(i+1,1),polII(k,:), polII(k+1,:));
                            if ~isempty(int) || in ~= 0 || on ~= 0
                                fit = 0;
                                counter = counter + 1;
                                if counter >= tol
                                    found  = 1;
                                end
                               vecAgg(i:i+1,1:nP) = createPolygon(vecAgg(i,nP+1),El);
                                break %CALCULAR UN NUEVO CENTRO
                            end
                        end
                        if fit
                            polII(II:II+1,:) = vecAgg(i:i+1,1:nP);
                            II = II + 2;
                            plot(vecAgg(i,1:nP), vecAgg(i+1,1:nP), cuadranteII(1,:), cuadranteII(2,:));
                            hold on
                            found = 1;
                        end


                    end      
                else

                    counter = counter + 1;
                    if counter >= tol
                        found  = 1;
                    end
                    vecAgg(i:i+1,1:nP) = createPolygon(vecAgg(i,nP+1),El);
                end
            else
                %CuadranteIII
                vecAgg(i:i+1,1:nP) = transfPolygon(vecAgg(i:i+1,1:nP),rot, xCen, yCen);
                int = polyxpoly(vecAgg(i,1:nP), vecAgg(i+1,1:nP), cuadranteIII(1,:), cuadranteIII(2,:));
                if isempty(int)
                    %Buscar intersecciones con los pol�gonos ya a�adidos a la lista
                    %del cuadrante
                    if isempty(polIII)
                        polIII(III:III+1,:) = vecAgg(i:i+1,1:nP);
                        III = III + 2;
                        plot(vecAgg(i,1:nP), vecAgg(i+1,1:nP), cuadranteIII(1,:), cuadranteIII(2,:));
                        hold on
                        found = 1;
                    else
                        fit = 1;
                        for k = 1:2:(III-1)
                            int =  polyxpoly(vecAgg(i,1:nP), vecAgg(i+1,1:nP), polIII(k,:),polIII(k+1,:));
                            [in, on] = inpolygon(vecAgg(i,1), vecAgg(i+1,1),polIII(k,:), polIII(k+1,:));
                            if ~isempty(int) || in ~= 0 || on ~= 0
                                fit = 0;
                                counter = counter + 1;
                                if counter >= tol
                                    found  = 1;
                                end
                                vecAgg(i:i+1,1:nP) = createPolygon(vecAgg(i,nP+1),El);
                                break %CALCULAR UN NUEVO CENTRO
                            end
                        end
                        if fit
                            polIII(III:III+1,:) = vecAgg(i:i+1,1:nP);
                            III = III + 2;
                            plot(vecAgg(i,1:nP), vecAgg(i+1,1:nP), cuadranteIII(1,:), cuadranteIII(2,:));
                            hold on
                            found = 1;
                        end


                    end
                else

                    counter = counter + 1;
                    if counter >= tol
                        found  = 1;
                    end
                    vecAgg(i:i+1,1:nP) = createPolygon(vecAgg(i,nP+1),El);
                end
            end

        end
    end
end








