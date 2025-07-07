function app_proc_button_import_modif(app)

% In app_image_processing App, the button of import modifications.
%
% Copy the saved modifications from a defined file.
%
% See also
% app_image_processment


% START OF THE FUNCTION

    % Get the file
    [filename, pathname, porta_uigetfile] = uigetfile({'*.txt'}, 'MultiSelect','on'); % pathname: ruta. filename: cells amb els noms (ex:  {'200120GrowC.txt'}    {'Nota.txt'})


    if porta_uigetfile

        % Si en la selecció hi ha varis arxius:
        if iscell(filename)                
            % Per cada arxiu seleccionat
            for n_cada_file = 1:length(filename)

                % Arxiu a copiar
                arxiu_copiar = strcat(pathname, filename{n_cada_file});
                directori_nou_copiar = strcat("Results_out\Internal_code_files\Image_processing_settings\", filename{n_cada_file});

                % Si l'objecte no existeix:
                if ~ismember(arxiu_copiar, app.ModificacionsguardadesListBox.Items)

                    % Mirem si l'arxiu és una modificació.
                    [porta_lect_correct] = app_proc_probar_modifs(app, arxiu_copiar);

                    if porta_lect_correct
                        % Copiem l'arxiu
                        copyfile(arxiu_copiar, directori_nou_copiar)
                    else
                        msgbox(strcat("The file", filename{n_cada_file}, ", have not correct modifications."))
                    end
                else
                    msgbox(strcat("The name of the file", filename{n_cada_file}, ", already exist"))
                end
            end

        % Si en la selecció sols hi ha un arxiu:
        elseif ischar(filename)

            % Arxiu a copiar
            arxiu_copiar = strcat(pathname, filename);
            directori_nou_copiar = strcat("Results_out\Internal_code_files\Image_processing_settings\", filename);

            % Si l'objecte no existeix:
            if ~ismember(arxiu_copiar, app.ModificacionsguardadesListBox.Items)

                % Mirem si l'arxiu és una modificació.
                [porta_lect_correct] = app_proc_probar_modifs(app, arxiu_copiar);

                if porta_lect_correct
                    % Copiem l'arxiu
                    copyfile(arxiu_copiar, directori_nou_copiar)
                else
                    msgbox(strcat("The file", filename, ", have not correct modifications."))
                end
            else
                msgbox(strcat("The name of the file", filename, ", already exist"))
            end

            

        % Fallo
        else
            msgbox("Error in import modification", "Error", "error")
        end



    else
            disp("UIGetfile cancelled in Import modification")
    end

    % Actualitzar modificacions
    
    % Llegir arxius Modificacions guardades
    myFolder_input = "Results_out\Internal_code_files\Image_processing_settings\";
    patro_tipus_image = ".txt";
    [llistat_string_im] = llegir_arxius_tipologia(myFolder_input, patro_tipus_image);
    
    app.ModificacionsguardadesListBox.Items = llistat_string_im;
    
    
    % Automatització Drop Roll Modificacions temporals
    myFolder_input = "Results_out\Internal_code_files\Image_processing_settings\temporals\";
    patro_tipus_image = ".txt";
    [llistat_string_im] = llegir_arxius_tipologia(myFolder_input, patro_tipus_image);
                
    app.ModificacionstemporalsListBox.Items = llistat_string_im;


% END OF THE FUNCTION


end