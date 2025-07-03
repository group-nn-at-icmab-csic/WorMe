function [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obtenir_main_table_actual(app)
   
    % Obté la taula de moficicacións actual.
    
    % Permèt així poder graficar i operar vers aquesta (tornant a
    % definir-la).
    
    % INICI FUNCIÓ
    
    % ___Taula general___

    % app.global_temps_total_inici = table();

    % _Obtenim el nombre de modificacions_
    % Ens basem amb el nom de la imatge.
    
    
    if ~isempty(app.global_temps_total_inici)
        n_modifs = height(app.global_temps_total_inici(app.global_temps_total_inici.Image == string(app.img_original_nomLabel.Text), :));
    else
        n_modifs = 0;
    end

    % Si no hi ha anotacions:
    if isequal(n_modifs, 0) 
        % disp("New img")

        % Creem taula BW objectes
        [S_textscan_table_row_main] = app_interf_table_crear_BW_taula(app);

        
        if ~isempty(S_textscan_table_row_main)
            
            % Incorporació de la taula en la taula_main
            app_inter_table_incorporar_BW_table(app, S_textscan_table_row_main);

            % Obtenció modificació
            [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obt_ultima_modif(app);
            
        else
            % disp("New image with no objects")
            % Si en l'objecte nou actual, no hi ha objectes:

            % _Grafica imatge sense objectes_
            app_interf_table_actu_imatge_no_objectes(app)
            
            % Def objectes
            main_table_actual_last = [];
            main_table_actual_last_modiftable = [];
            indx_object_operate = [];
            no_modified_object = [];
            
            
            
        end
            
        
        
        
    else
        %disp("Already img")

        % Obtenció modificació
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


    % De moment: Elapsed time is 0.002379 seconds.

    % FINAL FUNCIÓ

end % Fi funcio principal botó


% Ara la qüestió seria incorporar una copia d'aquesta modificació a la
% taula.



function [S_textscan_table_row_main] = app_interf_table_crear_BW_taula(app)

% Crea la taula dels objectes de l'objecte actual

% See also

% INICI FUNCIO

    % Suposem que la imatge és la primera i es nova

    % Actualitzem contador imatges
    n_imatge = str2double(app.img_contLabel.Text);

    % _Obtenció imatge original_
    [imatge_original, ~] = app_interf_obtain_original(app, n_imatge);

    % _Processament de la imatge original_ 
    [BW_final] = app_interf_process_img(app, imatge_original);

    % app.img_original_nomLabel.Text : nom de la imatge actual.

    % Obtenim object
    [S_textscan_table_row_main] = consol_S_textscan_modifs(BW_final, "empty", string(app.img_original_nomLabel.Text), "Modifs_string");

% FINAL FUNCIÓ

end
    


function app_inter_table_incorporar_BW_table(app, S_textscan_table_row_main)

    % Incorpora la taula del BW a la taula main.

    % INICI FUNCIÓ

    if ~isempty(app.global_temps_total_inici)
        n_modifs = height(app.global_temps_total_inici(app.global_temps_total_inici.Image == string(app.img_original_nomLabel.Text), :));
    else
        n_modifs = 0;
    end
    
    % _Creació i incorporació de la taula nova_
    taula_modif_sing = table(string(app.img_original_nomLabel.Text), n_modifs+1, {S_textscan_table_row_main}, 'VariableNames', {'Image', 'nModif', 'ModifTable'});

    if isempty(app.global_temps_total_inici)
        app.global_temps_total_inici = taula_modif_sing;
    else
        app.global_temps_total_inici = [app.global_temps_total_inici; taula_modif_sing]; 
    end

    % FINAL FUNCIÓ

end


function [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obt_ultima_modif(app)

    % Obté la última modificació de la taula general, per tal de poder graficar
    % i operar amb aquesta.

    
    % Variables
    % main_table_actual_last - taula última modificació
    % main_table_actual_last_modiftable - taula dels objectes, de la ultima modificació
    % indx_object_operate - index del objecte a operar (en aplicat del filtres, i no empty)
    % no_modified_object - objecte a operar (en aplicat del filtres i no empty)
    
    % _Selecció ultima modificacio_
    % Modificacions de la imatge actual
    main_table_actual = app.global_temps_total_inici(app.global_temps_total_inici.Image == string(app.img_original_nomLabel.Text), :);

    
    % Modificació ultima
    main_table_actual_last = main_table_actual(main_table_actual.nModif == max(main_table_actual.nModif),:);
    % Taula modificacions
    main_table_actual_last_modiftable = main_table_actual_last.ModifTable{1};


    % fins aqui tenim la taula amb els objectes binaris de la ultima
    % modificació de la imatge.
    %
    % Ara hem de: 1. Seleccionar un objecte (filtrant els parametres), i
    % graficar-lo. o 2. Si no hi ha objecte, passar a la proxima imatge.

    [li_a, li_b] = ismember(main_table_actual_last_modiftable.IsCeleg, "empty");

    % main_table_actual_last_modiftable.Properties.VariableNames
    %     {'IsCeleg'}    {'NomWorm'}    {'Length'}    {'Bounding'}    {'Modifs'}    {'Indx_skel'}    {'Indx_BW'}    {'WidthValues'}    {'Resolution'}    {'Morph_circularity'}
    %     {'Morph_majoraxis'}    {'Morph_area'}

    % _Filtres_ % 
    [~ , indx_filtres] = app_interf_table_filter_index_obtain(app, main_table_actual_last_modiftable);
    indx_filtres = ~indx_filtres;
     
    indx_find = find(li_b & indx_filtres);
    indx_find_num = indx_find((indx_find > 0) == 1);

    % indx_object_operate : index de l'objecte últim.

    % Nota: els index es basen en la taula de modificació, en el total de la
    % mateixa.
    if ~isempty(indx_find_num)
        indx_object_operate = indx_find_num(1);
        no_modified_object = main_table_actual_last_modiftable(indx_object_operate, :);
    
    % Si no hi ha cap objecte a modificar (empty post-filtrat), es
    % retorna com a vuit.
    else
        indx_object_operate = [];
        no_modified_object = table();
    end
   


    % Fins aqui tenim l'objecte determinat. Ara hauriem d'obtenir, graficar, i
    % decidir sobre aquest.

    % Per lo tant, es GUARDEN les configuracions (index de la modificacio i
    % taula), per tal de poder operar amb aquesta, quan hi hagi, posteriorment,
    % la DECISIÓ de l'usuari.

end