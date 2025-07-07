function [valor_de_fila_out] = obtenir_de_txt_valor_string(arxiu_text_det, nom_det_funcio)

% Donat un arxiu de text, on hi ha descrit en dos columnes el nom i el
% valor respecteivament, es retorna el valor que equival al nom de la fila
% determinat, o bé 'false' si aquest no hi és.
%
% Aquesta funció va de la mà de f'write_text_array', donat que amb
% f'write_text_array'es crea l'arxiu de text amb les arrays que es vulgui.
% També va de la mà de la funció f'sumar_un_a_txt_valor_string'.
%
% Variables
% nom_det_funcio : nom el valor del qual es vol obtenir
% arxiu_text_det : nom del arxiu de text del qual es vol analitzar.
%
% _Exemle funcio_
%
% % Dades exemple
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
% % Exemple execució funcio
%  arxiu_text_det = "asdf.txt";
% nom_det_funcio = "P1011629_skel_00003_01";
% [valor_de_fila_out] = obtenir_de_txt_valor_string(arxiu_text_det, nom_det_funcio)
%
% See also
% write_text_array, llegir_text_delimitadors, sumar_un_a_txt_valor_string

% START FUNCTION

es_present_valor = false;

if isfile(arxiu_text_det)
    llegit_text_cell = llegir_text_delimitadors(arxiu_text_det, ";");
else
    llegit_text_cell = {};
end

% OBtenim valor
if isempty(llegit_text_cell)
    es_present_valor = false;
else
    % Si no és vuida.
    [n_files, ~, ~] = size(llegit_text_cell);
    % Es fa una lectura de les dades.
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