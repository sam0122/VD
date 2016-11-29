%ABRIR EL ARCHIVO
fileBodies = fopen('BODIES.OUT','r');
%CREAR EL ARCHIVO DE RESULTADOS
fileResults = fopen('Coordenadas.scr', 'w');
%INFORMACIÓN DE ENCABEZADO
textscan(fileBodies, '%s %s %s %s %s %s %s %s %s %s',19);
%GUARDA EL SEPARADOR DE POLÍGONOS COMO UN STRING
separator = '$$$$$$';
firstLine = textscan(fileBodies, '%s',1);
firstLine = firstLine{1,1};
firstLine = num2str(cell2mat(firstLine));%Convierte la celda en un string
%Var aux
finished = 0;
i = 1;
final = 'END';
%Archivo con la información de translación y rotación de los polígonos
fileDof = fopen('DOF.OUT.10');
%Información de encabezado
textscan(fileDof, '%s %s %s %s', 2);
%Ciclo para revisar el contenido del primer polígono
while ~finished 
    if isequal(firstLine,separator)
        textscan(fileBodies, '%s %s %s %s %s %s %s %s %s %s',5);
        temp = textscan(fileBodies, '%*s %*s %*s %f %*s %f %*s %*s',1);
        textscan(fileDof,'%s %s',4);
        dofTemp = textscan(fileDof, '%*s %*s %*s %f %*s %f %*s %f',1);
        C0x = cell2mat(temp(1,1));%Centro inicial de la partícula
        C0y = cell2mat(temp(1,2));
        Tx = cell2mat(dofTemp(1,1));%Translación del centro y ángulo de rotación de la partícula en radianes
        Ty = cell2mat(dofTemp(1,2));
        Tr = cell2mat(dofTemp(1,3));
        textscan(fileBodies, '%s %s %s %s %s %s %s %s %s %s',1);
        textscan(fileDof, '%s %s %s %s %s %s',1);
        fprintf(fileResults,'\n');
        fprintf(fileResults,'%s','pline ');
        finished2 = 0;
        while ~finished2
            firstLine = textscan(fileBodies, '%s %s %s %s %s %s %s %s %s %s',1);
            firstLine = firstLine{1,1};
            firstLine = num2str(cell2mat(firstLine));
            if  isequal(firstLine, final)
                finished = 1;
                return
            elseif isequal(firstLine,separator)
                finished2 = 1;
            else
                
                vertTemp1 = textscan(fileBodies, '%*s %f %*s %f',1);
                v0x = cell2mat(vertTemp1(1,1));
                v0y = cell2mat(vertTemp1(1,2));
                xF = v0x*cos(Tr) - v0y*sin(Tr) + C0x + Tx;
                yF = v0x*sin(Tr) + v0y*cos(Tr) + C0y + Ty;
                r = [xF, yF];
                fprintf(fileResults,'%2.9f,%2.9f\n',r);
                %Vértice 2----------------------------------------------
                vertTemp2 = textscan(fileBodies, '%*s %f %*s %f',1);
                v0x = cell2mat(vertTemp2(1,1));
                v0y = cell2mat(vertTemp2(1,2));
                xF = v0x*cos(Tr) - v0y*sin(Tr) + C0x + Tx;
                yF = v0x*sin(Tr) + v0y*cos(Tr) + C0y + Ty;
                r = [xF, yF];
                fprintf(fileResults,'%2.9f,%2.9f\n',r);
                textscan(fileBodies, '%*s  %f %*s %f',1);
            
            end

        end
          
    end
end
%body = textscan(file, '%s %s %s %s %s %s %s %s %s %s',8);
%coord = textscan(file, '%*s  %f %*s %f',1);

