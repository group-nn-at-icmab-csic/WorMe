function app_interf_button_export(app)

% Botó exportar a Excel.

% INICI FUNCIÓ

            app.Image6.Visible = 'on';

            % Definim carpeta dades
            dir_img_originals = app.dir_imgs_orig;
            
            % Nom carpeta:
            dir_img_originals_split_t = split(dir_img_originals, "\");
            nom_dir_img_originals = dir_img_originals_split_t{end}; % Funciona
            
            
            % _LECTURA DE DADES_
            tipus_lectura = "%s%s%s%s%s%s%s%s%s";
            variable_names = {'IsCeleg', 'NomWorm', 'Length', 'Bounding', 'Modifs', 'Indx_skel', 'Indx_BW', 'WidthValues', 'Resolution'};
            [S_textscan_table] = read_data(strcat(app.appv_dir_output, "\main_data_analysis.txt"), tipus_lectura, "$", variable_names);

            % [S_textscan_table] = app_interf_llegir_main_dades(dir_output);
            
            % Variables: 
            % ["IsCeleg","NomWorm", "Length", "Bounding", "Modifs", "Indx_skel", "Indx_BW"]

            % Filtrem la taula
            S_textscan_table_yes = S_textscan_table(S_textscan_table.IsCeleg == "yes", :);
            

            % Si es marca que es vol guardar les dades sense la correcció manual:
            if app.ExportnoncorrectedmanualerrordataCheckBox.Value
                % S'obtenen les distancies per totes les imatges esqueletonitzades.
                % S_textscan_table_yes
                
                % Per cada linia, obtindrem el valor de la llargada amb la
                % correcció de la mateixa.
                length_correction = [];
                for n_row = 1:height(S_textscan_table_yes)
                    % Obtenció de l'esquelet
                    [BW_skel] = create_BW_indx(appf_split_strindex(S_textscan_table_yes(n_row,:).Indx_skel), appf_split_strindex(S_textscan_table_yes(n_row,:).Resolution)');

                    [dades_imatge_row, dades_imatge_manual_corrected] = obtain_distances_BWskel(BW_skel, app.appv_escala_img, 5);                    
                    
                    
                    length_correction = [length_correction; dades_imatge_manual_corrected];
                    
                end

                                
                % Definim nova taula, amb Noms i Llargada
                S_textscan_table_length = table(S_textscan_table_yes.NomWorm, double(S_textscan_table_yes.Length), round(double(length_correction), 4), ...
                    'VariableNames', ["ImageName", "Length", "Length_corrected"]);

            else
                
                % Definim nova taula, amb Noms i Llargada
                S_textscan_table_length = table(S_textscan_table_yes.NomWorm, double(S_textscan_table_yes.Length), ...
                    'VariableNames', ["ImageName", "Length"]);
            end


            % GUARDAR ARXIU

            [predef_folder_carpeta] = predef_carpeta_import_export(app, "excel", "read");

            filter = {'*.xlsx';'*.xls';'*.csv';'*.txt'};
            % Antic: [file_export, path_export, indx_decisio_t] = uiputfile(filter, "Save the file", strcat(nom_dir_img_originals, '.xlsx'));
            [file_export, path_export, indx_decisio_t] = uiputfile(filter, "Save the file", strcat(predef_folder_carpeta, nom_dir_img_originals, '.xlsx'));            
            nom_arxiu_complert = strcat(path_export, file_export);
                
            % indx_decisio_t : és 1 si es determina un nom, sigui sobreescrit
            %                o no, i és 0 si s'ha cancelat.

            indx_decisio = logical(indx_decisio_t);

            
            % Si s'ha donat un nom, i no s'ha cancelat l'aplicatiu:
            if indx_decisio
                % Si hi ha un arxiu amb el mateix nom, i s'ha indicat que
                % es sobrescriu (indx_decisio = 1), aquest s'elimina:
                if isfile(nom_arxiu_complert)
                    % disp("Existeeix")
                    delete(nom_arxiu_complert)
                    % Nota: esborrem l'arxiu perquè si es fa writetable a
                    % un arxiu existent, sols es sobrescriuen les dades, i
                    % no es fa un arxiu nou.

                end

                % Exportem l'arxiu
                % writetable(S_textscan_table_length, nom_arxiu_complert, "WriteRowNames", true)
                writetable(S_textscan_table_length, nom_arxiu_complert, "WriteVariableNames", true)


                % Guardem la ruta de la carpeta
                [~] = predef_carpeta_import_export(app, "excel", "write", path_export);

            end
            

            app.Image6.Visible = 'off';

    % Actualitzat figura per capacitar shortkey
    figure(app.UIFigure)
            
            
                % Nota que es fa sol el quadre de diàleg si hi ha un arxiu que coincideix amb el nom.
                %close % Si es queda estancat, el close pot servir.
%             catch
%             end
            

% FINAL FUNCIÓ



            % Desbloqueig botó per múltiple-pulsació
%             app.ExportButton.Enable = 'on';            
            

%

end