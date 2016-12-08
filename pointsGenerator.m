%rng(0.7, 'twister');
%Rutina para la generación y ubicación de los esqueletos
El = 0.8; %Variable de elongación de las partículas.
%Distribución de puntos y áreas según granulometría
%Vector de diámetros
vD = [19;12.5;9.5;4.75;2.36;1.18;0.6];
vT = vD.^2*pi()*0.25;
vA = [0.047255;0.061587;0.565567;0.280371;0.042375;0.002792;0.000052];
aT = 110*110;
voids = 0.2;
G = generateGran(vD, vA, vT, aT, voids);
%Número de puntos máximo por esqueleto de agregado
nPMx = 21;
%Número de puntos mínimo por esqueleto de agregado
nPMn = 9;
%Número de puntos por esqueleto de vacío
nPV = 5;
%TEST MODIFICACIÓN DEL NÚMERO DE POLÍGONOS DE G
%G(:,4) = [1;1;21;43;26;7;1];
G(:,4) = [1;1;	3; 81;	322;	393; 0];
%G(:,4) = [1;	1;	4;	7;	5;	2;	1];
%G(:,4) = [1;	1;	8;	8;	8;	8;	4];
nAg = sum(G);
nAg = nAg(1,4);
nV = 700; %Número de polígonos que representan vacíos
tamVacios = 0.25; %Tamaño promedio vacíos
%Rutina para la generación inicial de los polígonos centrados en el origen.
%Las 3 últimas columan guardan el tamaño de tamiz y las coordenadas del
%centro
vecAgg = zeros(nAg*2,nPMx + 2);
ciclo1 = size(vD);
ciclo1 = ciclo1(1,1);
%Ciclo externo que revisa el número de rangos de tamaños
accum = 1;%Variable que acumula el número de polígonos procesados
for i = 1:ciclo1
    %Ciclo interno que itera en el número de partículas 
    ciclo2 = G(i,4);
    L1 = G(i,1);
    for j = 1:ciclo2
        if i==1 || i ==2 %MODIFICAR AQUÍ SI SE DESEAN INCLUIR MÁS TAMAÑOS QUE NECESITAN MÁS PUNTOS
        vecAgg(accum,1) = 1;
        vecAgg(accum,2) = L1;
        vecAgg(accum:accum+1,3:nPMx + 2) = createPolygon(L1,El,1,1);
        accum = accum + 2;
        else
        vecAgg(accum,1) = 0;
        vecAgg(accum,2) = L1;
        vecAgg(accum:accum+1,3:nPMn + 2) = createPolygon(L1,El,1,0);
        accum = accum + 2;
        end
            
    end
end
%Ciclo que agrega los polígonos de vacíos
accum = 1;
vecVacios = zeros(nV*2, nPV + 1); 
for i=1:2:nV*2
    vecVacios(accum, 1) = tamVacios;
    vecVacios(accum:accum+1,2:nPV+1) = createPolygon(tamVacios,El,0);
    
   
    accum = accum + 2;
end

