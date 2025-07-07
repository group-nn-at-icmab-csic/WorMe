function app_proc_button_add_modif(app)

% In app_image_processing App, the button of adding a modification (NovamodificaciButtonPushed).
%
%
% See also
% app_image_processment


% START OF THE FUNCTION

    % Count number of modification files ('Modif_img') with the same name:
    total_items = [app.ModificacionstemporalsListBox.Items, app.ModificacionsguardadesListBox.Items];
    
    n_Modif_img = 1; % Number of names containing 'n_Modif_img'.
    for cada_item = total_items
        item_n = cada_item{1}; item_n_nom = separar_puntfile(item_n);
        if contains(item_n_nom, 'Modif_img'); n_Modif_img = n_Modif_img +1; end % If it contains the modification name
    end
    
    
    
    nom_correcte = true; % While loop counter
    while nom_correcte
        
        % Open dialog box to enter file name
        prompt = "Nom de l'arxiu:";
        dlgtitle = 'Input';
        dims = [1 35];
        % We define the input. The name changes if the value is below
        % 10 (01, 02, 03...) to ensure proper ordering.
        
        % Generate name
        if n_Modif_img < 10
                definput = {char(strcat("Modif_img", "_0", string(n_Modif_img)))};
            else
                definput = {char(strcat("Modif_img", "_", string(n_Modif_img)))};                    
        end
        
        % If it matches, increment by 1
        % Note: this is done in case there’s no Modif_img_01 but there is
        % Modif_img_02, to avoid creating another Modif_img_02 and ending up with duplicates (quite annoying).
        while ismember(strcat(definput, ".txt"), total_items)
            n_Modif_img = n_Modif_img +1;
            if n_Modif_img < 10
                definput = {char(strcat("Modif_img", "_0", string(n_Modif_img)))};
            else
                definput = {char(strcat("Modif_img", "_", string(n_Modif_img)))};                    
            end
        end
        answer_resposta = inputdlg(prompt,dlgtitle,dims,definput);

        % If the dialog box is not closed, and it’s not empty:
        if ~isempty(answer_resposta) && answer_resposta ~= ""
            % If there are files with the same name
            [llistat_string_im] = [... 
                llegir_arxius_tipologia("Results_out\Internal_code_files\Image_processing_settings\temporals\", ".txt"), ...
                llegir_arxius_tipologia("Results_out\Internal_code_files\Image_processing_settings\", ".txt")];
            
            splitat_arxius = split(llistat_string_im, ".txt");
            

            si_no_son_iguals = true; % If this remains true, it means there are no duplicate files.
            for cada_arxiu = 1:length(llistat_string_im)
                if splitat_arxius(cada_arxiu) == answer_resposta
                    si_no_son_iguals = false;
                end
            end

            % Whether they exist or not
            if si_no_son_iguals
                % The new file is created
                nom_arxiu_guardar = strcat("Results_out\Internal_code_files\Image_processing_settings\temporals\",answer_resposta,".txt");
                txt_seg(nom_arxiu_guardar, "", ";", "nou", "blanc") % tracking config.
                
                nom_correcte = false;
            else
                waitfor(msgbox('El nom ja existeix', 'Error','error'));
            end

            % The file name is topologically correct
            write_arxiu_txt = true;

        % If the dialog box is closed or an empty name is given:
        else
            nom_correcte = false;

            % The file name is topologically incorrect, and
            % it will not be saved
            write_arxiu_txt = false;
        end
        
    
    end
    
    
    if write_arxiu_txt
        % Update List box
        [llistat_string_im] = llegir_arxius_tipologia("Results_out\Internal_code_files\Image_processing_settings\temporals\", ".txt");
        app.ModificacionstemporalsListBox.Items = llistat_string_im;
    
        resposta_answer_list = strcat(answer_resposta, ".txt");
        app.ModificacionstemporalsListBox.Value = resposta_answer_list;

        % Relatives:
        % Deselect saved modifications:
        app.ModificacionsguardadesListBox.Value = {};
        
        app.ImatgeLabel.Text = resposta_answer_list;


        % __Print in Modifications__
        app.Modificacions_actuals.Value = "";
        
        
        % DISPLAY ORIGINAL IMAGE
        fullFileName = app.vapp_ruta_img_origin;
        imatge_original = imread_ifgrey(fullFileName);
        app.Image.ImageSource = imatge_original;


        [~, tipus_im_modif] = app_proc_obtenir_array_modificacions(app);
        app_proc_desact_act_buttons(app, tipus_im_modif)
    end



    % Deactivation of specific buttons:
    app.ModificarButton.Visible = 'off';


% END OF THE FUNCTION


end