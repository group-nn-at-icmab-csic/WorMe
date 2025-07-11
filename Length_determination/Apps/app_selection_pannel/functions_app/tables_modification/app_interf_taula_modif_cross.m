function app_interf_taula_modif_cross(app)

% Thick button
%
% Obtains, modifies, and integrates the data into the database.

% START OF THE FUNCTION

    % Incorporation of "no" into the table
    [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obtenir_main_table_corresponent(app);

    % ______MODIFICATION_____ %

    %app_interf_table_modif_yes

    % Pseudocode
    % 1. Modify object (row of the table)
    % 2. Incorporate object into the main table
    % 3. Incorporate table into the table_main

    % Modify current object:
    no_modified_object_modificada = no_modified_object;
    no_modified_object_modificada.IsCeleg = "no";

    % Incorporate into the general table of objects
    main_table_actual_last_modiftable(indx_object_operate,:) = no_modified_object_modificada;

    % Incorporate into the main table
    main_table_actual_last_new = main_table_actual_last;
    main_table_actual_last_new.nModif = main_table_actual_last_new.nModif+1; % Add 1 to the current modification
    main_table_actual_last_new.ModifTable = {main_table_actual_last_modiftable}; % Update the table of modified objects

    % Incorporate into table_main
    app.table_main_sel = [app.table_main_sel; main_table_actual_last_new];

    % Renewal of previous object
    % Crop the object
    BB_values = appf_split_strindex(no_modified_object_modificada.Bounding)';
    app_interf_determinar_ultim_object(app, BB_values, "cross")

    % Check:
    % [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obtenir_main_table_actual(app)
    % [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obtenir_main_table_corresponent(app)

% END OF THE FUNCTION


end