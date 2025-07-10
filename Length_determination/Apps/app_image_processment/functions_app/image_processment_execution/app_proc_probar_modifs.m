function [porta_lect_correct] = app_proc_probar_modifs(app, field_set)

% Button to test the correct reading of a modification file.
% If this file is not opened correctly, a warning is issued.
% Used in Import of modifications.

% START FUNCTION
try
    % we obtain the array from reading the text document and print it
    [array_sortida_modifs, ~] = read_text_delimiters(field_set, ";");
    
    % Operate
    cell_cont = array_sortida_modifs(2:end, 2);
    array_processaments = cell2array_own(cell_cont);

     % Modify the original image and we show it:
     imatge_original = imread(app.vapp_ruta_img_origin);
     [BW_final, ~] = processment_img_list(imatge_original, array_processaments);

        porta_lect_correct = true;

% If it gives some kind of error:
catch
    porta_lect_correct = false;

end

% FINAL OF THE FUNCTION


end