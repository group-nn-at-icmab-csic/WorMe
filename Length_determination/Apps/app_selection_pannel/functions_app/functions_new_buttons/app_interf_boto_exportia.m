function app_interf_boto_exportia(app)

% AI Data Export Button

% START OF FUNCTION

% Exports data to save for Deep Learning models
           
            % Note: currently exports everything.

            array_ports = [true, true, true, true, true, true, true];

            % ___Folder to save data___
            [predef_folder_folder] = predef_carpeta_import_export(app, "ia", "read");

            % dir_main_save_folder = uigetdir(predef_folder_folder);

            % Images folder (only to save the path of these)
            dir_img_originals = app.dir_imgs_orig;
            str_folder_t = strsplit(dir_img_originals, "\"); str_folder = str_folder_t{end};
            [dir_main_save_folder, indx_decision] = determine_path_zip(predef_folder_folder, str_folder);

            if indx_decision
%             % If something is selected:
%             if ~isequal(dir_main_save_folder, 0)

                % Save the folder
                dir_split = strsplit(dir_main_save_folder, "\");
                folder_to_save = strjoin(dir_split(1:end-1), "\");                
                [~] = predef_carpeta_import_export(app, "ia", "write", folder_to_save);
    

    
                % _DATA READING_
                read_type = "%s%s%s%s%s%s%s%s%s";
                variable_names = {'IsCeleg', 'NomWorm', 'Length', 'Bounding', 'Modifs', 'Indx_skel', 'Indx_BW', 'WidthValues', 'Resolution'};
                [S_textscan_table] = read_data(strcat(app.appv_dir_output, "\main_data_analysis.txt"), read_type, "$", variable_names);
                
                % Export data
                % dir_img_originals : 'C:\Users\jllobet\Desktop\Length determination v2_15\_Imatges exemple\Amanda_Controls\C_24'
                % dir_main_save_folder : 'C:\Users\jllobet\Downloads'
                export_IA_data(S_textscan_table, dir_img_originals, dir_main_save_folder, array_ports);

            end

            % Refresh figure to enable shortkey
            figure(app.UIFigure)                 

% END OF FUNCTION


end