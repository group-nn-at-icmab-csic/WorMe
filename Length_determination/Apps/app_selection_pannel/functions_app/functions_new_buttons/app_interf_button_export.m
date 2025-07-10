function app_interf_button_export(app)

% Export to Excel Button.

% START OF FUNCTION

            app.Image6.Visible = 'on';

            % Define data folder
            dir_img_originals = app.dir_imgs_orig;
            
            % Folder name:
            dir_img_originals_split_t = split(dir_img_originals, "\");
            nom_dir_img_originals = dir_img_originals_split_t{end}; % Works
            
            
            % _DATA READING_
            tipus_lectura = "%s%s%s%s%s%s%s%s%s";
            variable_names = {'IsCeleg', 'NomWorm', 'Length', 'Bounding', 'Modifs', 'Indx_skel', 'Indx_BW', 'WidthValues', 'Resolution'};
            [S_textscan_table] = read_data(strcat(app.appv_dir_output, "\main_data_analysis.txt"), tipus_lectura, "$", variable_names);

            % [S_textscan_table] = app_interf_llegir_main_dades(dir_output);
            
            % Variables: 
            % ["IsCeleg","NomWorm", "Length", "Bounding", "Modifs", "Indx_skel", "Indx_BW"]

            % Filter the table
            S_textscan_table_yes = S_textscan_table(S_textscan_table.IsCeleg == "yes", :);
            

            % If it is marked to save data without manual correction:
            if app.ExportnoncorrectedmanualerrordataCheckBox.Value
                % Distances are obtained for all skeletonized images.
                % S_textscan_table_yes
                
                % For each row, obtain the length value with the correction.
                length_correction = [];
                for n_row = 1:height(S_textscan_table_yes)
                    % Obtain the skeleton
                    [BW_skel] = create_BW_indx(appf_split_strindex(S_textscan_table_yes(n_row,:).Indx_skel), appf_split_strindex(S_textscan_table_yes(n_row,:).Resolution)');

                    [dades_imatge_row, dades_imatge_manual_corrected] = obtain_distances_BWskel(BW_skel, app.appv_escala_img, 5);                    
                    
                    
                    length_correction = [length_correction; dades_imatge_manual_corrected];
                    
                end

                                
                % Define new table with Names and Length
                S_textscan_table_length = table(S_textscan_table_yes.NomWorm, double(S_textscan_table_yes.Length), round(double(length_correction), 4), ...
                    'VariableNames', ["ImageName", "Length", "Length_corrected"]);

            else
                
                % Define new table with Names and Length
                S_textscan_table_length = table(S_textscan_table_yes.NomWorm, double(S_textscan_table_yes.Length), ...
                    'VariableNames', ["ImageName", "Length"]);
            end


            % SAVE FILE

            [predef_folder_carpeta] = predef_carpeta_import_export(app, "excel", "read");

            filter = {'*.xlsx';'*.xls';'*.csv';'*.txt'};
            % Old: [file_export, path_export, indx_decisio_t] = uiputfile(filter, "Save the file", strcat(nom_dir_img_originals, '.xlsx'));
            [file_export, path_export, indx_decisio_t] = uiputfile(filter, "Save the file", strcat(predef_folder_carpeta, nom_dir_img_originals, '.xlsx'));            
            nom_arxiu_complert = strcat(path_export, file_export);
                
            % indx_decisio_t : is 1 if a name is given (whether overwriting or not), 0 if cancelled.

            indx_decisio = logical(indx_decisio_t);

            
            % If a name is given and not cancelled:
            if indx_decisio
                % If a file with the same name exists and overwrite is indicated (indx_decisio = 1), delete it:
                if isfile(nom_arxiu_complert)
                    % disp("Exists")
                    delete(nom_arxiu_complert)
                    % Note: the file is deleted because writetable on an existing file only overwrites data, and doesn't create a new file.

                end

                % Export the file
                % writetable(S_textscan_table_length, nom_arxiu_complert, "WriteRowNames", true)
                writetable(S_textscan_table_length, nom_arxiu_complert, "WriteVariableNames", true)


                % Save the folder path
                [~] = predef_carpeta_import_export(app, "excel", "write", path_export);

            end
            

            app.Image6.Visible = 'off';

    % Refresh figure to enable shortkey
    figure(app.UIFigure)
            
    
                % Note: the dialog box only appears if there is a file that matches the name.
                %close % If it gets stuck, the close may help.
%             catch
%             end
            

% END OF FUNCTION


end