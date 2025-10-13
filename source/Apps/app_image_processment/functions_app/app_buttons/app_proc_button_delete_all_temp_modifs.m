function app_proc_button_delete_all_temp_modifs(app)

% In app_image_processing App, the button of delete all the temporal modifications (DelAllPushed).
%
%
% See also
% app_image_processment


% START OF THE FUNCTION


    answer_del = questdlg('Delete ALL the temporal setting?', ...
            'Delete settings', 'Yes','No', 'Yes');
    % Handle response
    switch answer_del
        case 'Yes'
            answer_msgebox = 1;
        case 'No'
            answer_msgebox = 0;
    end 
    



    % _Delete of all_
    % If it is said that it does want to be deleted, it is executed:
    if answer_msgebox
        
        % Delete files and temporary images
        patrons_imatge = [".txt", ".png"];
        for patro_n = 1:length(patrons_imatge)
            patro_tipus_image = patrons_imatge(patro_n);
            
            if patro_tipus_image == ".txt"
                myFolder_input = fullfile("Results_out", "Internal_code_files", "Image_processing_settings", "temporals", filesep);
            elseif patro_tipus_image == ".png"
                myFolder_input = fullfile("Apps", "app_image_processment", "Internal code files", "Image processing settings", "temporals", "settings_imatges", filesep);
            end
            [llistat_string_im] = read_files_typology(myFolder_input, patro_tipus_image);
            
           
            for cada_arxiu = 1:length(llistat_string_im)
            
                string_delete = strcat(myFolder_input, llistat_string_im(cada_arxiu) );
                delete(string_delete)
                
            end
            
        end
    end

                


    % Update the List de modificacions
    % Update elements:
    [llistat_string_im] = read_files_typology(fullfile("Results_out", "Internal_code_files", "Image_processing_settings", "temporals", filesep), ".txt");
    app.ModificacionstemporalsListBox.Items = llistat_string_im;
    

    % If empty temporary modifications, but not saved:
    if isempty(app.ModificacionstemporalsListBox.Items)
        if ~isempty(app.ModificacionsguardadesListBox.Items)
            modif_guardades_items = app.ModificacionsguardadesListBox.Items;
            app.ModificacionsguardadesListBox.Value = modif_guardades_items(1);
        else
            app.NovamodificaciButtonPushed;
        end
    else

    end

% END OF THE FUNCTION


end