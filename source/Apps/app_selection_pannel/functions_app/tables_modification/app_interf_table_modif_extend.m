function app_interf_table_modif_extend(app)

% Scissors button
%
% Obtains, modifies, and integrates the data into the database.

% START FUNCTION

    % Obtain current data
    [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obtenir_main_table_corresponent(app);
    % [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obtenir_main_table_actual(app);
    
    % Obtain binary object    
    [BW_object] = create_BW_indx(appf_split_strindex(no_modified_object(1,:).Indx_BW), appf_split_strindex(no_modified_object(1,:).Resolution)');
    
    [imatge_original, ~] = app_interf_obtain_original(app, str2double(app.img_contLabel.Text)); % original image

    % __Cut the binary object with the scissors tool__ %
    [bwlabel_BW_obj_sumatlinia, ~, porta_window_drawline, zeros_imatge_cotxe_punts_units] = sum_BWobj_manual_multiple(BW_object, imatge_original, 3);

    % imshow(bwlabel_BW_obj_sumatlinia)
        
    % If the program runs correctly:
    if porta_window_drawline
        
        % If more than one object has been created
        if ~isequal(getfield(bwconncomp(bwlabel_BW_obj_sumatlinia, 8), 'NumObjects'), 1)
            ms_g = imread("icon_48.png");
            msgbox("You must extend the existing object.", "Advise", 'custom', ms_g);
            pause(1.5)
            close 

        else
            % We will re-define the binary object in the table of the current object
            no_modified_object_modificada = no_modified_object;

            % Modify current object:
            no_modified_object_modificada(1,:).Indx_BW = strjoin(string(find(bwlabel_BW_obj_sumatlinia)), ";"); %find(bwlabel_BW_obj_sumatlinia)
            % Note: see f'create_S_textscan_modifs'


            % Re-define morphological values of the image
            % Note: only the 'main_table_actual_last_modiftable' is modified

            % old: appf_interf_table_incorporar_BWskelmorph
            [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = appf_interf_table_redefinir_BWskelmorph(app, main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object_modificada);

    %         % We incorporate into the general object table
    %         main_table_actual_last_modiftable
    %         indx_object_operate
    %         main_table_actual_last_modiftable(indx_object_operate,:) = main_table_actual_last_modiftable;

            % We incorporate into the main table
            main_table_actual_last_new = main_table_actual_last;
            main_table_actual_last_new.nModif = main_table_actual_last_new.nModif+1; % We add 1 to the current modification
            main_table_actual_last_new.ModifTable = {main_table_actual_last_modiftable}; % We update the table of modified objects


            % We incorporate into the table_main
            app.table_main_sel = [app.table_main_sel; main_table_actual_last_new];
        end
    end


% END FUNCTION


end