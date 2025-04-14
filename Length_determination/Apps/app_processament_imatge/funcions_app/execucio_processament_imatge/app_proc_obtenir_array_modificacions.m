function [array_processaments, tipus_im_modif] = app_proc_obtenir_array_modificacions(app)

% Obté l'array de processaments i el tipus d'imatge, per al seu ús
% posterior en la app.


% INICI FUNCIO


    if ~isempty(app.ModificacionstemporalsListBox.Value)
        value_listbox = app.ModificacionstemporalsListBox.Value;                
        app.ImatgeLabel.Text = string(value_listbox);                
        % Llegir arxiu i mostrar en Label Modificacions
        field_set = strcat("Results_out\Internal_code_files\Image_processing_settings\temporals\", string(value_listbox));
    else
        value_listbox = app.ModificacionsguardadesListBox.Value;                
        app.ImatgeLabel.Text = string(value_listbox);                
        field_set = strcat("Results_out\Internal_code_files\Image_processing_settings\", string(value_listbox));
    end

    % obtneim l'array de la lectura del document de text i el printem
    [array_sortida_modifs, ~] = llegir_text_delimitadors(field_set, ";");

    % Operem
    cell_cont = array_sortida_modifs(2:end, 2);
    array_processaments = cell2array_josep(cell_cont);
    if ~isempty(array_processaments)
        app.Modificacions_actuals.Value = array_processaments';
    else
        app.Modificacions_actuals.Value = "";
    end



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



% FINAL FUNCIO


end