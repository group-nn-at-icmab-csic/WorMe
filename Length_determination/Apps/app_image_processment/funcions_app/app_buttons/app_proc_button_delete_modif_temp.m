function app_proc_button_delete_modif_temp(app)

% In app_image_processing App, the button of delete the temporal modification (Button_13Pushed).
%
%
% See also
% app_image_processment


% START OF THE FUNCTION

    % Deletes the temporary modifications, and creates a new blank one
    
    % Conditional if there is a selected value:
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
        

        valor_modif_perm = separar_puntfile(app.ModificacionstemporalsListBox.Value); % Value of the permanent modification.
        
        
        % If it is confirmed that it should be deleted, execute:
        if answer_msgebox

            % Both temporary files and images are deleted
            myFolder_input = "Results_out\Internal_code_files\Image_processing_settings\temporals\";
           
            string_delete = strcat(myFolder_input, valor_modif_perm, ".txt");
            delete(string_delete)
                
        end


        % Update elements:
        [llistat_string_im] = llegir_arxius_tipologia("Results_out\Internal_code_files\Image_processing_settings\temporals\", ".txt");
        app.ModificacionstemporalsListBox.Items = llistat_string_im;
        
        % Act as if the 'Original' button was pressed
        app.OriginalButton


        % If temporary modifications are empty, but not saved ones:
        if isempty(app.ModificacionstemporalsListBox.Items)
            if ~isempty(app.ModificacionsguardadesListBox.Items)
                modif_guardades_items = app.ModificacionsguardadesListBox.Items;
                app.ModificacionsguardadesListBox.Value = modif_guardades_items(1);
            else
                app.NovamodificaciButtonPushed;
            end
        end


    end



% END OF THE FUNCTION


end