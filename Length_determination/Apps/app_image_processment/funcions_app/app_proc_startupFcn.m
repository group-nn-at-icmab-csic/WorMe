function app_proc_startupFcn(app)

% Here the description
%
%
% Variables
%   input
%       .
%       .
%       .
% 
%   output
%       .
%       .
%       .
%
% Example
%
%
% See also
%



% START OF THE FUNCTION

    % ____Image reading by folder____
    
    % READING .jpg and .png IMAGES from the folder:
    % [theFiles] = lectura_imatges_carpeta_estr(carpeta_imatges);
    

    theFiles = app.theFiles_arxiu;
    
    % Total image length
    %llargada_ims = length(theFiles); % Total image counter
    
    % __Scale determination__
    % Get 1st image
    baseFileName = theFiles(1).name;
    %disp(baseFileName)
    fullFileName = fullfile(theFiles(1).folder, baseFileName);
    imatge_original = imread_ifgrey(fullFileName);
    
    app.Image.ImageSource = imatge_original;

    % Plot the original image small
    app.Image3.ImageSource = imatge_original;               

    % _Save path of the original image_
    app.vapp_ruta_img_origin = fullFileName;
    
    

    % ____Define the modifications____
    % Define the Modifications Box, based on existing documents:
    
    % Read temporary modifications files
    myFolder_input = "Results_out\Internal_code_files\Image_processing_settings\temporals\";
    [llistat_string_im_temp] = llegir_arxius_tipologia(myFolder_input, ".txt");          
    app.ModificacionstemporalsListBox.Items = llistat_string_im_temp;

    % Read saved modifications files
    myFolder_input = "Results_out\Internal_code_files\Image_processing_settings\"; 
    [llistat_string_im_guard] = llegir_arxius_tipologia(myFolder_input, ".txt");
    app.ModificacionsguardadesListBox.Items = llistat_string_im_guard;
    


    % _Preselection of modification_
    % Save the name of the file, so that the next
    % time the program is run, this modification
    % is automatically preselected.
    % _Get (or not) predefined folder value_
    predefined_file_input = "Results_out\Internal_code_files\predefined_modif.txt";
    
    if isfile(predefined_file_input)
        % If there exists a text file containing the scale
        predef_modif_llegida = llegir_text_delimitadors(predefined_file_input, ";");
        predef_modif = predef_modif_llegida{2}; clear predef_modif_llegida  % defines the predefined folder
        
        if ismember(predef_modif, app.ModificacionstemporalsListBox.Items)
            app.ModificacionstemporalsListBox.Value = predef_modif;
            app.ModificacionsguardadesListBox.Value = {};
        elseif ismember(predef_modif, app.ModificacionsguardadesListBox.Items)
            app.ModificacionstemporalsListBox.Value = {};
            app.ModificacionsguardadesListBox.Value = predef_modif;
        end


    % _No preselected modification_
    else
        
        % If the saved modifications are empty
        if isempty(app.ModificacionsguardadesListBox.Items)
            
            % If the temporary modifications are also empty
            if isempty(app.ModificacionstemporalsListBox.Items)
                % Force the creation of a new modification
                % app.NovamodificaciButtonPushed;

                % Create a new file from scratch.
                nom_arxiu_guardar = strcat("Results_out\Internal_code_files\Image_processing_settings\temporals\Modif_img_01.txt");
                txt_seg(nom_arxiu_guardar, "", ";", "nou", "blanc") % configuration tracking

                % _Update the ListBox_
                % Temporary Mods
                myFolder_input = "Results_out\Internal_code_files\Image_processing_settings\temporals\";
                [llistat_string_im] = llegir_arxius_tipologia(myFolder_input, ".txt");
                % Update the listbox
                app.ModificacionstemporalsListBox.Items = llistat_string_im;       
                
                
                % Select the renamed one:
                app.ModificacionstemporalsListBox.Value = llistat_string_im(end);
                
            % If there are temporary modifications
            else
                % Otherwise, select the modifications
                app.ModificacionsguardadesListBox.Items = llistat_string_im_temp;                    
                app.ModificacionstemporalsListBox.Value = llistat_string_im_temp(1);
            end

        % If there are saved modifications
        else
            app.ModificacionsguardadesListBox.Items = llistat_string_im_guard;
            app.ModificacionsguardadesListBox.Value = llistat_string_im_guard(end);

            % If there are temporary modifications
            if ~isempty(app.ModificacionstemporalsListBox.Items)
                app.ModificacionstemporalsListBox.Value = {}; % llistat_string_im_temp(1);  
            end
            
            
        end

    end


    
    
    

    % NOTES
    % - modifications architecture -
    % Ensure that saved modifications cannot be modified,
    % but must be copied to
    % temporary modifications and saved again as
    % Saved Modifications. This prevents the
    % modification from being easily altered; if one
    % wants to alter it, it has to be copied again and deleted
    % or saved with another name, which promotes the permanence
    % of the initial configurations.
    
    % - saving images - 
    % Images will be saved in parallel with the
    % modifications, in the same folder (image folder,
    % whether temporary or not). This way, if one or another
    % modification is selected, it will be seen along with the
    % image with which it was created, and if that image
    % continues to be modified, it will be seen under
    % that modification.
    
    
    % Definition of variables and counters
    
    % Counter value for image number
    app.contador_numimLabel.Text = "0";

    
    % VISUALIZATION OF THE MODIFICATIONS
    app_proc_visual_modif(app)


    
    % DEACTIVATION/ACTIVATION OF IMAGE MODIFICATION BUTTONS
    % ACCORDING TO IMAGE TYPE
    
    if ~isempty(app.ModificacionsguardadesListBox.Value)
        
        % Deactivation of buttons
        app.Im2greyButton.Enable = 'off';
        % gray
        app.imadjustButton.Enable = 'off';
        app.BinarizeButton.Enable = 'off';
                        
        % binary
        app.AreaOpenButton.Enable = 'off';
        app.imclearborderButton.Enable = 'off';
        app.imfillButton.Enable = 'off';
        app.OpenButton.Enable = 'off';
        app.CloseButton.Enable = 'off';
        app.Spinner.Enable = 'off';
        app.Spinner_2.Enable = 'off';
        app.Spinner_3.Enable = 'off';
        app.flipButton.Enable = 'off';
        app.edgeapproxcannyButton.Enable = 'off';
        app.returnButton.Enable = 'off';
        app.imadjust_selectButton.Enable = 'off';                

    end
    
    
    % __Activation/Deactivation of other initial buttons__

    % Button visibility
    app.Button_12.Visible = 'off';
    app.Button_11.Visible = 'on';

    app.Image2.Visible = 'off';
    app.ModificarButton.Visible = 'off';
    app.num_objectes_binarisLabel.Text = "Not determined";
    
    % Image number counter
    app.contador_numimLabel.Text = "1";
    app.Button_12.Visible = "off";
    
    
    % Text Requirements
    app.RequirmentAnalysisText.Visible = 'off';
    
    

    % __Initial program startup__
    % Here the tutorial and example modifications are run,
    % among other things.

    % _Tutorial startup_


    
    % _Copy example modifications_
    % The modifications from app_image_processment\Internal code files\Modifications_examples are copied to 
    file_porta_modifs = "Results_out\Internal_code_files\first_modifications.txt"; % File carrying copy of example mods
    %waitfor(msgbox(file_porta_modifs))
    if ~isfile(file_porta_modifs)
        % If there is no file, it means it’s the first time
        % the program runs. Saved temporary mods are copied.

        % For each example file, copy:
        for n_va = 1:6
            arxiu_copiar = which(strcat("Modif_Example_", string(n_va), ".txt"));
            % NOTE: the file name does not specify the path,
            % because it is inside the initial program. Since
            % the program path has changed, obtaining
            % the initially defined files in the program has
            % to be done from their direct name, not from
            % their directory, since it’s internal.
            % Otherwise, if it does not work, a which
            % is done to get the internal path of the file.
            directori_nou_copiar = strcat("Results_out\Internal_code_files\Image_processing_settings\Modif_Example_", string(n_va), ".txt");
            copyfile(arxiu_copiar, directori_nou_copiar)
        end

        % Create counter file
        write_text_array(file_porta_modifs, ["first_modif", "true"], ";");

    end




    % __Update modifications__
    
    % Read saved modifications files
    myFolder_input = "Results_out\Internal_code_files\Image_processing_settings\";
    patro_tipus_image = ".txt";
    [llistat_string_im] = llegir_arxius_tipologia(myFolder_input, patro_tipus_image);
    
    app.ModificacionsguardadesListBox.Items = llistat_string_im;
    
    
    % Automation Drop Roll Temporary Modifications
    myFolder_input = "Results_out\Internal_code_files\Image_processing_settings\temporals\";
    patro_tipus_image = ".txt";
    [llistat_string_im] = llegir_arxius_tipologia(myFolder_input, patro_tipus_image);
                
    app.ModificacionstemporalsListBox.Items = llistat_string_im;


% END OF THE FUNCTION


end