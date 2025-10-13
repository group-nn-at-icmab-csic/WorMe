function [main_table_actual_last_modif, main_table_actual_last_modiftable, indx_object_operate, no_modified_object_modificada]= appf_interf_table_incorporar_BWskelmorph(app, main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object)

% Obtains and determines morphological properties of skeletonization and
% width of the binary object, and re-describes them in the table table_main.

%
%
% See also
% appf_interf_table_redefinir_BWskelmorph

% START OF THE FUNCTION

              
    % Describe the skeletonization of the objects themselves.
    [BW_object] = create_BW_indx(appf_split_strindex(no_modified_object(1,:).Indx_BW), appf_split_strindex(no_modified_object(1,:).Resolution)');
    
    % Skel
    [BW_ini_regio_cropped, proporcio_img] = cut_BB_BW_image_1(BW_object, 1);
    
    [BW_skel_crop, dades_imatge, ~] = worm_skeletonization(BW_ini_regio_cropped, app.appv_escala_img, true, true);    
    
%     [BW_skel, dades_imatge_row, dades_imatge_manual_corrected] = worm_skeletonization_manual(BW_final, escala_imatge, extendre_skel_opcio, reduce_line, n_pixel_margin);
    
    % Scale the indices
    [indx_BW_skel_scal] = scale_indx(find(BW_skel_crop), size(BW_object), size(BW_ini_regio_cropped), proporcio_img);
    % To string
    BWskel_indx_string = strjoin(string(indx_BW_skel_scal), ";");
    
    % Width values
    [bwdist_elem_order, ~] = width_bwskeldist_values(BW_ini_regio_cropped, BW_skel_crop);
    % To string
    BWwidth_string = strjoin(string(bwdist_elem_order), ";");

    % Morphological parameters
    % See f'create_S_textscan_modifs'
    
    % BoundingBoxes
    BB = regionprops(BW_object, 'BoundingBox', "Circularity", 'MajorAxisLength', 'Area');
    % Elapsed time: 0.00788 seconds ; 50 iterations in 4.3Gb of RAM memory used

    
    % ______MODIFICATION_____ %
    % Incorporate the components of the modified table into the main table
    
    % Pseudocode
    % 1. Modify object (row of the table)
    % 2. Incorporate object into the main table
    % 3. Incorporate table into the main table_main

    % Modify current object:
    no_modified_object_modificada = no_modified_object;
    no_modified_object_modificada.Length = dades_imatge;
    no_modified_object_modificada.Indx_skel = BWskel_indx_string;
    no_modified_object_modificada.WidthValues = BWwidth_string;
    
    % morphological
    no_modified_object_modificada.Bounding = strjoin(string(BB.BoundingBox), ";");
    no_modified_object_modificada.Morph_circularity = BB.Circularity;
    no_modified_object_modificada.Morph_majoraxis = BB.MajorAxisLength;
    no_modified_object_modificada.Morph_area = BB.Area;
    
    
    % Incorporate into the general objects table
    main_table_actual_last_modiftable(indx_object_operate,:) = no_modified_object_modificada;
    

    % Incorporate into table_main
    % Index: app.table_main_sel.Image == main_table_actual_last.Image & app.table_main_sel.nModif == main_table_actual_last.nModif

    main_table_actual_last_modif = main_table_actual_last;
    main_table_actual_last_modif.ModifTable = {main_table_actual_last_modiftable};
    
    app.table_main_sel( app.table_main_sel.Image == main_table_actual_last.Image & app.table_main_sel.nModif == main_table_actual_last.nModif, : ) = main_table_actual_last_modif;
 

    % % Check:
    % [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obtenir_main_table_corresponent(app)

    
    
    % END OF THE FUNCTION

    
end