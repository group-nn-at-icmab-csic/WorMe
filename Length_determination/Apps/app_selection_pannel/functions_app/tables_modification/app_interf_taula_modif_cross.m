function app_interf_taula_modif_cross(app)

% Botó thick
%
% Obté, modifica i integra les dades a la base de dades.

% INICI FUNCIÓ

    % Incorporació "no" a la taula
    [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obtenir_main_table_corresponent(app);

    % ______MODIFICACIÓ_____ %

    %app_interf_table_modif_yes

    % Pseudocodi
    % 1. Modifiquem objecte (fila de la taula)
    % 2. Incorporem objecte a la taula principal
    % 3. Incorporem taula a la taula_main

    % Modifiquem objecte actual:
    no_modified_object_modificada = no_modified_object;
    no_modified_object_modificada.IsCeleg = "no";

    % Incorporem a la taula general d'objectes
    main_table_actual_last_modiftable(indx_object_operate,:) = no_modified_object_modificada;

    % Incorporem a la taula principal
    main_table_actual_last_new = main_table_actual_last;
    main_table_actual_last_new.nModif = main_table_actual_last_new.nModif+1; % Sumem 1 a la modif actual
    main_table_actual_last_new.ModifTable = {main_table_actual_last_modiftable}; % Actualitzem la taula dels objectes modificats

    % Incorporem a la taula_main
    app.table_main_sel = [app.table_main_sel; main_table_actual_last_new];

    % Renovació objecte anterior
    % Retallem l'objecte
    BB_values = appf_split_strindex(no_modified_object_modificada.Bounding)';
    app_interf_determinar_ultim_object(app, BB_values, "cross")

    % Comprovació:
    % [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obtenir_main_table_actual(app)
    % [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obtenir_main_table_corresponent(app)




% FINAL FUNCIÓ

end