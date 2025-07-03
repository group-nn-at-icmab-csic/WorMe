function [proc_BW, new_img, num, BW_final_object, BW_final_noproc, imatge_original, isdrawline] = app_interf_select_obj_bin_forward_new(app, number_BW, BW_final_noproc, dir_output, imatge_original)

% Selecciona els objectes binaris de la imatge i els retorna, si n'hi ha, i
% sino retorna la imatge nova processada.
% Funció de la app 'app_selection_pannel'.
%
% Upgrade: Incorporació de draw line taula per a la seva selecció.
%
% Variables
% number_BW : numero d'objectes binaris (de BW objectes no processats 'BW_final_noproc')

% INICI FUNCIÓ

% Si hi ha algún objecte binari
if number_BW > 0

    [BW_final_object, num] = app_interf_take_unique_obj(BW_final_noproc);
    
    % Nota: si no hi ha objecte es veurà com a zeros.

    % Obtenim les taules de draw
    [S_textscan_table_filtred_drawline, taula_dibuix_filted_nonproc] = app_interf_select_drawline(app);
    
    % _Mirem si va avanç un objecte de la taula de draw_
    [BW_final_object, num, isdrawline] = app_interf_determina_BW_obj_draw(taula_dibuix_filted_nonproc, BW_final_object, num);
    % imshow(BW_final_object)

    % Definim si és o no una línia dibuixada:
    

    % Definim contadors precedencia
    proc_BW = true; % Contador que no s'ha arribat al final    
    new_img = false; % Contador imatge nova


    % Cambiem botons botó original:
    app.OriginalButton.Value = false;

% Si ja no hi ha cap objecte binari:
else
    % _Seguim amb la següent imatge_
    [BW_final, BW_final_object, BW_final_noproc, imatge_original, proc_BW, new_img, num] = app_interf_precedencia_img(app, dir_output);
    
    isdrawline = false;


end


% FINAL FUNCIÓ


end