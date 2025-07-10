function [main_table_actual_last_modif, main_table_actual_last_modiftable, indx_object_operate, no_modified_object_modificada]= appf_interf_table_incorporar_BWskelmorph(app, main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object)

% Obté i determina les propietats morfologiques de esqueletonització i
% ampalda de l'objecte binari, i les re-descriu a la taula table_main.

%
%
% See also
% appf_interf_table_redefinir_BWskelmorph

% INICI FUNCIÓ

              
    % Describim l'esqueletonització dels mateixos.
    [BW_object] = create_BW_indx(appf_split_strindex(no_modified_object(1,:).Indx_BW), appf_split_strindex(no_modified_object(1,:).Resolution)');
    
    % Skel
    [BW_ini_regio_cropped, proporcio_img] = cut_BB_BW_image_1(BW_object, 1);
    
    [BW_skel_crop, dades_imatge, ~] = worm_skeletonization(BW_ini_regio_cropped, app.appv_escala_img, true, true);    
    
%     [BW_skel, dades_imatge_row, dades_imatge_manual_corrected] = worm_skeletonization_manual(BW_final, escala_imatge, extendre_skel_opcio, reduce_line, n_pixel_margin);
    
    % Escalem els index
    [indx_BW_skel_scal] = scale_indx(find(BW_skel_crop), size(BW_object), size(BW_ini_regio_cropped), proporcio_img);
    % En strig
    BWskel_indx_string = strjoin(string(indx_BW_skel_scal), ";");
    
    % Amplada valors
    [bwdist_elem_order, ~] = width_bwskeldist_values(BW_ini_regio_cropped, BW_skel_crop);
    % En strig
    BWwidth_string = strjoin(string(bwdist_elem_order), ";");

    % Paràmetres morfologics
    % Veure f'create_S_textscan_modifs'
    
    % BoundingBoxes
    BB = regionprops(BW_object, 'BoundingBox', "Circularity", 'MajorAxisLength', 'Area');
    % Elapsed time: 0.00788 seconds ; 50 iterations in 4.3Gb of RAM memory used

    
    % ______MODIFICACIÓ_____ %
    % Incorporem els components de la taula modificada a la taula_main
    
    % Pseudocodi
    % 1. Modifiquem objecte (fila de la taula)
    % 2. Incorporem objecte a la taula principal
    % 3. Incorporem taula a la taula_main

    % Modifiquem objecte actual:
    no_modified_object_modificada = no_modified_object;
    no_modified_object_modificada.Length = dades_imatge;
    no_modified_object_modificada.Indx_skel = BWskel_indx_string;
    no_modified_object_modificada.WidthValues = BWwidth_string;
    
    % morfologics
    no_modified_object_modificada.Bounding = strjoin(string(BB.BoundingBox), ";");
    no_modified_object_modificada.Morph_circularity = BB.Circularity;
    no_modified_object_modificada.Morph_majoraxis = BB.MajorAxisLength;
    no_modified_object_modificada.Morph_area = BB.Area;
    
    
    % Incorporem a la taula general d'objectes
    main_table_actual_last_modiftable(indx_object_operate,:) = no_modified_object_modificada;
    

    % Incorporem a la taula_main
    % INdex: app.table_main_sel.Image == main_table_actual_last.Image & app.table_main_sel.nModif == main_table_actual_last.nModif

    main_table_actual_last_modif = main_table_actual_last;
    main_table_actual_last_modif.ModifTable = {main_table_actual_last_modiftable};
    
    app.table_main_sel( app.table_main_sel.Image == main_table_actual_last.Image & app.table_main_sel.nModif == main_table_actual_last.nModif, : ) = main_table_actual_last_modif;
 

    % % Comprovem:
    % [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obtenir_main_table_corresponent(app)

    
    
    % FINAL FUNCIÓ
    
    
end