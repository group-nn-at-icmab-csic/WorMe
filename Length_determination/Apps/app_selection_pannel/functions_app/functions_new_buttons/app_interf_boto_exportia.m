function app_interf_boto_exportia(app)

% Botó Exportar dades IA 

% INICI FUNCIÓ

% Exporta les dades per a guardar per a models de Deep Learning
           
            % Nota: de moment s'exporta tot.

            array_portes = [true, true, true, true, true, true, true];

            % ___Carpeta guardar les dades___
            [predef_folder_carpeta] = predef_carpeta_import_export(app, "ia", "read");

            % dir_main_save_folder = uigetdir(predef_folder_carpeta);

            % Carpeta imatges (sols per guardar el path d'aquestes)
            dir_img_originals = app.dir_imgs_orig;
            str_folder_t = strsplit(dir_img_originals, "\"); str_folder = str_folder_t{end};
            [dir_main_save_folder, indx_decisio] = determine_path_zip(predef_folder_carpeta, str_folder);

            if indx_decisio
%             % Si es selecciona algo:
%             if ~isequal(dir_main_save_folder, 0)

                % Guardem la carpeta
                dir_split = strsplit(dir_main_save_folder, "\");
                carpeta_to_save = strjoin(dir_split(1:end-1), "\");                
                [~] = predef_carpeta_import_export(app, "ia", "write", carpeta_to_save);
    

    
                % _LECTURA DE DADES_
                tipus_lectura = "%s%s%s%s%s%s%s%s%s";
                variable_names = {'IsCeleg', 'NomWorm', 'Length', 'Bounding', 'Modifs', 'Indx_skel', 'Indx_BW', 'WidthValues', 'Resolution'};
                [S_textscan_table] = read_data(strcat(app.appv_dir_output, "\main_data_analysis.txt"), tipus_lectura, "$", variable_names);
                
                % Exportació de les dades
                % dir_img_originals : 'C:\Users\jllobet\Desktop\Length determination v2_15\_Imatges exemple\Amanda_Controls\C_24'
                % dir_main_save_folder : 'C:\Users\jllobet\Downloads'
                export_IA_data(S_textscan_table, dir_img_originals, dir_main_save_folder, array_portes);

            end

            % Actualitzem figura per capacitar shortkey
            figure(app.UIFigure)                

% FINAL FUNCIÓ

end