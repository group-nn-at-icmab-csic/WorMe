function [array_processos, string_total] = llegir_text_delimitadors(arxiu_output, delimitador_text)

% Llegeix un arxiu de text en columnes, separat per uns determinats delimitadors. Es retorna una cell del resultat.
%
% Nota: si no s'especifíca la variable delimitador_text, aquesta es
% determina com ";"
%
% string_total - retorna el string del text.
%
% Exemple
%
% Dades d'exemple
% dades_write = [
%     "imatge"                    "llargada";
%     "P1011624_skel_00001_01"    "610.1569";
%     "P1011629_skel_00003_01"    "261.4721";
%     "P1011630_skel_00004_01"    "319.8656";
%     "P1011655_skel_00005_01"    "208.8975";
%     "P1011655_skel_00005_03"    "205.9703"]
% 
% % Creació text, amb f'write_text_josep': 
% write_text_josep("asdf.txt", dades_write, ";")
% 
% % Lectura del text creat, amb la funció f'write_text_josep'
% [cell_text, string_total] = llegir_text_delimitadors("asdf.txt", ";")
%
%
% Exemple 2: amb llegir_text_delimitadors
% % Crear text
% arxiu_text_output = "C:\Users\Josep TOSHIBA\Desktop\Length determination v2_8\Results_out\_Internal_code_files\escale_line.txt";
% escala_write = ["escala", "654.23"];
% write_text_josep(arxiu_text_output, escala_write, ";")
% 
% % Llegir text
% [array_text, string_total] = llegir_text_delimitadors(arxiu_text_output, ";");
%
% See also:
% write_text_josep

% INICI FUNCIO

if ~exist('delimitador_text','var')
    delimitador_text = ";;";
end

% Llegim l'arxiu
fileID = fopen(arxiu_output,'r');
txt = textscan(fileID,'%s','delimiter','\n');
fclose(fileID);

% Obtenim el text
text_obrim = char(txt{1,1});
[row_text,~] = size(text_obrim);

% Fem split del text i guardem en array

    
% Per a cada linea, separem els continguts en una cell final:
array_processos = {};

for cada_row_text = 1:row_text
    text_individ = txt{1}{cada_row_text}; % Cada linea
    
    splited_text = split(text_individ, [delimitador_text]);
    splited_text = splited_text';
    
    if isempty(array_processos)
        array_processos = {splited_text{1}, splited_text{2}};
    else
        array_processos{end +1, 1} = splited_text{1};
        array_processos{end, 2} = splited_text{2};
    end
    
end

string_total = "";
[nombre_rows, ~] = size(array_processos);
for cada_row = 1:nombre_rows
    string1 = array_processos{cada_row, 1};
    string2 = array_processos{cada_row, 2};
    linia_string = strcat(string1, " ", string2, " \n");
    string_total = strcat(string_total, linia_string);
end



% FINAL FUNCIÓ

end