function app_proc_button_return_modif(app)

% In app_image_processing App, the button of return to the last modification.
%
% The button make a "back" to the modification, deleting last modification done.
%
%
% See also
% app_image_processment


% START OF THE FUNCTION
    % "Back" button, which returns the modification.

    % See button % "imadjust" button
    % Save to text file and print on screen
    % We take the selected text from the ListBox, according to the type of modification selected (temporary or saved)
    if ~isempty(app.ModificacionstemporalsListBox.Value)
        value_listbox = app.ModificacionstemporalsListBox.Value;
        field_set = strcat("Results_out\Internal_code_files\Image_processing_settings\temporals\", string(value_listbox));
    % If pre-selected in saved
    elseif ~isempty(app.ModificacionsguardadesListBox.Value)
        value_listbox = app.ModificacionsguardadesListBox.Value;
        % Read file and display in Modificacions Label
        field_set = strcat("Results_out\Internal_code_files\Image_processing_settings\", string(value_listbox));
    end

    % Delete the last line of the text:
    % Note: Code adapted exclusively for combination with f'txt_seg'
    [array_processos, ~] = read_text_delimiters(field_set, ";");
    
    [files_ar, ~] = size(array_processos);
    
    delete(field_set)
    txt_seg(field_set, "", ";", "nou", "blanc") % tracking config.
    for cada_proces = 2:(files_ar-1)
        % Get each process
        proces_print = array_processos{cada_proces, 2};
        txt_seg(field_set, proces_print, ";")
    end 
    
    
    % IMAGE READING BUTTON
    fullFileName = app.vapp_ruta_img_origin;
    imatge_original = imread_ifgrey(fullFileName);            
    

    % __Print in Modificacions__
    % Get array reading from text document and print it            
    [array_sortida_modifs, ~] = read_text_delimiters(field_set, ";");
    [x_rows_arrayproc, ~] = size(array_sortida_modifs);
    % If there are no modifications:
    if x_rows_arrayproc < 2
        % Plotting
        app.Image.ImageSource = imatge_original;
        
        % Get number of binary objects:
        app.num_objectes_binarisLabel.Text = "Indef.";
        
        app.Modificacions_actuals.Value = "";
        array_processaments = {};
    % If there are modifications
    
    else
        cell_cont = array_sortida_modifs(2:end, 2);
        array_processaments = cell2array_own(cell_cont);
        % Show the modifications
        app.Modificacions_actuals.Value = array_processaments';
        
        % IMAGE MODIFICATION
        % Image processing
        [BW_final, ~] = processment_img_list(imatge_original, array_processaments);
        
        % Plotting
        [imatge_3D_sortida] = graph_rgbgraybw_image(BW_final);
        app.Image.ImageSource = imatge_3D_sortida;
        
        % Get number of binary objects:
        app.num_objectes_binarisLabel.Text = obtain_num_BW(BW_final);                         
    
    end

    % GET IMAGE TYPOLOGY
    if isempty(array_processaments)
        % The image is rgb
        tipus_im_modif = "rgb";
        % 
    else
        % Get the last modification
        ultima_modificacio = array_processaments(end);
        
        % Get its name
        [tipus_im_modif, ~] = obtain_list_typology(ultima_modificacio);
    end
    
    
    % _Show clock image_
    app.Image2.Visible = 'off';
    
    
    
    % DISABLE/ENABLE IMAGE MODIFICATION BUTTONS ACCORDING TO
    % IMAGE TYPOLOGY
    app_proc_desact_act_buttons(app, tipus_im_modif)

    

% END OF THE FUNCTION


end