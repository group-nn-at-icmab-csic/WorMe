function [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obtenir_main_table_actual(app)
   
% Retrieves the current modifications table.

% Allows working and plotting based on this table (redefining it if needed).
    
    % START FUNCTION
    
    % ___General table___

    % app.table_main_sel = table();

    % _Obtain the number of modifications_
    % Based on the name of the image.
    
    
    if ~isempty(app.table_main_sel)
        n_modifs = height(app.table_main_sel(app.table_main_sel.Image == string(app.img_original_nomLabel.Text), :));
    else
        n_modifs = 0;
    end

    % If there are no annotations:
    if isequal(n_modifs, 0) 
        % disp("New img")

        % Create BW objects table
        [S_textscan_table_row_main] = app_interf_table_crear_BW_taula(app);

        
        if ~isempty(S_textscan_table_row_main)
            
            % Incorporate the table into the main table
            app_inter_table_incorporar_BW_table(app, S_textscan_table_row_main);

            % Get last modification
            [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obt_ultima_modif(app);
            
        else
            % disp("New image with no objects")
            % If the new current object has no objects:

            % _Plot image without objects_
            app_interf_table_actu_imatge_no_objectes(app)
            
            % Define empty outputs
            main_table_actual_last = [];
            main_table_actual_last_modiftable = [];
            indx_object_operate = [];
            no_modified_object = [];
            
            
            
        end
            
        
        
        
    else
        %disp("Already img")

        % Get last modification
        [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obt_ultima_modif(app);

        
        if isempty(no_modified_object)
            %disp("isempty")
        end
        
    end

    %     
    %     main_table_actual_last
    %     
    %     main_table_actual_last_modiftable
    %     
    %     indx_object_operate
    %     
    %     no_modified_object
    %     


    % Currently: Elapsed time is 0.002379 seconds.

    % END FUNCTION

end % End main function for button




% Now the question would be to incorporate a copy of this modification into the table.



function [S_textscan_table_row_main] = app_interf_table_crear_BW_taula(app)

% Creates the table of objects for the current object

% See also

% START FUNCTION

    % We assume the image is the first one and is new

    % Update image counter
    n_imatge = str2double(app.img_contLabel.Text);

    % _Obtain original image_
    [imatge_original, ~] = app_interf_obtain_original(app, n_imatge);

    % _Process the original image_ 
    [BW_final] = app_interf_process_img(app, imatge_original);

    % app.img_original_nomLabel.Text : name of the current image.

    % Obtain object
    [S_textscan_table_row_main] = consol_S_textscan_modifs(BW_final, "empty", string(app.img_original_nomLabel.Text), "Modifs_string");

% END FUNCTION

end
    


function app_inter_table_incorporar_BW_table(app, S_textscan_table_row_main)

    % Incorporates the BW table into the main table.

    % START FUNCTION

    if ~isempty(app.table_main_sel)
        n_modifs = height(app.table_main_sel(app.table_main_sel.Image == string(app.img_original_nomLabel.Text), :));
    else
        n_modifs = 0;
    end
    
    % _Creation and incorporation of the new table_
    taula_modif_sing = table(string(app.img_original_nomLabel.Text), n_modifs+1, {S_textscan_table_row_main}, 'VariableNames', {'Image', 'nModif', 'ModifTable'});

    if isempty(app.table_main_sel)
        app.table_main_sel = taula_modif_sing;
    else
        app.table_main_sel = [app.table_main_sel; taula_modif_sing]; 
    end

    % END FUNCTION

end


function [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obt_ultima_modif(app)

    % Obtains the last modification from the general table in order to plot
    % and work with it.

    
    % Variables
    % main_table_actual_last - table of the last modification
    % main_table_actual_last_modiftable - table of the objects from the last modification
    % indx_object_operate - index of the object to operate on (after filters, and not empty)
    % no_modified_object - object to operate on (after filters, and not empty)
    
    % _Select last modification_
    % Modifications for the current image
    main_table_actual = app.table_main_sel(app.table_main_sel.Image == string(app.img_original_nomLabel.Text), :);

    
    % Last modification
    main_table_actual_last = main_table_actual(main_table_actual.nModif == max(main_table_actual.nModif),:);
    % Modifications table
    main_table_actual_last_modiftable = main_table_actual_last.ModifTable{1};


    % Up to here, we have the table with the binary objects from the last
    % modification of the image.
    %
    % Now we need to: 1. Select an object (filtering parameters) and
    % plot it, or 2. If no object exists, move to the next image.

    [li_a, li_b] = ismember(main_table_actual_last_modiftable.IsCeleg, "empty");

    % main_table_actual_last_modiftable.Properties.VariableNames
    %     {'IsCeleg'}    {'NomWorm'}    {'Length'}    {'Bounding'}    {'Modifs'}    {'Indx_skel'}    {'Indx_BW'}    {'WidthValues'}    {'Resolution'}    {'Morph_circularity'}
    %     {'Morph_majoraxis'}    {'Morph_area'}

    % _Filters_ % 
    [~ , indx_filtres] = app_interf_table_filter_index_obtain(app, main_table_actual_last_modiftable);
    indx_filtres = ~indx_filtres;
     
    indx_find = find(li_b & indx_filtres);
    indx_find_num = indx_find((indx_find > 0) == 1);

    % indx_object_operate : index of the last object.

    % Note: the indices are based on the modification table, considering
    % the total table.
    if ~isempty(indx_find_num)
        indx_object_operate = indx_find_num(1);
        no_modified_object = main_table_actual_last_modiftable(indx_object_operate, :);
    
    % If there is no object to modify (empty after filtering), it
    % returns empty.
    else
        indx_object_operate = [];
        no_modified_object = table();
    end
   


    % Up to here, we have determined the object. Now we should obtain,
    % plot, and decide on this object.

    % Therefore, the configurations are SAVED (index of the modification and
    % table) to allow operating on it later, when the user makes a DECISION.

end
