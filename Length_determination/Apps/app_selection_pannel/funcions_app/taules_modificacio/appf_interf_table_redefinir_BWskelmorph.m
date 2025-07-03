function [main_table_actual_last_modif, main_table_actual_last_modiftable, indx_object_operate, no_modified_object_modificada]= appf_interf_table_redefinir_BWskelmorph(app, main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object)

% Com appf_interf_table_incorporar_BWskelmorph, però l'objecte que es
% defineix no es re-integra en la taula_main
% (app.global_temps_total_inici), sinó que simplement es re-defineixen les taules.
%
% Obté i determina les propietats morfologiques de esqueletonització i
% ampalda de l'objecte binari, i les re-descriu a la taula table_main.

% INICI FUNCIÓ


    % Describim l'esqueletonització dels mateixos.
    [BW_object] = create_BW_indx(appf_split_strindex(no_modified_object(1,:).Indx_BW), appf_split_strindex(no_modified_object(1,:).Resolution)');
    
    % Skel
    [BW_ini_regio_cropped, proporcio_img] = retallar_BWimatge_BB(BW_object, 1);
    [BW_skel_crop, dades_imatge, ~] = esqueletonitzacio_josep_optim(BW_ini_regio_cropped, app.appv_escala_img, true, true);    

    % Escalem els index
    [indx_BW_skel_scal] = escalar_indx(find(BW_skel_crop), size(BW_object), size(BW_ini_regio_cropped), proporcio_img);
    % En strig
    BWskel_indx_string = strjoin(string(indx_BW_skel_scal), ";");
    
    % Amplada valors
    [bwdist_elem_order, ~] = width_bwskeldist_values(BW_ini_regio_cropped, BW_skel_crop);
    % En strig
    BWwidth_string = strjoin(string(bwdist_elem_order), ";");


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

%     % Incorporem a la taula_main
%     % INdex: app.global_temps_total_inici.Image == main_table_actual_last.Image & app.global_temps_total_inici.nModif == main_table_actual_last.nModif
% 
    main_table_actual_last_modif = main_table_actual_last;
    main_table_actual_last_modif.ModifTable = {main_table_actual_last_modiftable};
%     
%     app.global_temps_total_inici( app.global_temps_total_inici.Image == main_table_actual_last.Image & app.global_temps_total_inici.nModif == main_table_actual_last.nModif, : ) = main_table_actual_last_modif;
%  

    % % Comprovem:
    % [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obtenir_main_table_corresponent(app)

    
    
    % FINAL FUNCIÓ
    
    
end