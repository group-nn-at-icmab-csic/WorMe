function [porta_lect_correct] = app_proc_probar_modifs(app, field_set)

% Botó per a probar la correcta lectura d'un arxiu de modificacións.
% Si aquest arxiu no és obert correctament, es fa patent al respecte.
% Emprat en Import de modificacións.

% INICI FUNCIÓ

try
    % obtneim l'array de la lectura del document de text i el printem
    [array_sortida_modifs, ~] = llegir_text_delimitadors(field_set, ";");
    
    % Operem
    cell_cont = array_sortida_modifs(2:end, 2);
    array_processaments = cell2array_own(cell_cont);

     % Modifiquem la imatge original i la mostrem:
     imatge_original = imread(app.vapp_ruta_img_origin);
     [BW_final, ~] = processament_imatge_llistat(imatge_original, array_processaments);

        porta_lect_correct = true;

% Si dona algún tipus d'error:
catch
    porta_lect_correct = false;

end

% FINAL FUNCIÓ


end