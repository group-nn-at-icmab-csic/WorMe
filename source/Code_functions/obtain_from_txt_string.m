function [valor_de_fila_out] = obtain_from_txt_string(arxiu_text_det, nom_det_funcio)

% Given a text file, where the name and
% value are described in two columns respectively, the value equivalent to the name of the row
% is returned, or 'false' if it is not there.
%
% This function goes hand in hand with f'write_text_array', since with
% f'write_text_array' the text file is created with the arrays you want.
% It also goes hand in hand with the function f'sum_a_txt_str_value'.
%
% Variables
% nom_det_funcio : name whose value you want to get
% arxiu_text_det : name of the text file to be analyzed.
%
% _Example function_
%
% % Example data
% arxiu_text_det = "asdf.txt";
% 
% dades_write = []
% 
% dades_write = [
%     "P1011624_skel_00001_01"    "610.1569";
%     "P1011629_skel_00003_01"    "261.4721";
%     "P1011630_skel_00004_01"    "319.8656";
%     "P1011655_skel_00005_01"    "208.8975";
%     "P1011655_skel_00005_03"    "205.9703"]
% 
% write_text_array(arxiu_text_det, dades_write, ";")
% 
% nom_det_funcio = "P1011629_skel_00003_01";
%
% % Example function execution
%  arxiu_text_det = "asdf.txt";
% nom_det_funcio = "P1011629_skel_00003_01";
% [valor_de_fila_out] = obtain_from_txt_string(arxiu_text_det, nom_det_funcio)
%
% See also
% read_text_delimiters
% sum_a_txt_str_value

% START FUNCTION

es_present_valor = false;

if isfile(arxiu_text_det)
    llegit_text_cell = read_text_delimiters(arxiu_text_det, ";");
else
    llegit_text_cell = {};
end

% Obtain value
if isempty(llegit_text_cell)
    es_present_valor = false;
else
    % If not empty
    [n_files, ~, ~] = size(llegit_text_cell);
    % Read the data
    for cada_fila = 1:n_files
        nom_de_fila = llegit_text_cell{cada_fila,1};
        valor_de_fila = llegit_text_cell{cada_fila,2};
        if strcmp(nom_de_fila, nom_det_funcio)
            es_present_valor = true;
            valor_de_fila_out = str2double(valor_de_fila);
        end
    end
    
end


if ~es_present_valor
    valor_de_fila_out = false;
end

% END FUNCTION


end