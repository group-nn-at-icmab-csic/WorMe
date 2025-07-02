function [text_final] = lectura_txt(fullFileName_text)

% Given a .txt, return the reading of it.

% Read the file
fileID = fopen(fullFileName_text,'r');
txt = textscan(fileID,'%s','delimiter','\n');
fclose(fileID);

% Obtain the text text
text_obrim = char(txt{1,1});
text_final = join(string(text_obrim), newline);

end