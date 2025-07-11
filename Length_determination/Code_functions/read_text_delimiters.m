function [array_processos, string_total] = read_text_delimiters(arxiu_output, delimitador_text)

% Reads a text file in columns, separated by certain delimiters. A cell of the result is returned.
%
% Note: if the delimiter_text variable is not specified, it is
% determined as ";"
%
% string_total - returns the text string.
%
% Example
%
% Example data
% dades_write = [
%     "imatge"                    "llargada";
%     "P1011624_skel_00001_01"    "610.1569";
%     "P1011629_skel_00003_01"    "261.4721";
%     "P1011630_skel_00004_01"    "319.8656";
%     "P1011655_skel_00005_01"    "208.8975";
%     "P1011655_skel_00005_03"    "205.9703"]
% 
% % Text creation, with f'write_text_array':
% write_text_array("asdf.txt", dades_write, ";")
% 
% % Reading the created text, with the function f'write_text_array'
% [cell_text, string_total] = read_text_delimiters("asdf.txt", ";")
%
%
% Example 2: with read_text_delimiters
% % Create text
% arxiu_text_output = "C:\Users\Josep TOSHIBA\Desktop\Length determination v2_8\Results_out\_Internal_code_files\escale_line.txt";
% escala_write = ["escala", "654.23"];
% write_text_array(arxiu_text_output, escala_write, ";")
% 
% % Read text
% [array_text, string_total] = read_text_delimiters(arxiu_text_output, ";");
%
% See also:
% write_text_array

% START FUNCTION

if ~exist('delimitador_text','var')
    delimitador_text = ";;";
end

% Read the file
fileID = fopen(arxiu_output,'r');
txt = textscan(fileID,'%s','delimiter','\n');
fclose(fileID);

% Obtain the text
text_obrim = char(txt{1,1});
[row_text,~] = size(text_obrim);

% Split the text and save in array

    
% For each line, we separate the contents into a final cell:
array_processos = {};

for cada_row_text = 1:row_text
    text_individ = txt{1}{cada_row_text}; % Each line
    
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



% END FUNCTION

end