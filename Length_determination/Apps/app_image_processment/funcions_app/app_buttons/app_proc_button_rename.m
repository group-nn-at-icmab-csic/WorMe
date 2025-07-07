function app_proc_button_rename(app)

% In app_image_processing App, the button of rename.
%
% Modify the name of the selected image processment modification.
%
%
% See also
% app_image_processment


% START OF THE FUNCTION

    % _Obtenim el nom nou_
    
    % Modificacions guardades és vuit, es modificarà la carpeta de modificacións temporals
    if isempty(app.ModificacionsguardadesListBox.Value)
        rename_cont = "temporals";
    % Modificacions temporals és vuit, es modificarà la carpeta de modificacións guardades
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

    % Obrir cuadre dialeg per entrada nom arxiu
    prompt = "Nom de l'arxiu:";
    dlgtitle = 'Input';
    dims = [1 35];
    answer_resposta = inputdlg(prompt,dlgtitle,dims,definput);

    % Si no es cancela
    if ~isempty(answer_resposta)
        
        % Si conté ".txt" es torna a fer.
        if contains(answer_resposta{1}, ".txt")
            waitfor(msgbox("File cannot have '.txt' "))
            while contains(answer_resposta{1}, ".txt")
                prompt = "Nom de l'arxiu:";
                dlgtitle = 'Input';
                dims = [1 35];
                answer_resposta = inputdlg(prompt,dlgtitle,dims,definput);
                
                % si es cancela
                if isempty(answer_resposta)
                    break
                end
            end
        end
    end
    
    
    % Si hi ha text en la resposta
    if ~isempty(answer_resposta)
        
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
            % answer_resposta : Resposta del nou nom, que no existeix.
            
            if rename_cont == "temporals"
                nom_arxiu_anterior = strcat("Results_out\Internal_code_files\Image_processing_settings\temporals\",app.ModificacionstemporalsListBox.Value);
                nom_arxiu_guardar = strcat("Results_out\Internal_code_files\Image_processing_settings\temporals\",answer_resposta,".txt");
            elseif rename_cont == "guardades"
                nom_arxiu_anterior = strcat("Results_out\Internal_code_files\Image_processing_settings\",app.ModificacionsguardadesListBox.Value);
                nom_arxiu_guardar = strcat("Results_out\Internal_code_files\Image_processing_settings\",answer_resposta,".txt");                        
            end
            
            % Creem un arxiu nou i borrem l'anterior
            movefile(nom_arxiu_anterior, nom_arxiu_guardar);
            % copyfile(nom_arxiu_anterior, nom_arxiu_guardar);
            

            % _Actualitzem els ListBox_
            if rename_cont == "temporals"
                % Actualitzem les llsites:
                % Llegir arxius Modificacions guardades
                myFolder_input = "Results_out\Internal_code_files\Image_processing_settings\temporals\";
                patro_tipus_image = ".txt";
                [llistat_string_im] = llegir_arxius_tipologia(myFolder_input, patro_tipus_image);

                % Actualitzem el listbox
                app.ModificacionstemporalsListBox.Items = llistat_string_im;    

                % Seleccionar el que té el nom cambiat:
                app.ModificacionstemporalsListBox.Value = strcat(answer_resposta, ".txt");
            elseif rename_cont == "guardades"
                % Actualitzem les llsites:
                % Llegir arxius Modificacions guardades
                myFolder_input = "Results_out\Internal_code_files\Image_processing_settings\";
                patro_tipus_image = ".txt";
                [llistat_string_im] = llegir_arxius_tipologia(myFolder_input, patro_tipus_image);

                % Actualitzem el listbox
                app.ModificacionsguardadesListBox.Items = llistat_string_im;    

                % Seleccionar el que té el nom cambiat:
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