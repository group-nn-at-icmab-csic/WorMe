function [main_table_actual_last_modif, main_table_actual_last_modiftable, indx_object_operate, no_modified_object_modificada]= appf_interf_table_redefinir_BWskelmorph(app, main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object)

% Like appf_interf_table_incorporar_BWskelmorph, but the object that is
% defined is not re-integrated into the table_main
% (app.table_main_sel), but the tables are simply re-defined.
%
% Obtains and determines the morphological properties of skeletonization and
% width of the binary object, and re-describes them in the table table_main.

% FUNCTION START


    % We describe the skeletonization of the same.
    [BW_object] = create_BW_indx(appf_split_strindex(no_modified_object(1,:).Indx_BW), appf_split_strindex(no_modified_object(1,:).Resolution)');
    
    % Skel
    [BW_ini_regio_cropped, proporcio_img] = cut_BB_BW_image_1(BW_object, 1);
    [BW_skel_crop, dades_imatge, ~] = worm_skeletonization(BW_ini_regio_cropped, app.appv_escala_img, true, true);    

    % We scale the indexes
    [indx_BW_skel_scal] = scale_indx(find(BW_skel_crop), size(BW_object), size(BW_ini_regio_cropped), proporcio_img);
    % As string
    BWskel_indx_string = strjoin(string(indx_BW_skel_scal), ";");
    
    % Width values
    [bwdist_elem_order, ~] = width_bwskeldist_values(BW_ini_regio_cropped, BW_skel_crop);
    % As string
    BWwidth_string = strjoin(string(bwdist_elem_order), ";");


    % BoundingBoxes
    BB = regionprops(BW_object, 'BoundingBox', "Circularity", 'MajorAxisLength', 'Area');
    % Elapsed time: 0.00788 seconds ; 50 iterations in 4.3Gb of RAM memory used

    
    % ______MODIFICATION_____ %
    % We incorporate the components from the modified table into the main table
    
    % Pseudocode
    % 1. We modify the object (row of the table)
    % 2. We incorporate the object into the main table
    % 3. We incorporate the table into the table_main

    % We modify the current object:
    no_modified_object_modificada = no_modified_object;
    no_modified_object_modificada.Length = dades_imatge;
    no_modified_object_modificada.Indx_skel = BWskel_indx_string;
    no_modified_object_modificada.WidthValues = BWwidth_string;
    

    % morphological
    no_modified_object_modificada.Bounding = strjoin(string(BB.BoundingBox), ";");
    no_modified_object_modificada.Morph_circularity = BB.Circularity;
    no_modified_object_modificada.Morph_majoraxis = BB.MajorAxisLength;
    no_modified_object_modificada.Morph_area = BB.Area;
    
    
    % We incorporate into the general objects table
    main_table_actual_last_modiftable(indx_object_operate,:) = no_modified_object_modificada;

%     % We incorporate into table_main
%     % Index: app.table_main_sel.Image == main_table_actual_last.Image & app.table_main_sel.nModif == main_table_actual_last.nModif

    main_table_actual_last_modif = main_table_actual_last;
    main_table_actual_last_modif.ModifTable = {main_table_actual_last_modiftable};
%     
%     app.table_main_sel( app.table_main_sel.Image == main_table_actual_last.Image & app.table_main_sel.nModif == main_table_actual_last.nModif, : ) = main_table_actual_last_modif;
%  

    % % We check:
    % [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obtenir_main_table_corresponent(app)

    
    
    % FUNCTION END

    
    
end