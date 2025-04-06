function app_interf_table_modif_extend(app)

% Botó tisores
%
% Obté, modifica i integra les dades a la base de dades.

% INICI FUNCIÓ

    % Obtenim dades actuals
    [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obtenir_main_table_corresponent(app);
    % [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obtenir_main_table_actual(app);
    
    % Obtenim objecte binari    
    [BW_object] = create_BW_indx(appf_split_strindex(no_modified_object(1,:).Indx_BW), appf_split_strindex(no_modified_object(1,:).Resolution)');
    
    [imatge_original, ~] = app_interf_obtain_original(app, str2double(app.img_contLabel.Text)); %  imatge original

    % __Retallem amb les tisores l'objecte binari__ %
    [bwlabel_BW_obj_sumatlinia, ~, porta_window_drawline, zeros_imatge_cotxe_punts_units] = sum_BWobj_manual_multiple(BW_object, imatge_original, 3);

    % imshow(bwlabel_BW_obj_sumatlinia)
        
    % Si el programa s'executa correctament:
    if porta_window_drawline
        
        % Si s'han creat més d'un objecte
        if ~isequal(getfield(bwconncomp(bwlabel_BW_obj_sumatlinia, 8), 'NumObjects'), 1)
            ms_g = imread("icon_48.png");
            msgbox("You must extend the existing object.", "Advise", 'custom', ms_g);
            pause(1.5)
            close 

        else
            % Re-Definirem l'objecte binaria de la taula de l'objecte actual
            no_modified_object_modificada = no_modified_object;

            % Modifiquem objecte actual:
            no_modified_object_modificada(1,:).Indx_BW = strjoin(string(find(bwlabel_BW_obj_sumatlinia)), ";"); %find(bwlabel_BW_obj_sumatlinia)
            % Nota: veure f'creacio_S_textscan_modifs'


            % Re-definim els valors morfològics de la imatge
            % Nota: sols es modifica la v'main_table_actual_last_modiftable'

            % antic: appf_interf_table_incorporar_BWskelmorph
            [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = appf_interf_table_redefinir_BWskelmorph(app, main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object_modificada);

    %         % Incorporem a la taula general d'objectes
    %         main_table_actual_last_modiftable
    %         indx_object_operate
    %         main_table_actual_last_modiftable(indx_object_operate,:) = main_table_actual_last_modiftable;

            % Incorporem a la taula principal
            main_table_actual_last_new = main_table_actual_last;
            main_table_actual_last_new.nModif = main_table_actual_last_new.nModif+1; % Sumem 1 a la modif actual
            main_table_actual_last_new.ModifTable = {main_table_actual_last_modiftable}; % Actualitzem la taula dels objectes modificats


            % Incorporem a la taula_main
            app.global_temps_total_inici = [app.global_temps_total_inici; main_table_actual_last_new];
        end
    end


% FINAL FUNCIÓ

end