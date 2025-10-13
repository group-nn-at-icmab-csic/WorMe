function app_interf_table_modif_drawline(app)

% Draw line button

% Creates the drawing and saves it as a new object, whose measurement is already
% determined (it is not empty), and it is saved as another modification in
% the table_main.
%
% The measurement is that of the pixels of the skeletonized image, not from the
% Fiji correction.

% Obtains, modifies, and integrates the data into the database.

% START FUNCTION

    % [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obtenir_main_table_corresponent(app);

    [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obtenir_main_table_actual(app);

    
    [imatge_original, ~] = app_interf_obtain_original(app, str2double(app.img_contLabel.Text)); % original image

    escala_imatge = app.appv_escala_img;


    [dades_imatge, dades_imatge_punts, BW_draw, porta_window_drawline] = draw_line_length(imatge_original, escala_imatge);
    %   dades_imatge : length of the line pixel by pixel
    %   dades_imatge_2 : length of the line only at determined positions (Fiji error)
    %   BW_draw : BW image (skeletonized?)
    %   porta_window_drawline : determination if the function has run correctly.

    % imshow(BW_draw)

    if porta_window_drawline
        
        % main_table_actual_last_modiftable - Table with the objects.
        
        % We will generate a new 'no_modified_object_modificada' and incorporate it
        % into 'main_table_actual_last_modiftable'.
        
        
%        no_modified_object.Properties.VariableNames
%          {'IsCeleg'}    {'NomWorm'}    {'Length'}    {'Bounding'}    {'Modifs'}    {'Indx_skel'}    {'Indx_BW'}    {'WidthValues'}    {'Resolution'}    {'Morph_circularity'}
%         {'Morph_majoraxis'}    {'Morph_area'}


        % ___Definition of BW object properties___
        % Note: see create_S_textscan_modifs
        
        BW_indx_string = strjoin(string(find(BW_draw)), ";");
        % Note: BW_indx_string is the index of BW object and BW skeleton.
        
        % Image resolution
        resol_string = strjoin(string([size(BW_draw, 1), size(BW_draw, 2)]), ";");
        BWwidth_string = "Drawedline";

        % Morphological properties
        BB = regionprops(BW_draw, 'BoundingBox', "Circularity", 'MajorAxisLength', 'Area');
        BB_string = strjoin(string(BB.BoundingBox), ";");
        morph_prop_circularity = BB.Circularity;
        morph_prop_majoraxis = BB.MajorAxisLength;
        morph_prop_area = BB.Area;
        
        modifs_string = "Modifs_string";

        % dades_imatge - distance between pixels
        % dades_imatge_punts - distance between pixels every X points (manual correction error)
        
        % _Cell of data_
        cell_dades_totals = {"yes", string(app.img_original_nomLabel.Text), string(dades_imatge), BB_string, modifs_string, ...
                BW_indx_string, BW_indx_string, BWwidth_string, resol_string, morph_prop_circularity, morph_prop_majoraxis, morph_prop_area};
%         cell_dades_totals = {"yes", string(app.img_original_nomLabel.Text), string(dades_imatge_punts), BB_string, modifs_string, ...
%                 BW_indx_string, BW_indx_string, BWwidth_string, resol_string, morph_prop_circularity, morph_prop_majoraxis, morph_prop_area};

        variables_noms = [ "IsCeleg", "NomWorm", "Length", "Bounding", "Modifs", ...
            "Indx_skel", "Indx_BW", "WidthValues", "Resolution", "Morph_circularity", "Morph_majoraxis", "Morph_area"];

        % _Creation as a table_
        S_textscan_table_row = cell2table(cell_dades_totals, 'VariableNames', variables_noms);

        
        % __Incorporation into data table__

        % We incorporate it into the main table
        
        if isempty(main_table_actual_last)
            % If there are no annotations
            
            % We create the table (main_table_actual_last_new) and incorporate it
                % _Creation and incorporation of the new table_
            main_table_actual_last_new = table(string(app.img_original_nomLabel.Text), 1, {S_textscan_table_row}, 'VariableNames', {'Image', 'nModif', 'ModifTable'});

            
        else
            % If there are annotations

            % We move the object table into the objects table.
            main_table_actual_last_modiftable = [main_table_actual_last_modiftable; S_textscan_table_row];
            
            main_table_actual_last_new = main_table_actual_last;
            main_table_actual_last_new.nModif = main_table_actual_last_new.nModif+1; % We add 1 to the current modification
            main_table_actual_last_new.ModifTable = {main_table_actual_last_modiftable}; % We update the modified objects table

        end
        
        % We incorporate it into the table_main
        app.table_main_sel = [app.table_main_sel; main_table_actual_last_new];

        
        
        % We plot the last object
        app_interf_determinar_ultim_object(app, BB.BoundingBox, "thick")

    end



% END FUNCTION





end