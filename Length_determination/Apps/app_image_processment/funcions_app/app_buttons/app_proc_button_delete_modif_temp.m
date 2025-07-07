function app_proc_button_delete_modif_temp(app)

% In app_image_processing App, the button of delete the temporal modification (Button_13Pushed).
%
%
% See also
% app_image_processment


% START OF THE FUNCTION


    % Borra les modificacions temporals, i en crea una de nova en blanc
    
    % Condicional si hi ha valor agafat:
    if ~isempty(app.ModificacionstemporalsListBox.Value)            
        
        answer_del = questdlg('Delete the temporal setting?', ...
                'Delete settings', 'Yes','No', 'Yes');
        % Handle response
        switch answer_del
            case 'Yes'
                answer_msgebox = 1;
            case 'No'
                answer_msgebox = 0;
        end 
        


        valor_modif_perm = separar_puntfile(app.ModificacionstemporalsListBox.Value); %Valor de la modificació permanent.
        
        
        % Si es diu que sí es vol eliminar, s'executa:
        if answer_msgebox

            % Es borren tant arxius com imatges temporals
            myFolder_input = "Results_out\Internal_code_files\Image_processing_settings\temporals\";
           
            string_delete = strcat(myFolder_input, valor_modif_perm, ".txt");
            delete(string_delete)
                
        end


        % Actualitzem elements:
        [llistat_string_im] = llegir_arxius_tipologia("Results_out\Internal_code_files\Image_processing_settings\temporals\", ".txt");
        app.ModificacionstemporalsListBox.Items = llistat_string_im;
        
        % Es fa com si s'apretés el botó 'Original'
        app.OriginalButton


        % Si és vuida modificacions temporals, però no guardades:
        if isempty(app.ModificacionstemporalsListBox.Items)
            if ~isempty(app.ModificacionsguardadesListBox.Items)
                modif_guardades_items = app.ModificacionsguardadesListBox.Items;
                app.ModificacionsguardadesListBox.Value = modif_guardades_items(1);
            else
                app.NovamodificaciButtonPushed;
            end
        end


    end




%             % BORRAT DE TOTS
%             % Si es diu que sí es vol eliminar, s'executa:
%             if answer_msgebox
%                 
%                 % Es borren tant arxius com imatges temporals
%                 patrons_imatge = [".txt", ".png"];
%                 for patro_n = 1:length(patrons_imatge)
%                     patro_tipus_image = patrons_imatge(patro_n);
%                     
%                     if patro_tipus_image == ".txt"
%                         myFolder_input = "Results_out\Internal_code_files\Image_processing_settings\temporals\";
%                     elseif patro_tipus_image == ".png"
%                         myFolder_input = "Apps\app_image_processment\Internal code files\Image processing settings\temporals\settings_imatges\";
%                     end
%                     [llistat_string_im] = llegir_arxius_tipologia(myFolder_input, patro_tipus_image);
%                     
%                    
%                     for cada_arxiu = 1:length(llistat_string_im)
%                     
%                         string_delete = strcat(myFolder_input, llistat_string_im(cada_arxiu) );
%                         delete(string_delete)
%                         
%                     end
%                     
%                 end
%             end


% END OF THE FUNCTION


end