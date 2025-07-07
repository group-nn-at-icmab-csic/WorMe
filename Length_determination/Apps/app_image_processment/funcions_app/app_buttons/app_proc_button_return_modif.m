function app_proc_button_return_modif(app)

% In app_image_processing App, the button of return to the last modification.
%
% The button make a "back" to the modification, deleting last modification done.
%
%
% See also
% app_image_processment


% START OF THE FUNCTION

    % Botó "back", sobre que fa un return de la modificació.


    % Veure botó % Botó "imadjust"
    % Guardar en arxiu de text i printar en pantalla
    % Agafem el text seleccionat del ListBox, segons el tipus de modificació seleccionat (temporal o guardat)
    if ~isempty(app.ModificacionstemporalsListBox.Value)
        value_listbox = app.ModificacionstemporalsListBox.Value;
        field_set = strcat("Results_out\Internal_code_files\Image_processing_settings\temporals\", string(value_listbox));
    % Si es pre-selecciona en guardats
    elseif ~isempty(app.ModificacionsguardadesListBox.Value)
        value_listbox = app.ModificacionsguardadesListBox.Value;
        % Llegir arxiu i mostrar en Label Modificacions
        field_set = strcat("Results_out\Internal_code_files\Image_processing_settings\", string(value_listbox));
    end

    % Borrem la última línia del text:
    % Nota: Codi adaptat exclusivament per a combinació amb f'txt_seg'
    [array_processos, ~] = llegir_text_delimitadors(field_set, ";");
    
    [files_ar, ~] = size(array_processos);
    
    delete(field_set)
    txt_seg(field_set, "", ";", "nou", "blanc") % seguiment config.
    for cada_proces = 2:(files_ar-1)
        % Obtenim cada procés
        proces_print = array_processos{cada_proces, 2};
        txt_seg(field_set, proces_print, ";")
    end 
    
    
    % LECTURA IMATGE BOTÓ
    fullFileName = app.vapp_ruta_img_origin;
    imatge_original = imread_ifgrey(fullFileName);            
    

    % __Printar en Modificacions__
    % Obtenir array lectura del document de text i printar aquest            
    [array_sortida_modifs, ~] = llegir_text_delimitadors(field_set, ";");
    [x_rows_arrayproc, ~] = size(array_sortida_modifs);
    % Si no hi ha modificacions:
    if x_rows_arrayproc < 2
        % Graficació
        app.Image.ImageSource = imatge_original;
        
        % Obtenir num objectes binaris:
        app.num_objectes_binarisLabel.Text = "Indef.";
        
        app.Modificacions_actuals.Value = "";
        array_processaments = {};
    % Si hi ha modificacions
    
    else
        cell_cont = array_sortida_modifs(2:end, 2);
        array_processaments = cell2array_own(cell_cont);
        % Mostrem les modificacións
        app.Modificacions_actuals.Value = array_processaments';
        
        % MODIFICACIÓ DE LA IMATGE
        % Processament imatge
        [BW_final, ~] = processament_imatge_llistat(imatge_original, array_processaments);
        
        % Graficació
        [imatge_3D_sortida] = graficar_rgbgraybw_image(BW_final);
        app.Image.ImageSource = imatge_3D_sortida;
        
        % Obtenir num objectes binaris:
        app.num_objectes_binarisLabel.Text = obtenir_num_BW(BW_final);                        
    
    end

    % OBTENIM TIPOLOGIA DE LA IMATGE
    if isempty(array_processaments)
        % La imatge és rgb
        tipus_im_modif = "rgb";
        % 
    else
        % Obtenim la última modificació
        ultima_modificacio = array_processaments(end);
        
        % Obtenim el nom d'aquesta
        [tipus_im_modif, ~] = obtencio_tipologia_llistat(ultima_modificacio);
    end
    
    
    % _Mostrar imatge rellotge_
    app.Image2.Visible = 'off';
    
    
    
    % DESACTIVACIÓ/ACTIVACIÓ BOTÓNS MODIFICACIÓ IMATGE SEGONS
    % TIPOLOGIA IMATGE
    app_proc_desact_act_buttons(app, tipus_im_modif)
             
    

% END OF THE FUNCTION


end