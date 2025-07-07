function app_proc_button_analyse(app)

% In app_image_processing App, the button of Analyse (main).
%
%
% See also
% app_image_processment


% START OF THE FUNCTION
    % Loop closure
    app.vapp_tancament_loop = "tancar";
    
    % Makes a copy of the modification in the location
    % from which it will be read in the program.
    

    dir_save_txt = app.vapp_carpeta_output;
    
    if ~isempty(app.ModificacionstemporalsListBox.Value)
        value_listbox = app.ModificacionstemporalsListBox.Value;
        field_set = strcat("Results_out\Internal_code_files\Image_processing_settings\temporals\", string(value_listbox));
    % If it is pre-selected in saved
    elseif ~isempty(app.ModificacionsguardadesListBox.Value)
        value_listbox = app.ModificacionsguardadesListBox.Value;
        % Read file and display in Modificacions Label
        field_set = strcat("Results_out\Internal_code_files\Image_processing_settings\", string(value_listbox));
    end
    
    
    copyfile(field_set, strcat(dir_save_txt, "\Processment_parameters\", value_listbox)); % <- temporal the strcat

    
    % _Modification pre-selection_
    % Make it so that the filename is saved, so that the next
    % time the program is run, this modification is automatically
    % pre-selected.
    % value_listbox % '48_C.txt'

    % _Write predefined file_
    % We save the value of the modification in a txt file, to read it
    % when the program is reopened
    array_write_folder = ["Folder", value_listbox];
    write_text_array("Results_out\Internal_code_files\predefined_modif.txt", array_write_folder, ";");

    
    
    % close force 
    % In theory, close force should go here, but the loop in
    % StartupFcn (while) crashes if the GUI is closed here and
    % crashes the program.
    % This way, close force is placed outside the while, and we
    % exit it with the analyse button.

% END OF THE FUNCTION


end