%--------------------------------------------------
%Generar y ubicar los polígonos que representan los esqueletos de los
%agregados
%Definición del tamaño de la caja
xmin = 0;
ymin = 0;
xmax = 110;
ymax = 110;
%----------------------------------------------------------------------------------
%Definición de los bordes de los polígonos. Último término es el primero
%repetido--> tener polígono cerrado
cuadranteI = [xmax*0.5 xmax xmax xmax*0.5 xmax*0.5; ymax*0.5 ymax*0.5 ymax ymax ymax*0.5];
cuadranteII = [xmin xmax*0.5 xmax*0.5 xmin xmin; ymax*0.5 ymax*0.5 ymax ymax ymax*0.5];
cuadranteIII = [xmin xmax*0.5 xmax*0.5 xmin xmin; ymin ymin ymax*0.5 ymax*0.5 ymin];
cuadranteIV = [xmax*0.5 xmax xmax xmax*0.5 xmax*0.5; ymin ymin ymax*0.5 ymax*0.5 ymin]; 
%Almacenaje de polígonos por cuadrante
polI = [];
polII = [];
polIII = [];
polIV = [];
I = 1;
II = 1;
III = 1;
IV = 1;
%Máximas iteraciones permitidas antes de abandonar el intento de ubicar un
%polígono
tol = 500;
%Seeding de los puntos
seedSkip = randi(20000,1,1);
h = haltonset(2,'Skip', seedSkip);
h = scramble(h,'RR2');
center = net(h,20000);
%Revisión del cuadrante del polígono
for i = 1:2:(nAg*2)
    found = 0;
    counter = 1;
    while found == 0
        xCen = xmax*center(randi(20000,1,1),1);
        yCen  = ymax*center(randi(20000,1,1),2);
        rot = -45 + 90*rand(1, 1);
        if xCen > xmax*0.5
            if yCen > ymax*0.5
                %Cuadrante I
                %Revisión de cruce con cuadrante I
                extraPoints = vecAgg(i,1);
                if extraPoints
                    nP = nPMx;
                else
                    nP = nPMn;
                end
                vecAgg(i:i+1,3:nP+2) = transfPolygon(vecAgg(i:i+1,3:nP+2),rot, xCen, yCen,1, extraPoints);
                int = polyxpoly(vecAgg(i,3:nP+2), vecAgg(i+1,3:nP+2), cuadranteI(1,:), cuadranteI(2,:));
                if isempty(int)
                    %Buscar intersecciones con los polígonos ya añadidos a la lista
                    %del cuadrante
                    if isempty(polI)
                        polI(I,1) = extraPoints;
                        polI(I,2) = xCen;
                        polI(I+1,2) = yCen;
                        polI(I,3) = vecAgg(i,2);%Dimensiones
                        polI(I:I+1,4:nP+3) = vecAgg(i:i+1,3:nP+2);
                        
                        I = I + 2;
                        plot(vecAgg(i,3:nP+2), vecAgg(i+1,3:nP+2), cuadranteI(1,:), cuadranteI(2,:));
                        hold on
                        found = 1;
                    else
                        fit = 1;
                        for k = 1:2:(I-1)
                            extraAnt = polI(k,1); %Número de puntos del agregado anterior
                            if extraAnt
                                nPAn = nPMx;
                            else
                                nPAn = nPMn;
                            end
                            int =  polyxpoly(vecAgg(i,3:nP+2), vecAgg(i+1,3:nP+2), polI(k,4:nPAn+3), polI(k+1,4:nPAn+3));
                            [in, on] = inpolygon(vecAgg(i,3), vecAgg(i+1,3),polI(k,4:nPAn+3), polI(k+1,4:nPAn+3));
                            if ~isempty(int) || in ~=0 || on ~= 0
                                 fit = 0;
                                counter = counter + 1;
                                if counter >= tol
                                    found  = 1;
                                end
                                vecAgg(i:i+1,3:nP+2) = createPolygon(vecAgg(i,2),El,1,extraPoints);
                                break %CALCULAR UN NUEVO CENTRO
                            end
                        end
                        if fit
                            polI(I,1) = extraPoints;
                            polI(I,2) = xCen;
                            polI(I+1,2) = yCen;
                            polI(I,3) = vecAgg(i,2);%Dimensiones
                            polI(I:I+1,4:nP+3) = vecAgg(i:i+1,3:nP+2);
                            I = I + 2;
                            plot(vecAgg(i,3:nP+2), vecAgg(i+1,3:nP+2));
                            hold on
                            found = 1;
                        end


                    end

                else
                    counter = counter + 1;
                    if counter >= tol
                        found  = 1;
                    end
                   vecAgg(i:i+1,3:nP+2) = createPolygon(vecAgg(i,2),El,1, extraPoints);
                end

            else
                %CuadranteIV
                extraPoints = vecAgg(i,1);
                if extraPoints
                    nP = nPMx;
                else
                    nP = nPMn;
                end
                vecAgg(i:i+1,3:nP+2) = transfPolygon(vecAgg(i:i+1,3:nP+2),rot, xCen, yCen,1, extraPoints);
                int = polyxpoly(vecAgg(i,3:nP+2), vecAgg(i+1,3:nP+2), cuadranteIV(1,:), cuadranteIV(2,:));
                if isempty(int)
                    %Buscar intersecciones con los polígonos ya añadidos a la lista
                    %del cuadrante
                    if isempty(polIV)
                        polIV(IV,1) = extraPoints;
                        polIV(IV,2) = xCen;
                        polIV(IV+1,2) = yCen;
                        polIV(IV,3) = vecAgg(i,2);%Dimensiones
                        polIV(IV:IV+1,4:nP+3) = vecAgg(i:i+1,3:nP+2);
                        IV = IV + 2;
                        plot(vecAgg(i,3:nP+2), vecAgg(i+1,3:nP+2), cuadranteIV(1,:), cuadranteIV(2,:));
                        hold on
                        found = 1;
                    else
                        fit = 1;
                        for k = 1:2:(IV-1)
                            extraAnt = polIV(k,1); %Número de puntos del agregado anterior
                            if extraAnt
                                nPAn = nPMx;
                            else
                                nPAn = nPMn;
                            end
                            int =  polyxpoly(vecAgg(i,3:nP+2), vecAgg(i+1,3:nP+2), polIV(k,4:nPAn+3), polIV(k+1,4:nPAn+3));
                            [in, on] = inpolygon(vecAgg(i,3), vecAgg(i+1,3),polIV(k,4:nPAn+3), polIV(k+1,4:nPAn+3));
                            if ~isempty(int) || in ~=0 || on ~= 0
                                 fit = 0;
                                counter = counter + 1;
                                if counter >= tol
                                    found  = 1;
                                end
                                vecAgg(i:i+1,3:nP+2) = createPolygon(vecAgg(i,2),El,1,extraPoints);
                                break %CALCULAR UN NUEVO CENTRO
                            end
                        end
                        if fit
                            polIV(IV,1) = extraPoints;
                            polIV(IV,2) = xCen;
                            polIV(IV+1,2) = yCen;
                            polIV(IV,3) = vecAgg(i,2);%Dimensiones
                            polIV(IV:IV+1,4:nP+3) = vecAgg(i:i+1,3:nP+2);
                            IV = IV + 2;
                            plot(vecAgg(i,3:nP+2), vecAgg(i+1,3:nP+2));
                            hold on
                            found = 1;
                        end


                    end

                else
                    counter = counter + 1;
                    if counter >= tol
                        found  = 1;
                    end
                   vecAgg(i:i+1,3:nP+2) = createPolygon(vecAgg(i,2),El,1, extraPoints);
                end
            end
        else
            if yCen > ymax*0.5
                %Cuadrante II
                extraPoints = vecAgg(i,1);
                if extraPoints
                    nP = nPMx;
                else
                    nP = nPMn;
                end
                vecAgg(i:i+1,3:nP+2) = transfPolygon(vecAgg(i:i+1,3:nP+2),rot, xCen, yCen,1, extraPoints);
                int = polyxpoly(vecAgg(i,3:nP+2), vecAgg(i+1,3:nP+2), cuadranteII(1,:), cuadranteII(2,:));
                if isempty(int)
                    %Buscar intersecciones con los polígonos ya añadidos a la lista
                    %del cuadrante
                    if isempty(polII)
                        polII(II,1) = extraPoints;
                        polII(II,2) = xCen;
                        polII(II+1,2) = yCen;
                        polII(II,3) = vecAgg(i,2);%Dimensiones
                        polII(II:II+1,4:nP+3) = vecAgg(i:i+1,3:nP+2);
                        
                        II = II + 2;
                        plot(vecAgg(i,3:nP+2), vecAgg(i+1,3:nP+2), cuadranteII(1,:), cuadranteII(2,:));
                        hold on
                        found = 1;
                    else
                        fit = 1;
                        for k = 1:2:(II-1)
                            extraAnt = polII(k,1); %Número de puntos del agregado anterior
                            if extraAnt
                                nPAn = nPMx;
                            else
                                nPAn = nPMn;
                            end
                            int =  polyxpoly(vecAgg(i,3:nP+2), vecAgg(i+1,3:nP+2), polII(k,4:nPAn+3), polII(k+1,4:nPAn+3));
                            [in, on] = inpolygon(vecAgg(i,3), vecAgg(i+1,3),polII(k,4:nPAn+3), polII(k+1,4:nPAn+3));
                            if ~isempty(int) || in ~=0 || on ~= 0
                                 fit = 0;
                                counter = counter + 1;
                                if counter >= tol
                                    found  = 1;
                                end
                                vecAgg(i:i+1,3:nP+2) = createPolygon(vecAgg(i,2),El,1,extraPoints);
                                break %CALCULAR UN NUEVO CENTRO
                            end
                        end
                        if fit
                            polII(II,1) = extraPoints;
                            polII(II,2) = xCen;
                            polII(II+1,2) = yCen;
                            polII(II,3) = vecAgg(i,2);%Dimensiones
                            polII(II:II+1,4:nP+3) = vecAgg(i:i+1,3:nP+2);
                            II = II + 2;
                            plot(vecAgg(i,3:nP+2), vecAgg(i+1,3:nP+2));
                            hold on
                            found = 1;
                        end


                    end

                else
                    counter = counter + 1;
                    if counter >= tol
                        found  = 1;
                    end
                   vecAgg(i:i+1,3:nP+2) = createPolygon(vecAgg(i,2),El,1, extraPoints);
                end
            else
                %CuadranteIII
                extraPoints = vecAgg(i,1);
                if extraPoints
                    nP = nPMx;
                else
                    nP = nPMn;
                end
                vecAgg(i:i+1,3:nP+2) = transfPolygon(vecAgg(i:i+1,3:nP+2),rot, xCen, yCen,1, extraPoints);
                int = polyxpoly(vecAgg(i,3:nP+2), vecAgg(i+1,3:nP+2), cuadranteIII(1,:), cuadranteIII(2,:));
                if isempty(int)
                    %Buscar intersecciones con los polígonos ya añadidos a la lista
                    %del cuadrante
                    if isempty(polIII)
                        polIII(III,1) = extraPoints;
                        polIII(III,2) = xCen;
                        polIII(III+1,2) = yCen;
                        polIII(III,3) = vecAgg(i,2);%Dimensiones
                        polIII(III:III+1,4:nP+3) = vecAgg(i:i+1,3:nP+2);
                        
                        III = III + 2;
                        plot(vecAgg(i,3:nP+2), vecAgg(i+1,3:nP+2), cuadranteIII(1,:), cuadranteIII(2,:));
                        hold on
                        found = 1;
                    else
                        fit = 1;
                        for k = 1:2:(III-1)
                            extraAnt = polIII(k,1); %Número de puntos del agregado anterior
                            if extraAnt
                                nPAn = nPMx;
                            else
                                nPAn = nPMn;
                            end
                            int =  polyxpoly(vecAgg(i,3:nP+2), vecAgg(i+1,3:nP+2), polIII(k,4:nPAn+3), polIII(k+1,4:nPAn+3));
                            [in, on] = inpolygon(vecAgg(i,3), vecAgg(i+1,3),polIII(k,4:nPAn+3), polIII(k+1,4:nPAn+3));
                            if ~isempty(int) || in ~=0 || on ~= 0
                                 fit = 0;
                                counter = counter + 1;
                                if counter >= tol
                                    found  = 1;
                                end
                                vecAgg(i:i+1,3:nP+2) = createPolygon(vecAgg(i,2),El,1,extraPoints);
                                break %CALCULAR UN NUEVO CENTRO
                            end
                        end
                        if fit
                            polIII(III,1) = extraPoints;
                            polIII(III,2) = xCen;
                            polIII(III+1,2) = yCen;
                            polIII(III,3) = vecAgg(i,2);%Dimensiones
                            polIII(III:III+1,4:nP+3) = vecAgg(i:i+1,3:nP+2);
                            III = III + 2;
                            plot(vecAgg(i,3:nP+2), vecAgg(i+1,3:nP+2));
                            hold on
                            found = 1;
                        end


                    end

                else
                    counter = counter + 1;
                    if counter >= tol
                        found  = 1;
                    end
                   vecAgg(i:i+1,3:nP+2) = createPolygon(vecAgg(i,2),El,1, extraPoints);
                end
            end

        end
    end
