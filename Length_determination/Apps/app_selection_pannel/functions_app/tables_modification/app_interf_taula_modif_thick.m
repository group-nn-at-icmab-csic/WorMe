function app_interf_taula_modif_thick(app)

% Thick button
%
% Obtains, modifies, and integrates the data into the database.

% START OF THE FUNCTION

    % Incorporation of "yes" into the table
    [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obtenir_main_table_corresponent(app);

    % ______MODIFICATION_____ %

    %app_interf_table_modif_yes

    % Pseudocode
    % 1. Modify object (row of the table)
    % 2. Incorporate object into the main table
    % 3. Incorporate table into table_main

    % Modify current object:
    no_modified_object_modificada = no_modified_object;
    no_modified_object_modificada.IsCeleg = "yes";

    % Incorporate into the general table of objects
    main_table_actual_last_modiftable(indx_object_operate,:) = no_modified_object_modificada;

    % Incorporate into the main table
    main_table_actual_last_new = main_table_actual_last;
    main_table_actual_last_new.nModif = main_table_actual_last_new.nModif+1; % Add 1 to the current modification
    main_table_actual_last_new.ModifTable = {main_table_actual_last_modiftable}; % Update the table of modified objects

    % Incorporate into table_main
    app.table_main_sel = [app.table_main_sel; main_table_actual_last_new];


    % disp("Showing data")
    % disp(app.table_main_sel)
    % disp(app.table_main_sel(1, :))

    % table1 = app.table_main_sel.ModifTable(end);
    % disp(table1{:,1})
    % disp(table1{1,:})
    % disp(class(table1))
    % save("table1.mat", "table1")
    % disp("saved!")
    

    % Check:
    % [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obtenir_main_table_actual(app)
    % [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obtenir_main_table_corresponent(app)

    
    % Renewal of previous object
    % Crop the object
    BB_values = appf_split_strindex(no_modified_object_modificada.Bounding)';
    app_interf_determinar_ultim_object(app, BB_values, "thick")


%     [imageArray_crop, BW_filt_crop, BB_values, proporcio_img] = cut_BB_BW_RGB_image(imatge_original, BW_final_object, 5);
%     % Show in lower image:
%     app.Image4.ImageSource = graph_rgbgraybw_image(BW_filt_crop);



% END OF THE FUNCTION


end