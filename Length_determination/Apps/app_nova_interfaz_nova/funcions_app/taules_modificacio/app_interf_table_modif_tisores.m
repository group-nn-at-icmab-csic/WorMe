function app_interf_table_modif_tisores(app)

% Botó tisores
%
% Obté, modifica i integra les dades a la base de dades.

% INICI FUNCIÓ

    % Obtenim dades actuals
    [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obtenir_main_table_corresponent(app);

    % Obtenim objecte binari    
    [BW_object] = create_BW_indx(appf_split_strindex(no_modified_object(1,:).Indx_BW), appf_split_strindex(no_modified_object(1,:).Resolution)');
    
    [imatge_original, ~] = app_interf_obtain_original(app, str2double(app.img_contLabel.Text)); %  imatge original
        
    % __Retallem amb les tisores l'objecte binari__ % ççç
    % millorable ( vores, color, etc.)
    [BW_cuted, ~, porta_window_drawline, ~] = dividie_BWobj_manual_multiple(BW_object, imatge_original);
    % BW_cuted : imatge BW amb la línia restada.
    % porta_window_drawline : Porta sobre si s'ha executat o no correctament la funció.    


    % ÑÑÑ
    % Si està retallat:
    % Pseudocodi: 
    % 1. Obtenir imatge original i BW retallada
    % 2. Escalar els index a la imatge original.

%         % __Possible retallat imatge__
%     if ~isempty(app.imcrop_value)
%        % Retallem la imatge
%         [RGB_to_color_new] = retallar_imatges_punts(RGB_to_color_new, app.imcrop_value);
    


    % Si el programa s'executa correctament:
    if porta_window_drawline
        
        % Definirem noves taules a la taula principal de modificació.

        % no_modified_object_modificada - taula objecte modificat
        % main_table_actual_last_modiftable - taula tots objectes
        
        % Modifiquem objecte actual:
%         no_modified_object_modificada = no_modified_object;
%         no_modified_object_modificada.IsCeleg = "yes";

        % Index de l'objecte actual
        indx_obj_act = zeros(height(main_table_actual_last_modiftable),1);
        indx_obj_act(indx_object_operate) = 1;

        % Eliminem l'objecte actual
        % disp("Normal")
        % main_table_actual_last_modiftable
        % disp("Modificada")
        main_table_actual_last_modiftable = main_table_actual_last_modiftable(~indx_obj_act,:);
        
        
        % Afegirem a l'inici de la taula les dades dels objectes actuals.

        % Obtenim object
        [S_textscan_table_row_main] = consol_S_textscan_modifs(BW_cuted, "empty", string(app.img_original_nomLabel.Text), "Modifs_string");
        
        % Ajuntem a aquesta, des de dalt (perque hi hagi la selecció dels ultims primer):
        main_table_actual_last_modiftable = [S_textscan_table_row_main; main_table_actual_last_modiftable];

        % Incorporem a la taula principal
        main_table_actual_last_new = main_table_actual_last;
        main_table_actual_last_new.nModif = main_table_actual_last_new.nModif+1; % Sumem 1 a la modif actual
        main_table_actual_last_new.ModifTable = {main_table_actual_last_modiftable}; % Actualitzem la taula dels objectes modificats

        % Incorporem a la taula_main
        app.global_temps_total_inici = [app.global_temps_total_inici; main_table_actual_last_new];


        
    end


% FINAL FUNCIÓ

end