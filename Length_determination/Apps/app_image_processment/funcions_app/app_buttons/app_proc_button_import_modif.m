function app_proc_button_import_modif(app)

% In app_image_processing App, the button of import modifications.
%
% Copy the saved modifications from a defined file.
%
% See also
% app_image_processment


% START OF THE FUNCTION
    % Get the file
    [filename, pathname, porta_uigetfile] = uigetfile({'*.txt'}, 'MultiSelect','on'); % pathname: path. filename: cells with the names (ex:  {'200120GrowC.txt'}    {'Nota.txt'})

    if porta_uigetfile

        % If the selection has multiple files:
        if iscell(filename)                
            % For each selected file
            for n_cada_file = 1:length(filename)

                % File to copy
                arxiu_copiar = strcat(pathname, filename{n_cada_file});
                directori_nou_copiar = strcat("Results_out\Internal_code_files\Image_processing_settings\", filename{n_cada_file});

                % If the object does not exist:
                if ~ismember(arxiu_copiar, app.ModificacionsguardadesListBox.Items)

                    % Check if the file is a modification.
                    [porta_lect_correct] = app_proc_probar_modifs(app, arxiu_copiar);

                    if porta_lect_correct
                        % Copy the file
                        copyfile(arxiu_copiar, directori_nou_copiar)
                    else
                        msgbox(strcat("The file", filename{n_cada_file}, ", have not correct modifications."))
                    end
                else
                    msgbox(strcat("The name of the file", filename{n_cada_file}, ", already exist"))
                end
            end

        % If the selection is only one file:
        elseif ischar(filename)

            % File to copy
            arxiu_copiar = strcat(pathname, filename);
            directori_nou_copiar = strcat("Results_out\Internal_code_files\Image_processing_settings\", filename);

            % If the object does not exist:
            if ~ismember(arxiu_copiar, app.ModificacionsguardadesListBox.Items)

                % Check if the file is a modification.
                [porta_lect_correct] = app_proc_probar_modifs(app, arxiu_copiar);

                if porta_lect_correct
                    % Copy the file
                    copyfile(arxiu_copiar, directori_nou_copiar)
                else
                    msgbox(strcat("The file", filename, ", have not correct modifications."))
                end
            else
                msgbox(strcat("The name of the file", filename, ", already exist"))
            end

        % Failure
        else
            msgbox("Error in import modification", "Error", "error")
        end

    else
            disp("UIGetfile cancelled in Import modification")
    end

    % Update modifications
    
    % Read saved modifications files
    myFolder_input = "Results_out\Internal_code_files\Image_processing_settings\";
    patro_tipus_image = ".txt";
    [llistat_string_im] = read_files_typology(myFolder_input, patro_tipus_image);
    
    app.ModificacionsguardadesListBox.Items = llistat_string_im;
    
    
    % Automate Drop Roll Temporary Modifications
    myFolder_input = "Results_out\Internal_code_files\Image_processing_settings\temporals\";
    patro_tipus_image = ".txt";
    [llistat_string_im] = read_files_typology(myFolder_input, patro_tipus_image);
                
    app.ModificacionstemporalsListBox.Items = llistat_string_im;



% END OF THE FUNCTION


end