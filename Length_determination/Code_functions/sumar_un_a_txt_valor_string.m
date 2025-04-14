function sumar_un_a_txt_valor_string(arxiu_text_det, nom_det_funcio)

% Donat un arxiu de text, on hi ha descrit en dos columnes el nom i el
% valor respecteivament, es suma un al valor que equival al nom de la fila
% determinat, o si no hi és es crea.
%
% Aquesta funció va de la mà de f'write_text_josep', donat que amb
% f'write_text_josep'es crea l'arxiu de text amb les arrays que es vulgui.
% També va de la mà de la funció f'obtenir_de_txt_valor_string'.
%
% Variables
% nom_det_funcio : nom el valor del qual es vol suma 1 en un arxiu de text.
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
% write_text_josep(arxiu_text_det, dades_write, ";")
% 
% nom_det_funcio = "P1011629_skel_00003_01";
%
% % Exemple execució funcio
%  arxiu_text_det = "asdf.txt";
% nom_det_funcio = "P1011629_skel_00003_01";
% sumar_un_a_txt_valor_string(arxiu_text_det, nom_det_funcio)
%
% % Exemple execució funció 2
% arxiu_text_det = "asdf2.txt";
% nom_det_funcio = "P1011629_skel_00003_01";
% sumar_un_a_txt_valor_string(arxiu_text_det, nom_det_funcio)

% See also
% write_text_josep, llegir_text_delimitadors, obtenir_de_txt_valor_string

% INICI FUNCIO

if ~isfile(arxiu_text_det)
    llegit_text_cell = {};
else
    llegit_text_cell = llegir_text_delimitadors(arxiu_text_det, ";");
end

es_present_valor = false;



% Si l'arxiu és vuit, es fica amb valor 1 el nom.
if isempty(llegit_text_cell)
    llegit_text_cell = { nom_det_funcio,  '1' };
else
    % Si no és vuida, es suma 1 al valor present.
    
    % Es fa una lectura de les dades.
    [nfiles, ~, ~] = size(llegit_text_cell);
    for cada_fila = 1:nfiles
        nom_de_fila = llegit_text_cell{cada_fila,1};
        valor_de_fila = llegit_text_cell{cada_fila,2};
        if strcmp(nom_de_fila, nom_det_funcio)
            es_present_valor = true;
            valor_de_fila_out = str2double(valor_de_fila) +1;
            llegit_text_cell{cada_fila,2} = string(valor_de_fila_out);
        end
    end
    
end


% Es fa un write altrament

% Guardar l'arxiu output de dades
fid = fopen(arxiu_text_det,'w');
[nfiles, ~, ~] = size(llegit_text_cell);
for var_out_dades = 1:nfiles
    fprintf(fid,'%s \n',strcat(llegit_text_cell{var_out_dades, 1}, ";", llegit_text_cell{var_out_dades, 2}));
end
fclose(fid);

drawnow; % Force display to update immediately.



% FINAL FUNCIO

end