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
    
    % Simplement obrim els botóns per a que sigui operable la seva
    % modificació.
    
    value_listbox = app.ModificacionsguardadesListBox.Value;
    app.ImatgeLabel.Text = string(value_listbox);
    
    % Llegir arxiu i mostrar en Label Modificacions
    field_set = strcat("Results_out\Internal_code_files\Image_processing_settings\", string(value_listbox));

    % obtneim l'array de la lectura del document de text i el printem
    [array_sortida_modifs, ~] = llegir_text_delimitadors(field_set, ";");


                
    % LECTURA TIPOLOGIA MODIFICACIONS IMATGE
    cell_cont = array_sortida_modifs(2:end, 2);
    array_processaments = cell2array_own(cell_cont);

    % Obtenim tipologia de la imatge
    if isempty(array_processaments)
        % La imatge és rgb
        tipus_im_modif = "rgb";
    else
        % Obtenim la última modificació
        ultima_modificacio = array_processaments(end);
        
        % Obtenim el nom d'aquesta
        [tipus_im_modif, ~] = obtencio_tipologia_llistat(ultima_modificacio);
    end
    
    % Cambiem botóns
    app_proc_desact_act_buttons(app, tipus_im_modif) 

    
    

    app.ModificarButton.Visible = 'off';

% END OF THE FUNCTION


end