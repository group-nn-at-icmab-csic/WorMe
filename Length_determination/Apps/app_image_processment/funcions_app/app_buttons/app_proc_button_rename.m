function app_proc_button_rename(app)

% In app_image_processing App, the button of rename.
%
% Modify the name of the selected image processment modification.
%
%
% See also
% app_image_processment


% START OF THE FUNCTION
    % _Get the new name_
    
    % Saved modifications is empty, the temporary modifications folder will be modified
    if isempty(app.ModificacionsguardadesListBox.Value)
        rename_cont = "temporals";
    % Temporary modifications is empty, the saved modifications folder will be modified
    elseif isempty(app.ModificacionstemporalsListBox.Value)   
        rename_cont = "guardades";
    else
        msgbox('Error select folder', 'Error','error')
    end
    
    if ~isempty(app.ModificacionsguardadesListBox.Value)
        definput = string(app.ModificacionsguardadesListBox.Value);
    elseif ~isempty(app.ModificacionstemporalsListBox.Value)
        definput = string(app.ModificacionstemporalsListBox.Value); 
    else
        disp("No modifications?")
        definput = "";
    end
    if ~isempty(definput)
        definput_t = split(definput, ".txt");
        definput = definput_t(1);
    end
    
    % Open dialog box for file name input
    prompt = "Nom de l'arxiu:";
    dlgtitle = 'Input';
    dims = [1 35];
    answer_resposta = inputdlg(prompt,dlgtitle,dims,definput);
    
    % If not cancelled
    if ~isempty(answer_resposta)
        
        % If it contains ".txt" ask again.
        if contains(answer_resposta{1}, ".txt")
            waitfor(msgbox("File cannot have '.txt' "))
            while contains(answer_resposta{1}, ".txt")
                prompt = "Nom de l'arxiu:";
                dlgtitle = 'Input';
                dims = [1 35];
                answer_resposta = inputdlg(prompt,dlgtitle,dims,definput);
                
                % if cancelled
                if isempty(answer_resposta)
                    break
                end
            end
        end
    end
    
    
    % If there is text in the response
    if ~isempty(answer_resposta)
        
        % If files with the same name exist
        [llistat_string_im] = [...
            llegir_arxius_tipologia("Results_out\Internal_code_files\Image_processing_settings\temporals\", ".txt"), ...
            llegir_arxius_tipologia("Results_out\Internal_code_files\Image_processing_settings\", ".txt")];
        
        splitat_arxius = split(llistat_string_im, ".txt");
        
    
        si_no_son_iguals = true; % If this doesn't change, it means there are no files with the same name.
        for cada_arxiu = 1:length(llistat_string_im)
            if splitat_arxius(cada_arxiu) == answer_resposta
                si_no_son_iguals = false;
            end
        end
    
        % Whether they exist or not
        if si_no_son_iguals
            % Create the new file
            % answer_resposta : Response with the new name, which does not exist.
            
            if rename_cont == "temporals"
                nom_arxiu_anterior = strcat("Results_out\Internal_code_files\Image_processing_settings\temporals\",app.ModificacionstemporalsListBox.Value);
                nom_arxiu_guardar = strcat("Results_out\Internal_code_files\Image_processing_settings\temporals\",answer_resposta,".txt");
            elseif rename_cont == "guardades"
                nom_arxiu_anterior = strcat("Results_out\Internal_code_files\Image_processing_settings\",app.ModificacionsguardadesListBox.Value);
                nom_arxiu_guardar = strcat("Results_out\Internal_code_files\Image_processing_settings\",answer_resposta,".txt");                        
            end
            
            % Create a new file and delete the previous one
            movefile(nom_arxiu_anterior, nom_arxiu_guardar);
            % copyfile(nom_arxiu_anterior, nom_arxiu_guardar);
            
    
            % _Update the ListBoxes_
            if rename_cont == "temporals"
                % Update the lists:
                % Read saved modifications files
                myFolder_input = "Results_out\Internal_code_files\Image_processing_settings\temporals\";
                patro_tipus_image = ".txt";
                [llistat_string_im] = llegir_arxius_tipologia(myFolder_input, patro_tipus_image);
    
                % Update the listbox
                app.ModificacionstemporalsListBox.Items = llistat_string_im;    
    
                % Select the one with the changed name:
                app.ModificacionstemporalsListBox.Value = strcat(answer_resposta, ".txt");
            elseif rename_cont == "guardades"
                % Update the lists:
                % Read saved modifications files
                myFolder_input = "Results_out\Internal_code_files\Image_processing_settings\";
                patro_tipus_image = ".txt";
                [llistat_string_im] = llegir_arxius_tipologia(myFolder_input, patro_tipus_image);
    
                % Update the listbox
                app.ModificacionsguardadesListBox.Items = llistat_string_im;    
    
                % Select the one with the changed name:
                app.ModificacionsguardadesListBox.Value = strcat(answer_resposta, ".txt");                    
            end
        
        
        else
            waitfor(msgbox('Name already exist', 'Error','error'));
        end                
        
    else
        waitfor(msgbox('No name defined', 'Error','error'));
    end


% END OF THE FUNCTION


end