end
%Almacenaje de polígonos de vacíos por cuadrante
polVaciosI = [];
polVaciosII = [];
polVaciosIII = [];
polVaciosIV = [];
%Variables auxiliares que guardan el tamaño de los vectores de agg
sI = I;
sII = II;
sIII = III;
sIV = IV;
%--------------------------------------------------------------
%Variables auxiliares que guardan el tamaño de los vectores de vacios
I = 1;
II = 1;
III = 1;
IV = 1;
%Seeding
seedSkip = randi(30000,1,1);
h = haltonset(2,'Skip', seedSkip);
h = scramble(h,'RR2');
center = net(h,30000);
%Ciclo para agregar vacíos
%-------------------------------------------------------------------------------------------------------------------
for i=1:2:(nV*2)
    found = 0;
    counter = 1;
    while found == 0
        xCen = xmax*center(randi(30000,1,1),1);
        yCen  = ymax*center(randi(30000,1,1),2);
        rot = -45 + 90*rand(1, 1);
        if xCen > xmax*0.5
            if yCen > ymax*0.5
                %Cuadrante I
                %Revisión de cruce con cuadrante I
                vecVacios(i:i+1,2:nPV+1) = transfPolygon(vecVacios(i:i+1,2:nPV+1),rot, xCen, yCen,0);
                int = polyxpoly(vecVacios(i,2:nPV+1), vecVacios(i+1,2:nPV+1), cuadranteI(1,:), cuadranteI(2,:));
                if isempty(int)
                    %Buscar intersecciones con los agregados ya añadidos a la lista
                    %del cuadrante
                    %if isempty(polVaciosI)
                    %    polVaciosI(I:I+1,:) = vecVacios(i:i+1,1:nPV);
                    %    I = I + 2;
                    %    plot(vecVacios(i,1:nPV), vecVacios(i+1,1:nPV),'r');
                    %    hold on
                    %    found = 1;
                    %else
                        %Revisar intersecciones con los vacíos ya agregados
                        fit = 1;
                        for k = 1:2:(I-1)
                            int =  polyxpoly(vecVacios(i,2:nPV+1), vecVacios(i+1,2:nPV+1), polVaciosI(k,2:nPV+1), polVaciosI(k+1,2:nPV+1));
                           
                            %[in, on] = inpolygon(vecVacios(i,1), vecVacios(i+1,1),polVaciosI(k+1,1:nP), polIVaciosI(k+1,1:nP));
                            if ~isempty(int) %|| in ~=0 || on ~= 0
                                 fit = 0;
                                counter = counter + 1;
                                if counter >= tol
                                    found  = 1;
                                end
                                vecVacios(i:i+1,2:nPV+1) = createPolygon(vecVacios(i,1),El,0);
                                break %CALCULAR UN NUEVO CENTRO
                            end
                           
                        end
                        %Revisar intersecciones con agg ya ubicados
                        if fit
                            for k = 1:2:(sI-1)
                                extraAnt = polI(k,1); %Número de puntos del agregado anterior
                                if extraAnt
                                    nP = nPMx;
                                else
                                    nP = nPMn;
                                end
                                int =  polyxpoly(vecVacios(i,2:nPV+1), vecVacios(i+1,2:nPV+1), polI(k,4:nP+3), polI(k+1,4:nP+3));
                                d1 = vecVacios(i,1); %Guarda las dimensiones del polígono
                                d2 = polI(k,3); %Guarda las dimensiones del polígono%
                                if d1 > d2
                                    [in, on] = inpolygon(polI(k,4), polI(k+1,4),vecVacios(i,2:end), vecVacios(i+1,2:end));
                                else
                                    [in, on] = inpolygon(vecVacios(i,2), vecVacios(i+1,2),polI(k,4:nP+3), polI(k+1,4:nP+3));
                                end
                                
                                if ~isempty(int) || in ~=0 || on ~= 0
                                    fit = 0;
                                    counter = counter + 1;
                                    if counter >= tol
                                        found  = 1;
                                    end
                                    vecVacios(i:i+1,2:nPV+1) = createPolygon(vecVacios(i,1),El,0);
                                    break %CALCULAR UN NUEVO CENTRO
                                end
                           
                            end
                                                       
                        end
                        %Revisa si se cruzó con algún vacío o agregado
                        if fit
                            polVaciosI(I,1) = xCen;
                            polVaciosI(I+1,1) = yCen;
                            polVaciosI(I:I+1,2:nPV+1) = vecVacios(i:i+1,2:nPV+1);
                            I = I + 2;
                            plot(vecVacios(i,2:nPV+1), vecVacios(i+1,2:nPV+1),'r');
                            hold on
                            found = 1;
                        end


                    %end

                else
                    counter = counter + 1;
                    if counter >= tol
                        found  = 1;
                    end
                   vecVacios(i:i+1,2:nPV+1) = createPolygon(vecVacios(i,1),El,0);
                end
            else
            %Cuadrante IV
            %Revisión de cruce con cuadrante IV
                vecVacios(i:i+1,2:nPV+1) = transfPolygon(vecVacios(i:i+1,2:nPV+1),rot, xCen, yCen,0);
                int = polyxpoly(vecVacios(i,2:nPV+1), vecVacios(i+1,2:nPV+1), cuadranteIV(1,:), cuadranteIV(2,:));
                if isempty(int)
                    %Buscar intersecciones con los agregados ya añadidos a la lista
                    %del cuadrante
                    %if isempty(polVaciosI)
                    %    polVaciosI(I:I+1,:) = vecVacios(i:i+1,1:nPV);
                    %    I = I + 2;
                    %    plot(vecVacios(i,1:nPV), vecVacios(i+1,1:nPV),'r');
                    %    hold on
                    %    found = 1;
                    %else
                        %Revisar intersecciones con los vacíos ya agregados
                        fit = 1;
                        for k = 1:2:(IV-1)
                            int =  polyxpoly(vecVacios(i,2:nPV+1), vecVacios(i+1,2:nPV+1), polVaciosIV(k,2:nPV+1), polVaciosIV(k+1,2:nPV+1));
                           
                            %[in, on] = inpolygon(vecVacios(i,1), vecVacios(i+1,1),polVaciosI(k+1,1:nP), polIVaciosI(k+1,1:nP));
                            if ~isempty(int) %|| in ~=0 || on ~= 0
                                 fit = 0;
                                counter = counter + 1;
                                if counter >= tol
                                    found  = 1;
                                end
                                vecVacios(i:i+1,2:nPV+1) = createPolygon(vecVacios(i,1),El,0);
                                break %CALCULAR UN NUEVO CENTRO
                            end
                           
                        end
                        %Revisar intersecciones con agg ya ubicados
                        if fit
                            for k = 1:2:(sIV-1)
                                extraAnt = polIV(k,1); %Número de puntos del agregado anterior
                                if extraAnt
                                    nP = nPMx;
                                else
                                    nP = nPMn;
                                end
                                int =  polyxpoly(vecVacios(i,2:nPV+1), vecVacios(i+1,2:nPV+1), polIV(k,4:nP+3), polIV(k+1,4:nP+3));
                                d1 = vecVacios(i,1); %Guarda las dimensiones del polígono
                                d2 = polIV(k,3); %Guarda las dimensiones del polígono%
                                if d1 > d2
                                    [in, on] = inpolygon(polIV(k,4), polIV(k+1,4),vecVacios(i,2:end), vecVacios(i+1,2:end));
                                else
                                    [in, on] = inpolygon(vecVacios(i,2), vecVacios(i+1,2),polIV(k,4:nP+3), polIV(k+1,4:nP+3));
                                end
                                
                                if ~isempty(int) || in ~=0 || on ~= 0
                                    fit = 0;
                                    counter = counter + 1;
                                    if counter >= tol
                                        found  = 1;
                                    end
                                    vecVacios(i:i+1,2:nPV+1) = createPolygon(vecVacios(i,1),El,0);
                                    break %CALCULAR UN NUEVO CENTRO
                                end
                           
                            end
                                                       
                        end
                        %Revisa si se cruzó con algún vacío o agregado
                        if fit
                            polVaciosIV(IV,1) = xCen;
                            polVaciosIV(IV+1,1) = yCen;
                            polVaciosIV(IV:IV+1,2:nPV+1) = vecVacios(i:i+1,2:nPV+1);
                            IV = IV + 2;
                            plot(vecVacios(i,2:nPV+1), vecVacios(i+1,2:nPV+1),'r');
                            hold on
                            found = 1;
                        end


                    %end

                else
                    counter = counter + 1;
                    if counter >= tol
                        found  = 1;
                    end
                   vecVacios(i:i+1,2:nPV+1) = createPolygon(vecVacios(i,1),El,0);
                end
            end
        else
            if yCen > ymax*0.5
                %Cuadrante II
                %Revisión de cruce con cuadrante II
                vecVacios(i:i+1,2:nPV+1) = transfPolygon(vecVacios(i:i+1,2:nPV+1),rot, xCen, yCen,0);
                int = polyxpoly(vecVacios(i,2:nPV+1), vecVacios(i+1,2:nPV+1), cuadranteII(1,:), cuadranteII(2,:));
                if isempty(int)
                    %Buscar intersecciones con los agregados ya añadidos a la lista
                    %del cuadrante
                    %if isempty(polVaciosI)
                    %    polVaciosI(I:I+1,:) = vecVacios(i:i+1,1:nPV);
                    %    I = I + 2;
                    %    plot(vecVacios(i,1:nPV), vecVacios(i+1,1:nPV),'r');
                    %    hold on
                    %    found = 1;
                    %else
                        %Revisar intersecciones con los vacíos ya agregados
                        fit = 1;
                        for k = 1:2:(II-1)
                            int =  polyxpoly(vecVacios(i,2:nPV+1), vecVacios(i+1,2:nPV+1), polVaciosII(k,2:nPV+1), polVaciosII(k+1,2:nPV+1));
                           
                            %[in, on] = inpolygon(vecVacios(i,1), vecVacios(i+1,1),polVaciosI(k+1,1:nP), polIVaciosI(k+1,1:nP));
                            if ~isempty(int) %|| in ~=0 || on ~= 0
                                 fit = 0;
                                counter = counter + 1;
                                if counter >= tol
                                    found  = 1;
                                end
                                vecVacios(i:i+1,2:nPV+1) = createPolygon(vecVacios(i,1),El,0);
                                break %CALCULAR UN NUEVO CENTRO
                            end
                           
                        end
                        %Revisar intersecciones con agg ya ubicados
                        if fit
                            for k = 1:2:(sII-1)
                                extraAnt = polII(k,1); %Número de puntos del agregado anterior
                                if extraAnt
                                    nP = nPMx;
                                else
                                    nP = nPMn;
                                end
                                int =  polyxpoly(vecVacios(i,2:nPV+1), vecVacios(i+1,2:nPV+1), polII(k,4:nP+3), polII(k+1,4:nP+3));
                                d1 = vecVacios(i,1); %Guarda las dimensiones del polígono
                                d2 = polII(k,3); %Guarda las dimensiones del polígono%
                                if d1 > d2
                                    [in, on] = inpolygon(polII(k,4), polII(k+1,4),vecVacios(i,2:end), vecVacios(i+1,2:end));
                                else
                                    [in, on] = inpolygon(vecVacios(i,2), vecVacios(i+1,2),polII(k,4:nP+3), polII(k+1,4:nP+3));
                                end
                                
                                if ~isempty(int) || in ~=0 || on ~= 0
                                    fit = 0;
                                    counter = counter + 1;
                                    if counter >= tol
                                        found  = 1;
                                    end
                                    vecVacios(i:i+1,2:nPV+1) = createPolygon(vecVacios(i,1),El,0);
                                    break %CALCULAR UN NUEVO CENTRO
                                end
                           
                            end
                                                       
                        end
                        %Revisa si se cruzó con algún vacío o agregado
                        if fit
                            polVaciosII(II,1) = xCen;
                            polVaciosII(II+1,1) = yCen;
                            polVaciosII(II:II+1,2:nPV+1) = vecVacios(i:i+1,2:nPV+1);
                            II = II + 2;
                            plot(vecVacios(i,2:nPV+1), vecVacios(i+1,2:nPV+1),'r');
                            hold on
                            found = 1;
                        end


                    %end

                else
                    counter = counter + 1;
                    if counter >= tol
                        found  = 1;
                    end
                   vecVacios(i:i+1,2:nPV+1) = createPolygon(vecVacios(i,1),El,0);
                end
                
            else
                %Cuadrante III
                %Revisión de cruce con cuadrante III
                vecVacios(i:i+1,2:nPV+1) = transfPolygon(vecVacios(i:i+1,2:nPV+1),rot, xCen, yCen,0);
                int = polyxpoly(vecVacios(i,2:nPV+1), vecVacios(i+1,2:nPV+1), cuadranteIII(1,:), cuadranteIII(2,:));
                if isempty(int)
                    %Buscar intersecciones con los agregados ya añadidos a la lista
                    %del cuadrante
                    %if isempty(polVaciosI)
                    %    polVaciosI(I:I+1,:) = vecVacios(i:i+1,1:nPV);
                    %    I = I + 2;
                    %    plot(vecVacios(i,1:nPV), vecVacios(i+1,1:nPV),'r');
                    %    hold on
                    %    found = 1;
                    %else
                        %Revisar intersecciones con los vacíos ya agregados
                        fit = 1;
                        for k = 1:2:(III-1)
                            int =  polyxpoly(vecVacios(i,2:nPV+1), vecVacios(i+1,2:nPV+1), polVaciosIII(k,2:nPV+1), polVaciosIII(k+1,2:nPV+1));
                           
                            %[in, on] = inpolygon(vecVacios(i,1), vecVacios(i+1,1),polVaciosI(k+1,1:nP), polIVaciosI(k+1,1:nP));
                            if ~isempty(int) %|| in ~=0 || on ~= 0
                                 fit = 0;
                                counter = counter + 1;
                                if counter >= tol
                                    found  = 1;
                                end
                                vecVacios(i:i+1,2:nPV+1) = createPolygon(vecVacios(i,1),El,0);
                                break %CALCULAR UN NUEVO CENTRO
                            end
                           
                        end
                        %Revisar intersecciones con agg ya ubicados
                        if fit
                            for k = 1:2:(sIII-1)
                                extraAnt = polIII(k,1); %Número de puntos del agregado anterior
                                if extraAnt
                                    nP = nPMx;
                                else
                                    nP = nPMn;
                                end
                                int =  polyxpoly(vecVacios(i,2:nPV+1), vecVacios(i+1,2:nPV+1), polIII(k,4:nP+3), polIII(k+1,4:nP+3));
                                d1 = vecVacios(i,1); %Guarda las dimensiones del polígono
                                d2 = polIII(k,3); %Guarda las dimensiones del polígono%
                                if d1 > d2
                                    [in, on] = inpolygon(polIII(k,4), polIII(k+1,4),vecVacios(i,2:end), vecVacios(i+1,2:end));
                                else
                                    [in, on] = inpolygon(vecVacios(i,2), vecVacios(i+1,2),polIII(k,4:nP+3), polIII(k+1,4:nP+3));
                                end
                                
                                if ~isempty(int) || in ~=0 || on ~= 0
                                    fit = 0;
                                    counter = counter + 1;
                                    if counter >= tol
                                        found  = 1;
                                    end
                                    vecVacios(i:i+1,2:nPV+1) = createPolygon(vecVacios(i,1),El,0);
                                    break %CALCULAR UN NUEVO CENTRO
                                end
                           
                            end
                                                       
                        end
                        %Revisa si se cruzó con algún vacío o agregado
                        if fit
                            polVaciosIII(III,1) = xCen;
                            polVaciosIII(III+1,1) = yCen;
                            polVaciosIII(III:III+1,2:nPV+1) = vecVacios(i:i+1,2:nPV+1);
                            III = III + 2;
                            plot(vecVacios(i,2:nPV+1), vecVacios(i+1,2:nPV+1),'r');
                            hold on
                            found = 1;
                        end


                    %end

                else
                    counter = counter + 1;
                    if counter >= tol
                        found  = 1;
                    end
                   vecVacios(i:i+1,2:nPV+1) = createPolygon(vecVacios(i,1),El,0);
                end
            end
        end
   end   
