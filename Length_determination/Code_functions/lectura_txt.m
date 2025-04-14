function [text_final] = lectura_txt(fullFileName_text)

% Donat un .txt, retorna la lectura d'aquest.

% Llegim l'arxiu
fileID = fopen(fullFileName_text,'r');
txt = textscan(fileID,'%s','delimiter','\n');
fclose(fileID);

% Obtenim el text
text_obrim = char(txt{1,1});
text_final = join(string(text_obrim), newline);

end