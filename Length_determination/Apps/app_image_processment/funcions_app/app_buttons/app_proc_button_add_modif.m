function app_proc_button_add_modif(app)

% In app_image_processing App, the button of adding a modification (NovamodificaciButtonPushed).
%
%
% See also
% app_image_processment


% START OF THE FUNCTION

    % Contar nombre d'arxius de modificacions ('Modif_img') amb el mateix nom:
    total_items = [app.ModificacionstemporalsListBox.Items, app.ModificacionsguardadesListBox.Items];
    
    n_Modif_img = 1; % Nombre de noms que contenen 'n_Modif_img'.
    for cada_item = total_items
        item_n = cada_item{1}; item_n_nom = separar_puntfile(item_n);
        if contains(item_n_nom, 'Modif_img'); n_Modif_img = n_Modif_img +1; end % Si conté el nom de modificació
    end
    
    
    
    nom_correcte = true; % Contador while
    while nom_correcte
        
        % Obrir cuadre dialeg per entrada nom arxiu
        prompt = "Nom de l'arxiu:";
        dlgtitle = 'Input';
        dims = [1 35];
        % Definim el input. El nom canvia si el valor és inferior a
        % 10 (01, 02, 03...) per a aconseguir un ordre correcte.
        
        % Generem nom
        if n_Modif_img < 10
                definput = {char(strcat("Modif_img", "_0", string(n_Modif_img)))};
            else
                definput = {char(strcat("Modif_img", "_", string(n_Modif_img)))};                    
        end
        
        % Si coincideix, suma 1
        % Nota: això es fa per si no hi ha Modif_img_01 i si
        % Modif_img_02, no es crei un Modif_img_02 i resulti que sí existeix (bastant engorrós).
        while ismember(strcat(definput, ".txt"), total_items)
            n_Modif_img = n_Modif_img +1;
            if n_Modif_img < 10
                definput = {char(strcat("Modif_img", "_0", string(n_Modif_img)))};
            else
                definput = {char(strcat("Modif_img", "_", string(n_Modif_img)))};                    
            end
        end
        answer_resposta = inputdlg(prompt,dlgtitle,dims,definput);

        % Si el quadre de diàleg no es tanca, o no és vuit:
        if ~isempty(answer_resposta) && answer_resposta ~= ""
            % Si existeixen arxius amb el mateix nom
            [llistat_string_im] = [...
                llegir_arxius_tipologia("Results_out\Internal_code_files\Image_processing_settings\temporals\", ".txt"), ...
                llegir_arxius_tipologia("Results_out\Internal_code_files\Image_processing_settings\", ".txt")];
            
            splitat_arxius = split(llistat_string_im, ".txt");
            

            si_no_son_iguals = true; % Si aquest no varia, significa que no hi ha arxius iguals.
            for cada_arxiu = 1:length(llistat_string_im)
                if splitat_arxius(cada_arxiu) == answer_resposta
                    si_no_son_iguals = false;
                end
            end

            % Si existeixen o no
            if si_no_son_iguals
                % Es crea l'arxiu nou
                nom_arxiu_guardar = strcat("Results_out\Internal_code_files\Image_processing_settings\temporals\",answer_resposta,".txt");
                txt_seg(nom_arxiu_guardar, "", ";", "nou", "blanc") % seguiment config.
                
                nom_correcte = false;
            else
                waitfor(msgbox('El nom ja existeix', 'Error','error'));
            end

            % El nom de l'arxiu topologicament és correcte
            write_arxiu_txt = true;

        % Si es tanca el quadre de diàleg o es dona un nom vuit:
        else
            nom_correcte = false;

            % El nom de l'arxiu topologicament és incorrecte, i no
            % es guardarà
            write_arxiu_txt = false;
        end
        
    
    end
    
    
    if write_arxiu_txt
        % Actualització List box
        [llistat_string_im] = llegir_arxius_tipologia("Results_out\Internal_code_files\Image_processing_settings\temporals\", ".txt");
        app.ModificacionstemporalsListBox.Items = llistat_string_im;
    
        resposta_answer_list = strcat(answer_resposta, ".txt");
        app.ModificacionstemporalsListBox.Value = resposta_answer_list;

        % Relatius:
        % Desseleccionem Modificacions guardades:
        app.ModificacionsguardadesListBox.Value = {};
        
        app.ImatgeLabel.Text = resposta_answer_list;


        % __Printar en Modificacions__
        app.Modificacions_actuals.Value = "";
        
        
        % MOSTREM IMATGE ORIGINAL
        fullFileName = app.vapp_ruta_img_origin;
        imatge_original = imread_ifgrey(fullFileName);
        app.Image.ImageSource = imatge_original;


        [~, tipus_im_modif] = app_proc_obtenir_array_modificacions(app);
        app_proc_desact_act_buttons(app, tipus_im_modif)
    end



    % Desactivació botóns específics:
    app.ModificarButton.Visible = 'off';


% END OF THE FUNCTION


end