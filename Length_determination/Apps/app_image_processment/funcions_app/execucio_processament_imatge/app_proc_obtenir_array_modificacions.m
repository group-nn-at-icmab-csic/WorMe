function [array_processaments, tipus_im_modif] = app_proc_obtenir_array_modificacions(app)

% Gets the processing array and image type, for later use in the app.


% START OF THE FUNCTION


    if ~isempty(app.ModificacionstemporalsListBox.Value)
        value_listbox = app.ModificacionstemporalsListBox.Value;                
        app.ImatgeLabel.Text = string(value_listbox);                
        % Read file and display in Label Modifications
        field_set = strcat("Results_out\Internal_code_files\Image_processing_settings\temporals\", string(value_listbox));
    else
        value_listbox = app.ModificacionsguardadesListBox.Value;                
        app.ImatgeLabel.Text = string(value_listbox);                
        field_set = strcat("Results_out\Internal_code_files\Image_processing_settings\", string(value_listbox));
    end

    % we obtain the array from reading the text document and print it
    [array_sortida_modifs, ~] = read_text_delimiters(field_set, ";");

    % Operate
    cell_cont = array_sortida_modifs(2:end, 2);
    array_processaments = cell2array_own(cell_cont);
    if ~isempty(array_processaments)
        app.Modificacions_actuals.Value = array_processaments';
    else
        app.Modificacions_actuals.Value = "";
    end



    % We obtain the typology of the image
    if isempty(array_processaments)
        % La imatge és rgb
        tipus_im_modif = "rgb";
    else
        % We get the last modification
        ultima_modificacio = array_processaments(end);
        
        % We get the name of this
        [tipus_im_modif, ~] = obtain_list_typology(ultima_modificacio);
    end          



% FINAL OF THE FUNCTION


end