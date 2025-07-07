function app_proc_button_analyse(app)

% In app_image_processing App, the button of Analyse (main).
%
%
% See also
% app_image_processment


% START OF THE FUNCTION

    % Tancament del loop
    app.vapp_tancament_loop = "tancar";
    
    % Fa una copia de la modificacio a la ubicacio en es llegirà en
    % el programa.
    

    dir_save_txt = app.vapp_carpeta_output;
    
    if ~isempty(app.ModificacionstemporalsListBox.Value)
        value_listbox = app.ModificacionstemporalsListBox.Value;
        field_set = strcat("Results_out\Internal_code_files\Image_processing_settings\temporals\", string(value_listbox));
    % Si es pre-selecciona en guardats
    elseif ~isempty(app.ModificacionsguardadesListBox.Value)
        value_listbox = app.ModificacionsguardadesListBox.Value;
        % Llegir arxiu i mostrar en Label Modificacions
        field_set = strcat("Results_out\Internal_code_files\Image_processing_settings\", string(value_listbox));
    end
    
    
    copyfile(field_set, strcat(dir_save_txt, "\Processment_parameters\", value_listbox)); % <- temporal el strcat

    
    % _Preselecció modificació_
    % Fer que es guardi el nom de l'arxiu, de manera que la proxima
    % vegada que s'executi el programa, sigui aquesta modificació
    % la que es pre-seleccioni de foroma automàtica.
    % value_listbox % '48_C.txt'

    % _Write arxiu predefinit_
    % Guardem el valor de la modificació en un txt, per a llegir-lo
    % quan es torni a obrir el programa
    array_write_folder = ["Folder", value_listbox];
    write_text_array("Results_out\Internal_code_files\predefined_modif.txt", array_write_folder, ";");

    
    
    %close force 
    % En teoria el close force hauria d'anar aqui, però el loop del
    % StartupFcn (while) si es fa tancar la GUI aquest 'peta' i fa petar el prorgama.
    % D'aquesta manera, es posa close force fora del while, i es
    % surt d'aquest amb el botó analyse.

% END OF THE FUNCTION


end