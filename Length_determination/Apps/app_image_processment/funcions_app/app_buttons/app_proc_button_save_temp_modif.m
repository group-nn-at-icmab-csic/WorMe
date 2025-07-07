function app_proc_button_save_temp_modif(app)

% In app_image_processing App, the button of saving the current temporal modification (GuardarmodificaciButtonPushed).
%
%
% See also
% app_image_processment


% START OF THE FUNCTION

    arxiu_guardar_copiar = app.ModificacionstemporalsListBox.Value;
    arxiu_borrar = strcat("Results_out\Internal_code_files\Image_processing_settings\temporals\", arxiu_guardar_copiar);
    arxiu_nou_copiar = strcat("Results_out\Internal_code_files\Image_processing_settings\", arxiu_guardar_copiar);
    
    % Mirar si ja existeix. 
    % Si l'objecte no existeix:
    if ~ismember(arxiu_guardar_copiar, app.ModificacionsguardadesListBox.Items)
        movefile(arxiu_borrar, arxiu_nou_copiar);                
        
    else
        msgbox("Name already exist")
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