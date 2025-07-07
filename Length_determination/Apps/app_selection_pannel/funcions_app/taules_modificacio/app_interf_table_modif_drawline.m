function app_interf_table_modif_drawline(app)

% Botó draw line

% Crea el dibuix, i guarda aquest com un objecte nou, la mesura del qual ja
% és determinda (no és en empty), i es gaurda com una modificació més a la
% taula_main.
%
% La mesura és la dels pixels de la imatge esqueletonitzada, no de la
% correcció de Fiji.

% Obté, modifica i integra les dades a la base de dades.

% INICI FUNCIÓ

    % [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obtenir_main_table_corresponent(app);

    [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obtenir_main_table_actual(app);

    
    [imatge_original, ~] = app_interf_obtain_original(app, str2double(app.img_contLabel.Text)); %  imatge original

    escala_imatge = app.appv_escala_img;


    [dades_imatge, dades_imatge_punts, BW_draw, porta_window_drawline] = draw_line_length(imatge_original, escala_imatge);
    %   dades_imatge : llargada de la línia pixel a pixel
    %   dades_imatge_2 : llargada de la línia sols posicions determiandes (error Fiji)
    %   BW_draw : imatge BW (esqueletonitzada?)
    %   porta_window_drawline : determinació si s'ha executat o no la funció correctament.

    % imshow(BW_draw)

    if porta_window_drawline
        
        % main_table_actual_last_modiftable - Taula amb els objectes.
        
        % Generarem un nou 'no_modified_object_modificada' i l'incorporarem
        % a 'main_table_actual_last_modiftable'.
        
        
%        no_modified_object.Properties.VariableNames
%          {'IsCeleg'}    {'NomWorm'}    {'Length'}    {'Bounding'}    {'Modifs'}    {'Indx_skel'}    {'Indx_BW'}    {'WidthValues'}    {'Resolution'}    {'Morph_circularity'}
%         {'Morph_majoraxis'}    {'Morph_area'}


        % ___Definició propietats objecte BW___
        % Nota: veure creacio_S_textscan_modifs
        
        BW_indx_string = strjoin(string(find(BW_draw)), ";");
        % Nota: BW_indx_string és index de BW objecte i BW skeleton.
        
        % Resolucio img
        resol_string = strjoin(string([size(BW_draw, 1), size(BW_draw, 2)]), ";");
        BWwidth_string = "Drawedline";

        % Propietats morfologiques
        BB = regionprops(BW_draw, 'BoundingBox', "Circularity", 'MajorAxisLength', 'Area');
        BB_string = strjoin(string(BB.BoundingBox), ";");
        morph_prop_circularity = BB.Circularity;
        morph_prop_majoraxis = BB.MajorAxisLength;
        morph_prop_area = BB.Area;
        
        modifs_string = "Modifs_string";

        % dades_imatge - distancia entre pixels
        % dades_imatge_punts - distancia entre pixels cada X punts (correcció de l'error manual)
        
        % _Cell de dades_
        cell_dades_totals = {"yes", string(app.img_original_nomLabel.Text), string(dades_imatge), BB_string, modifs_string, ...
                BW_indx_string, BW_indx_string, BWwidth_string, resol_string, morph_prop_circularity, morph_prop_majoraxis, morph_prop_area};
%         cell_dades_totals = {"yes", string(app.img_original_nomLabel.Text), string(dades_imatge_punts), BB_string, modifs_string, ...
%                 BW_indx_string, BW_indx_string, BWwidth_string, resol_string, morph_prop_circularity, morph_prop_majoraxis, morph_prop_area};

        variables_noms = [ "IsCeleg", "NomWorm", "Length", "Bounding", "Modifs", ...
            "Indx_skel", "Indx_BW", "WidthValues", "Resolution", "Morph_circularity", "Morph_majoraxis", "Morph_area"];

        % _Creació com a taula_
        S_textscan_table_row = cell2table(cell_dades_totals, 'VariableNames', variables_noms);

        
        % __Incorporació a taula dades__

        % Incorporem a la taula principal
        
        if isempty(main_table_actual_last)
            % Si no hi ha anotacións
            
            % Creem la taula (main_table_actual_last_new) i la incorporem
                % _Creació i incorporació de la taula nova_
            main_table_actual_last_new = table(string(app.img_original_nomLabel.Text), 1, {S_textscan_table_row}, 'VariableNames', {'Image', 'nModif', 'ModifTable'});

            
        else
            % Si hi ha anotacións

            % Passem la taula de l'objecte, a la taula dels objectes.
            main_table_actual_last_modiftable = [main_table_actual_last_modiftable; S_textscan_table_row];
            
            main_table_actual_last_new = main_table_actual_last;
            main_table_actual_last_new.nModif = main_table_actual_last_new.nModif+1; % Sumem 1 a la modif actual
            main_table_actual_last_new.ModifTable = {main_table_actual_last_modiftable}; % Actualitzem la taula dels objectes modificats

        end
        
        % Incorporem a la taula_main
        app.table_main_sel = [app.table_main_sel; main_table_actual_last_new];

        
        
        % Grafiquem ultim objecte
        app_interf_determinar_ultim_object(app, BB.BoundingBox, "thick")

    end



% FINAL FUNCIÓ

end