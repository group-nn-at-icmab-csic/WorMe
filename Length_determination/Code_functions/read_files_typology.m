function [array_strings_arxius] = read_files_typology(carpeta_arx, tipologia_arxiu)

% Given a folder and a file type, returns in an array the name of the files of the described type present in the folder.

% START FUNCTION

patro_tipus_image = strcat("*", tipologia_arxiu);
filePattern = fullfile(carpeta_arx, patro_tipus_image); % Change to whatever pattern you need.
theFiles = dir(filePattern);
list_de_files = {theFiles.name};
array_strings_arxius = string(list_de_files);  

% END FUNCTION


end