end
%Archivos de salida
%Datos de agregados
agg = fopen('Agregados.txt','w');
%MODIFICAR SI SE CAMBIA EL NUMERO MÁXIMO DE PUNTOS
format = '%10.6f %10.6f %10.6f %10.6f %10.6f %10.6f %10.6f %10.6f %10.6f %10.6f %10.6f %10.6f %10.6f %10.6f %10.6f %10.6f %10.6f %10.6f %10.6f %10.6f %10.6f %10.6f %10.6f %10.6f \n';
dimTotal = sI + sII + sIII + sIV - 4;
pol = zeros(dimTotal, nPMx + 3); 
col = size(polI);
col = col(1,2);
pol(1:sI-1,1:col) = polI;
col = size(polII);
col = col(1,2);
pol(sI:(sI+sII-2),1:col) = polII;
col = size(polIII);
col = col(1,2);
pol(sI+sII-1:sI+sII+sIII-3,1:col) = polIII;
col = size(polIV);
col = col(1,2);
pol(sI+sII+sIII-2:sI+sII+sIII+sIV-4,1:col) = polIV;
pol = pol';
fprintf(agg, format,pol); 
voids = fopen('Vacíos.txt','w');
format = '%10.6f %10.6f %10.6f %10.6f %10.6f %10.6f \n';
polVacios = [polVaciosI;polVaciosII;polVaciosIII;polVaciosIV];
polVacios = polVacios';
fprintf(voids, format,polVacios); 



