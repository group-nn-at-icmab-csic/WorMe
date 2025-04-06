function [proc_BW, new_img, num, BW_final_object, BW_final_noproc, imatge_original] = app_interf_select_obj_bin(app, number_BW, BW_final_noproc, dir_output, imatge_original)

% Selecciona els objectes binaris de la imatge i els retorna, si n'hi ha, i
% sino retorna la imatge nova processada.
% Funció de la app 'app_nova_interfaz_nova_funcions'.
%
%
%
% Variables
% number_BW : numero d'objectes binaris (de BW objectes no processats 'BW_final_noproc')

% INICI FUNCIÓ

% Si hi ha algún objecte binari
if number_BW > 0
    % Obtenim l'objecte binari
    [L_variable, num] = bwlabel(BW_final_noproc);
    BW_final_object = L_variable == 1;
    % imshow(BW_final_object)

    proc_BW = true; % Contador que no s'ha arribat al final    

    new_img = false; % Contador imatge nova

% Si ja no hi ha cap objecte binari:
else
    % _Seguim amb la següent imatge_

    % Definim contador imatges
    n_imatge = str2double(app.img_contLabel.Text) +1;

    app.img_contLabel.Text = string(n_imatge);

    % Si el nombre d'imatges no supera el total:
    if n_imatge <= str2double(app.img_tot_nLabel.Text)
        % _Agafem la imatge posterior a l'actual_
        % DEFINICIÓ DE LA IMATGE
        % Carpeta de les imatges
        carpeta_imatges = app.dir_imgs_orig;

        % LECTURA IMATGES .jpg i .png de la carpeta:
        [theFiles] = lectura_imatges_carpeta_estr(carpeta_imatges);

        % Obtencio imatge
        baseFileName = theFiles(n_imatge).name;
        app.img_original_nomLabel.Text = baseFileName;
        fullFileName = fullfile(theFiles(n_imatge).folder, baseFileName);
        % Imatge a processar
        imatge_original = imread(fullFileName);

        % CAMBIEM RUTA IMATGE
        app.vapp_ruta_img_origin = fullFileName;

        % _Processem la imatge_            
        % Llegir arxiu i mostrar en Label Modificacions
        [array_processaments] = obtenir_array_processaments(strcat("Apps\app_processament_imatge\Internal code files\Image processing settings\", string(app.ModificacionsguardadesListBox.Value)));

        % Modifiquem la imatge original i la mostrem: 
         [BW_final, ~] = processament_imatge_llistat(imatge_original, array_processaments); 
         % Guardem la imatge en PNG:
         imwrite(BW_final, strcat(dir_output, "\imgBWtemp.png"));

        % Apliquem l'esborrat dels índex (ÇÇ no és del tot
        % necessari)
        [L_variable, num] = bwlabel(BW_final);
        BW_final_object = L_variable == 1;

        % Definim imatge BW amb objectes no processats:
        BW_final_noproc = BW_final;
        BW_final_noproc(BW_final_object) = false;             

        % Fem contador com a nova imatge
        new_img = true;

        proc_BW = true; % Contador que no s'ha arribat al final
        
        % Definim que no és la última imatge
        app.finalitzat_contLabel.Text = "true";
        
    else
        % Es sobrepassa la imatge: cartell de Finished
        app.Image.ImageSource = imread("Apps\app_nova_interfaz_nova\Imatges_utilitat\Finished_WM.png");
        app.Image2.ImageSource = imread("Apps\app_nova_interfaz_nova\Imatges_utilitat\Logo_WorMe_blanc.png");

        % Desactivem botóns
        app.Thick_Button.Visible = 'off';
        app.Cross_Button.Visible = 'off';
        %app.DoneButton.Visible = 'on';

        app.Hyperlink.Visible = 'on';
        app.CitationLabel.Visible = 'on';

        app.finalitzat_contLabel.Text = "true";
        
        proc_BW = false; % Contador que no s'ha arribat al final                    
    end

end


% FINAL FUNCIÓ


end