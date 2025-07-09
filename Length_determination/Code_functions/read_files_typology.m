function [array_strings_arxius] = read_files_typology(carpeta_arx, tipologia_arxiu)

% Donada una carpeta i un tipus d'arxiu, retorna en array el nom dels arxius de la tipologia descrita presents en la carpeta.

% START FUNCTION

patro_tipus_image = strcat("*", tipologia_arxiu);
filePattern = fullfile(carpeta_arx, patro_tipus_image); % Change to whatever pattern you need.
theFiles = dir(filePattern);
list_de_files = {theFiles.name};
array_strings_arxius = string(list_de_files);  

% END FUNCTION


end