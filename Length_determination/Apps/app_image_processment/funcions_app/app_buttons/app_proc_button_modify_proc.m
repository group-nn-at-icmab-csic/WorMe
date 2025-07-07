function app_proc_button_modify_proc(app)

% In app_image_processing App, the button of modify the current image processment (ModificarButtonPushed).
%
% Button for to modify the saved modification.
% The modification turns to be in temporal modification, in order to be operated in it. 
%
% See also
% app_image_processment


% START OF THE FUNCTION
    
    %item_modificar = app.ModificacionsguardadesListBox.Value
        % Simply open the buttons so that its modification is operable.
    
    value_listbox = app.ModificacionsguardadesListBox.Value;
    app.ImatgeLabel.Text = string(value_listbox);
    
    % Read file and display in Modifications Label
    field_set = strcat("Results_out\Internal_code_files\Image_processing_settings\", string(value_listbox));

    % Obtain the array from reading the text document and print it
    [array_sortida_modifs, ~] = llegir_text_delimitadors(field_set, ";");

                
    % READ IMAGE MODIFICATIONS TYPOLOGY
    cell_cont = array_sortida_modifs(2:end, 2);
    array_processaments = cell2array_own(cell_cont);

    % Obtain the image typology
    if isempty(array_processaments)
        % The image is rgb
        tipus_im_modif = "rgb";
    else
        % Obtain the last modification
        ultima_modificacio = array_processaments(end);
        
        % Obtain its name
        [tipus_im_modif, ~] = obtencio_tipologia_llistat(ultima_modificacio);
    end
    
    % Change buttons
    app_proc_desact_act_buttons(app, tipus_im_modif) 


    
    

    app.ModificarButton.Visible = 'off';

% END OF THE FUNCTION


end