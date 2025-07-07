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




    % ____Lectura imatge per carpeta____
    
    % LECTURA IMATGES .jpg i .png de la carpeta:
    % [theFiles] = lectura_imatges_carpeta_estr(carpeta_imatges);
    

    theFiles = app.theFiles_arxiu;
    
    % Llargada total imatges
    %llargada_ims = length(theFiles); % Contador imatges totals
    
    % __Determinació escala__
    % Obtencio 1a imatge
    baseFileName = theFiles(1).name;
    %disp(baseFileName)
    fullFileName = fullfile(theFiles(1).folder, baseFileName);
    imatge_original = imread_ifgrey(fullFileName);
    
    app.Image.ImageSource = imatge_original;

    % Grafiquem la imatge original en petit
    app.Image3.ImageSource = imatge_original;               

    % _Guardem ruta de la imatge original_
    app.vapp_ruta_img_origin = fullFileName;
    
    

    % ____Definim les modificacions____
    % Definim la Box de Modificacions, a partir dels documents existents:
    
    % Llegir arxius Modificacions temporals
    myFolder_input = "Results_out\Internal_code_files\Image_processing_settings\temporals\";
    [llistat_string_im_temp] = llegir_arxius_tipologia(myFolder_input, ".txt");          
    app.ModificacionstemporalsListBox.Items = llistat_string_im_temp;

    % Llegir arxius Modificacions guardades
    myFolder_input = "Results_out\Internal_code_files\Image_processing_settings\"; 
    [llistat_string_im_guard] = llegir_arxius_tipologia(myFolder_input, ".txt");
    app.ModificacionsguardadesListBox.Items = llistat_string_im_guard;
    


    % _Preselecció modificació_
    % Fer que es guardi el nom de l'arxiu, de manera que la proxima
    % vegada que s'executi el programa, sigui aquesta modificació
    % la que es pre-seleccioni de foroma automàtica.
    % _Obtenció (o no) valor de la carpeat predefinit
    predefined_file_input = "Results_out\Internal_code_files\predefined_modif.txt";
    
    if isfile(predefined_file_input)
        % Si existeix un arxiu de text que contingui l'escala
        predef_modif_llegida = llegir_text_delimitadors(predefined_file_input, ";");
        predef_modif = predef_modif_llegida{2}; clear predef_modif_llegida  % es defineix la carpeat predefinida
        
        if ismember(predef_modif, app.ModificacionstemporalsListBox.Items)
            app.ModificacionstemporalsListBox.Value = predef_modif;
            app.ModificacionsguardadesListBox.Value = {};
        elseif ismember(predef_modif, app.ModificacionsguardadesListBox.Items)
            app.ModificacionstemporalsListBox.Value = {};
            app.ModificacionsguardadesListBox.Value = predef_modif;
        end


    % _No modificació preseleccionada_
    else
        
        % Si les modificacions gaurdades són vuides
        if isempty(app.ModificacionsguardadesListBox.Items)
            
            % Si també ho és vuida les modificacions temporals
            if isempty(app.ModificacionstemporalsListBox.Items)
                % Fem que es faci una nova modificació
                % app.NovamodificaciButtonPushed;

                % Es crea un arxiu nou de zero.
                nom_arxiu_guardar = strcat("Results_out\Internal_code_files\Image_processing_settings\temporals\Modif_img_01.txt");
                txt_seg(nom_arxiu_guardar, "", ";", "nou", "blanc") % seguiment config.

                % _Actualitzem els ListBox_
                % Modifs Temporals
                myFolder_input = "Results_out\Internal_code_files\Image_processing_settings\temporals\";
                [llistat_string_im] = llegir_arxius_tipologia(myFolder_input, ".txt");
                % Actualitzem el listbox
                app.ModificacionstemporalsListBox.Items = llistat_string_im;       
                
                
                % Seleccionar el que té el nom cambiat:
                app.ModificacionstemporalsListBox.Value = llistat_string_im(end);
                
            % Si hi ha modificacións temporals
            else
                % Sinó, que es seleccioni les modificacions
                app.ModificacionsguardadesListBox.Items = llistat_string_im_temp;                    
                app.ModificacionstemporalsListBox.Value = llistat_string_im_temp(1);
            end

        % Si sí que hi ha modificacións guardades
        else
            app.ModificacionsguardadesListBox.Items = llistat_string_im_guard;
            app.ModificacionsguardadesListBox.Value = llistat_string_im_guard(end);

            % Si hi ha modificacions temporals
            if ~isempty(app.ModificacionstemporalsListBox.Items)
                app.ModificacionstemporalsListBox.Value = {}; % llistat_string_im_temp(1);  
            end
            
            
        end

    end


    
    
    

    % NOTES
    % - arquitectura modificacions -
    % Fer que les modificacions guardades no es puguin modificar,
    % sino que per a ser modificades d'hagin de copiar a
    % modificacions temporals, i tornar a ser guardades a
    % Modificacions guardades. D'aquesta manera s'evita que la
    % modificació sigui alterada de maner fàcil, sino que si es vol
    % alterar s'hagi de tornar a copiar i tornar a borrar, o
    % guardar amb un altre nom, lo qual promou la permanència de
    % les configuracións primeres.
    
    % - guardar imatges - 
    % Les imatges seràn guardades paral·lelament amb les
    % modificacións, en la mateixa carpeta (carpeta imatges, ja
    % siguin o no temporals). D'aquesta manera si s'agafa una u
    % altre modificació, es veurà amb la imatge amb que s'ha fet, i
    % si aquesta imatge es continua modificant, es veurà llavors en
    % tal modificació.
    
    
    % Definició variables i contadors
    
    % Valor contador numero imatge
    app.contador_numimLabel.Text = "0";

    
    % VISUALIZATION OF THE MODIFICATIONS
    app_proc_visual_modif(app)


    
    % DESACTIVACIÓ/ACTIVACIÓ BOTÓNS MODIFICACIÓ IMATGE SEGONS
    % TIPOLOGIA IMATGE
    
    if ~isempty(app.ModificacionsguardadesListBox.Value)
        
        % Descativació dels botons
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
    
    
    % __Activació/Desactivació altres botóns inicials__

    % Visió botons
    app.Button_12.Visible = 'off';
    app.Button_11.Visible = 'on';

    app.Image2.Visible = 'off';
    app.ModificarButton.Visible = 'off';
    app.num_objectes_binarisLabel.Text = "Not determined";
    
    % Contador numero imatge
    app.contador_numimLabel.Text = "1";
    app.Button_12.Visible = "off";
    
    
    % Text Requeriments
    app.RequirmentAnalysisText.Visible = 'off';
    
    

    % __Iniciació inicial del programa__
    % En aquest s'executa el tutorial i modificacions exemple,
    % entre d'altres.

    % _Iniciació tutorial_
    % D'inici que s'executi el tutorial.
    % ÑÑÑ app.TutorialButtonValueChanged
    % ÇÇÇ: Que el valor del tutorial es guardi, de manera que no
    % sempre surti com a inicial.

    
    % _Copia modificacions exemple_
    % Es copien les modificacions de app_image_processment\Internal code files\Modifications_examples a 
    file_porta_modifs = "Results_out\Internal_code_files\first_modifications.txt"; % Arxiu porta copia modifs exemple
    %waitfor(msgbox(file_porta_modifs))
    if ~isfile(file_porta_modifs)
        % Si no hi ha arxiu, significa que es la primera vegada que
        % s'inicia. Es copien les modif guardades temporals.

        % Per cada arxiu exemple, es copia:
        for n_va = 1:6
            arxiu_copiar = which(strcat("Modif_Example_", string(n_va), ".txt"));
            % NOTA: el nom de l'arxiu no s'especifica la ruta,
            % perquè aquest és dins del programa innicial. Donat
            % que s'ha canviat la ruta del programa, la obtenció
            % dels arxius definits inicialment en el programa s'ha
            % de realitzar a partir del seu nom directe, i no del
            % seu directori, donat que es intern.
            % Altrament, si no funcionés, es faria un which
            % d'aquest per obtenir la ruta interna de l'arxiu.
            directori_nou_copiar = strcat("Results_out\Internal_code_files\Image_processing_settings\Modif_Example_", string(n_va), ".txt");
            copyfile(arxiu_copiar, directori_nou_copiar)
        end

        % Creem arxiu contador
        write_text_array(file_porta_modifs, ["first_modif", "true"], ";");

    end




    % __Actualitzar modificacions__
    
    % Llegir arxius Modificacions guardades
    myFolder_input = "Results_out\Internal_code_files\Image_processing_settings\";
    patro_tipus_image = ".txt";
    [llistat_string_im] = llegir_arxius_tipologia(myFolder_input, patro_tipus_image);
    
    app.ModificacionsguardadesListBox.Items = llistat_string_im;
    
    
    % Automatització Drop Roll Modificacions temporals
    myFolder_input = "Results_out\Internal_code_files\Image_processing_settings\temporals\";
    patro_tipus_image = ".txt";
    [llistat_string_im] = llegir_arxius_tipologia(myFolder_input, patro_tipus_image);
                
    app.ModificacionstemporalsListBox.Items = llistat_string_im;
    



% END OF THE FUNCTION


end