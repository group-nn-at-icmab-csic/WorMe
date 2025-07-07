function app_proc_button_del_all_temp_modifs(app)

% In app_image_processing App, the button of delete all the temporal modifications.
%
% Delete all the temporal modifications, and makes a new single one.
%
% See also
% app_image_processment


% START OF THE FUNCTION

    % Condicional si hi ha valor agafat:
    if ~isempty(app.ModificacionsguardadesListBox.Value)
        
        answer_del = questdlg('Delete the setting?', ...
                'Delete settings', 'Yes','No', 'No');
        % Handle response
        switch answer_del
            case 'Yes'
                answer_msgebox = 1;
            case 'No'
                answer_msgebox = 0;
        end 
        
        valor_modif_perm = separar_puntfile(app.ModificacionsguardadesListBox.Value); %Valor de la modificació permanent.
        
        
        % Si es diu que sí es vol eliminar, s'executa:
        if answer_msgebox
            
            
            % Es borren tant arxius com imatges temporals
            patrons_imatge = [".txt", ".png"];
            for patro_n = 1:length(patrons_imatge)
                patro_tipus_image = patrons_imatge(patro_n);
                
                if patro_tipus_image == ".txt"
                    myFolder_input = "Results_out\Internal_code_files\Image_processing_settings\";
                elseif patro_tipus_image == ".png"
                    myFolder_input = "Apps\app_image_processment\Internal code files\Image processing settings\settings_imatges\";
                end
               
                string_delete = strcat(myFolder_input, valor_modif_perm, patro_tipus_image);
                delete(string_delete)
                
                
            end
            
%                 % Fem un nou arxiu en blanc
%                 nom_arxiu_guardar = "Apps\app_image_processment\Internal code files\Image processing settings\temporals\setting0.txt";
%                 txt_seg(nom_arxiu_guardar, "", ";", "nou", "blanc") % seguiment config.
%     
%                 
            % Actualitzem elements:
            [llistat_string_im] = llegir_arxius_tipologia("Results_out\Internal_code_files\Image_processing_settings\", ".txt");
            app.ModificacionsguardadesListBox.Items = llistat_string_im;
            
            % Es fa com si s'apretés el botó 'Original'
            app.ButtonVideoTutorialPushed

        end



    end

% END OF THE FUNCTION


end