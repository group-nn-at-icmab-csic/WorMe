function appf_interf_table_graficacio(app, main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object)


% graficació en GUI


% INICI FUNCIÓ


    % _____Graficació______
    % Basar-se en f'app_interf_graficar_img'

    % _Obtenció imatge original actual_
    [imatge_original, ~] = app_interf_obtain_original(app, str2double(app.img_contLabel.Text));
    prop_ext_BB = round((size(imatge_original, 1) * size(imatge_original, 2))^(1/3)); % Proporcio lineal imatge

    RGB_to_color_new = imatge_original;

    if ~isempty(no_modified_object)
        % % __Graficació___
        [BW_object] = create_BW_indx(appf_split_strindex(no_modified_object(1,:).Indx_BW), appf_split_strindex(no_modified_object(1,:).Resolution)');
        [BW_skel] = create_BW_indx(appf_split_strindex(no_modified_object(1,:).Indx_skel), appf_split_strindex(no_modified_object(1,:).Resolution)');

        % Objecte actual
        % RGB_to_color_new = imoverlay(RGB_to_color_new, BW_object, "r");

        indx_endpoints_BWskel = find(bwmorph(BW_skel, 'endpoints'));
        [indx_BWskel_obj_fin] = eixamplar_indx_noendpoints(find(BW_skel), indx_endpoints_BWskel, size(BW_skel));
        % Pintar els indx
        [RGB_to_color_new] = pintar_indx_to_RGB(RGB_to_color_new, indx_BWskel_obj_fin, "black");

        % __Objecte principal__
        BB_BWproces = appf_split_strindex_BB(no_modified_object.Bounding); % Bounding Box    

        % Bounding Box
        BB_BWproces = BB_BWproces + [-prop_ext_BB -prop_ext_BB +prop_ext_BB*2 +prop_ext_BB*2];
        [BB_index_punts] = BBxy_to_BBindx(BB_BWproces, size(BW_object));
        indx_BB_BW_objecte_eixmp = eixamplar_indx_BB(BB_index_punts, 2, size(BW_object));    % Eixamplem els index:
        [RGB_to_color_new] = pintar_indx_to_RGB(RGB_to_color_new, indx_BB_BW_objecte_eixmp, "red");

        % Dades llargada
        BB_val_xy = [BB_BWproces(:,1) + BB_BWproces(:,3), BB_BWproces(:,2) - 20]; % BB Text dades
        length_dades = no_modified_object.Length;     % Valors llargada:
        if isstring(length_dades); length_dades_graficar = round(str2double(length_dades)); else; length_dades_graficar = round(length_dades); end
        RGB_to_color_new = insertText(RGB_to_color_new, BB_val_xy, strcat("Length: ", string(length_dades_graficar)), 'BoxColor', "yellow", 'FontSize', round((prop_ext_BB)^(2/3)));
        
        % Grafiquem imatge objecte BW
        [BW_ini_regio_cropped, ~] = retallar_BWimatge_BB(BW_object, 3);
        app.Image4.Visible = 'on';
        app.Image4.ImageSource = graficar_rgbgraybw_image(BW_ini_regio_cropped);
        app.BW_img_extend = BW_object;
        app.BW_img_cuted = BW_ini_regio_cropped;
    else
        app.Image4.Visible = 'off';
    end
    
    

    % Objectes "yes"
    main_table_isyes = main_table_actual_last_modiftable(main_table_actual_last_modiftable.IsCeleg == "yes", :);
    if ~isempty(main_table_isyes)
        [RGB_to_color_new] = print_RGB_indx_brush(RGB_to_color_new, appf_split_strindex(main_table_isyes.Indx_BW), [-10 25 -10]); %[-20 50 -20]);
        
        % Dades llargada
        BB_values_yes = appf_split_strindex_BB(main_table_isyes.Bounding); % Bounding Box
        BB_values_read_xy = [BB_values_yes(:,1) + BB_values_yes(:,3), BB_values_yes(:,2) - 20];        
        RGB_to_color_new = insertText(RGB_to_color_new, BB_values_read_xy, strcat("Length: ", string(round(str2double(main_table_isyes.Length)))), 'BoxColor', "green", 'FontSize', round((prop_ext_BB)^(2/3)) ); % Elapsed time is 0.002617 seconds.
       
        % Esquel
        [indx_Skel_eix] = eixamplar_indx_BB(appf_split_strindex(main_table_isyes.Indx_skel), 1, appf_split_strindex(main_table_isyes(1,:).Resolution)');
        [RGB_to_color_new] = pintar_indx_to_RGB(RGB_to_color_new, indx_Skel_eix, "black");
        % Elapsed time is 0.004696 seconds.


        table_yes_draws = main_table_isyes(main_table_isyes.WidthValues == "Drawedline", : );

        if ~isempty(table_yes_draws)
            [RGB_to_color_new] = print_RGB_indx_brush(RGB_to_color_new, appf_split_strindex(table_yes_draws.Indx_BW), [-255 -255 -255]); %[-20 50 -20]);
            
%             % Dades llargada (re-marquem)
%             BB_values_yes = appf_split_strindex_BB(table_yes_draws.Bounding); % Bounding Box
%             BB_values_read_xy = [BB_values_yes(:,1) + BB_values_yes(:,3), BB_values_yes(:,2) - 20];             
%             table_yes_draws.Length
%             RGB_to_color_new = insertText(RGB_to_color_new, BB_values_read_xy, strcat("Length: ", string(round(str2double(table_yes_draws.Length)))), 'BoxColor', [0 138 0], 'FontSize', round((prop_ext_BB)^(2/3)) ); % Elapsed time is 0.002617 seconds.            
        end
        
    end

    % Objectes "no"
    main_table_isno = main_table_actual_last_modiftable(main_table_actual_last_modiftable.IsCeleg == "no", :);
    if ~isempty(main_table_isno)
         % Vermell no seleccionats
         [RGB_to_color_new] = print_RGB_indx_brush(RGB_to_color_new, appf_split_strindex(main_table_isno.Indx_BW), [25 -10 -10]);    
    end

    % Objectes "empty", que no són filtrats:
    % Nota: Els filtres són també descrits en f'app_interf_table_obtenir_main_table_actual'

    % Obtenim objectes filtrats pels filtres anotats:
    [main_table_actual_last_modiftable_nofilter, indx_filtre_tots] = app_interf_table_filter_index_obtain(app, main_table_actual_last_modiftable);
    %                                               ↑ Index circularitat
    
    % Index de l'objecte actual
    indx_obj_act = zeros(height(main_table_actual_last_modiftable),1);
    indx_obj_act(indx_object_operate) = 1;
    
    % ~indx_obj_act
    % ~indx_filtre_tots
    indx_empty = main_table_actual_last_modiftable.IsCeleg == "empty";

    indx_sel_emptyfiltre = ~indx_obj_act & ~indx_filtre_tots & indx_empty;
    
    % Obtenim sols els "empty":
    main_table_empty_nofilter = main_table_actual_last_modiftable(indx_sel_emptyfiltre, :);
    % Descartem també l'objecte actual.
    
    if ~isempty(main_table_empty_nofilter)
        % Fem BB
        indx_tot_BB = [];
        for n_row = 1:height(main_table_empty_nofilter)
            BB_BWproces = appf_split_strindex_BB(main_table_empty_nofilter(n_row, :).Bounding); % Bounding Box    
             % Bounding Box
            [BB_index_punts] = BBxy_to_BBindx(BB_BWproces, [size(imatge_original, 1), size(imatge_original, 2)]);
            indx_tot_BB = [indx_tot_BB; BB_index_punts];
        end
       
        [RGB_to_color_new] = pintar_indx_to_RGB(RGB_to_color_new, indx_tot_BB, "red");
        
    end

    % __Possible retallat imatge__
    if ~isempty(app.imcrop_value)
       % Retallem la imatge
        [RGB_to_color_new] = retallar_imatges_punts(RGB_to_color_new, app.imcrop_value);
    else
        app.LupaReturnButton.Visible = 'off';
    end
    % lapsed time is 0.001157 seconds.
    

    

    app.Image.ImageSource = RGB_to_color_new;





% FINAL FUNCIÓ

end