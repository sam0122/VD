%ABRIR EL ARCHIVO
file = fopen('BODIES.OUT','r');
%CREAR EL ARCHIVO DE RESULTADOS
fileResults = fopen('Coordenadas.scr', 'w');
%INFORMACIÓN DE ENCABEZADO
textscan(file, '%s %s %s %s %s %s %s %s %s %s',19);
%GUARDA EL SEPARADOR DE POLÍGONOS COMO UN STRING
separator = '$$$$$$';
firstLine = textscan(file, '%s',1);
firstLine = firstLine{1,1};
firstLine = num2str(cell2mat(firstLine));%Convierte la celda en un string
%Var aux
finished = 0;
i = 1;
final = 'END';
%Ciclo para revisar el contenido del primer polígono
while ~finished 
    if isequal(firstLine,separator)
        textscan(file, '%s %s %s %s %s %s %s %s %s %s',5);
        temp = textscan(file, '%*s %*s %*s %f %*s %f %*s %*s',1);
        cx = cell2mat(temp(1,1));
        cy = cell2mat(temp(1,2));
        textscan(file, '%s %s %s %s %s %s %s %s %s %s',1);
        fprintf(fileResults,'\n');
        fprintf(fileResults,'%s','pline ');
        finished2 = 0;
        while ~finished2
            firstLine = textscan(file, '%s %s %s %s %s %s %s %s %s %s',1);
            firstLine = firstLine{1,1};
            firstLine = num2str(cell2mat(firstLine));
            if  isequal(firstLine, final)
                finished = 1;
                return
            elseif isequal(firstLine,separator)
                finished2 = 1;
            else
                
                c1 = textscan(file, '%*s %f %*s %f',1);
                x = cell2mat(c1(1,1))+ cx;
                y = cell2mat(c1(1,2)) + cy;
                r = [x, y];
                fprintf(fileResults,'%2.9f,%2.9f\n',r);
                c2 = textscan(file, '%*s %f %*s %f',1);
                x = cell2mat(c2(1,1)) + cx;
                y = cell2mat(c2(1,2)) + cy;
                r = [x, y];
                fprintf(fileResults,'%2.9f,%2.9f\n',r);
                textscan(file, '%*s  %f %*s %f',1);
            
            end

        end
          
    end
end
%body = textscan(file, '%s %s %s %s %s %s %s %s %s %s',8);
%coord = textscan(file, '%*s  %f %*s %f',1);

