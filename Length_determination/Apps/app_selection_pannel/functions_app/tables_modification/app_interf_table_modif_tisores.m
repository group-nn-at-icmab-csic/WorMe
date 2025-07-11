function app_interf_table_modif_tisores(app)

% Scissors button
%
% Obtains, modifies, and integrates the data into the database.

% START FUNCTION

    % Obtain current data
    [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obtenir_main_table_corresponent(app);

    % Obtain binary object    
    [BW_object] = create_BW_indx(appf_split_strindex(no_modified_object(1,:).Indx_BW), appf_split_strindex(no_modified_object(1,:).Resolution)');
    
    [imatge_original, ~] = app_interf_obtain_original(app, str2double(app.img_contLabel.Text)); % original image
        
    % __Cut the binary object with the scissors tool__ % ççç
    % can be improved (edges, color, etc.)
    [BW_cuted, ~, porta_window_drawline, ~] = dividie_BWobj_manual_multiple(BW_object, imatge_original);
    % BW_cuted : BW image with the line subtracted.
    % porta_window_drawline : indicates whether the function executed correctly.    


    % ÑÑÑ
    % If it has been cut:
    % Pseudocode: 
    % 1. Obtain original image and cut BW image
    % 2. Scale the indices to the original image.

%         % __Possible cropped image__
%     if ~isempty(app.imcrop_value)
%        % Crop the image
%         [RGB_to_color_new] = cut_imgs_points(RGB_to_color_new, app.imcrop_value);
    


    % If the program runs correctly:
    if porta_window_drawline
        
        % We will define new tables in the main modification table.

        % no_modified_object_modificada - modified object table
        % main_table_actual_last_modiftable - table of all objects
        
        % Modify current object:
%         no_modified_object_modificada = no_modified_object;
%         no_modified_object_modificada.IsCeleg = "yes";

        % Index of the current object
        indx_obj_act = zeros(height(main_table_actual_last_modiftable),1);
        indx_obj_act(indx_object_operate) = 1;

        % Remove the current object
        % disp("Normal")
        % main_table_actual_last_modiftable
        % disp("Modified")
        main_table_actual_last_modiftable = main_table_actual_last_modiftable(~indx_obj_act,:);
        
        
        % We will add at the beginning of the table the data of the current objects.

        % Obtain object
        [S_textscan_table_row_main] = consol_S_textscan_modifs(BW_cuted, "empty", string(app.img_original_nomLabel.Text), "Modifs_string");
        
        % Add it at the top (so the most recent selections appear first):
        main_table_actual_last_modiftable = [S_textscan_table_row_main; main_table_actual_last_modiftable];

        % Incorporate into the main table
        main_table_actual_last_new = main_table_actual_last;
        main_table_actual_last_new.nModif = main_table_actual_last_new.nModif+1; % Add 1 to the current modification
        main_table_actual_last_new.ModifTable = {main_table_actual_last_modiftable}; % Update the table of modified objects

        % Incorporate into table_main
        app.table_main_sel = [app.table_main_sel; main_table_actual_last_new];


        
    end


% END FUNCTION


end