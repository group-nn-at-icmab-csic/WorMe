function app_proc_button_imadjust_select(app)

% In app_image_processing App, the button of imadjust select, for to retail and select the area to do base the imadjust.
%
%
% See also
% app_image_processment


% START OF THE FUNCTION


    % Botó retallar per configurar ajustament
    % Imadjust by cropping
    
    % Retalla una part de la imatge (C. elegans) i aplica el valor
    % de filtre a tota la imatge.  Binaritza la imatge
    
    % COPIA botó imadjust
    % Botó "imadjust"
    
    % Botó modificació imatge 1: Binarització
    
    app.Image2.Visible = 'on';
    


    % __Modificació imcrop:__
    % Crop de la imatge modificada:
    % Obtenir array lectura del document de text i printar aquest            
    [array_processaments, ~] = app_proc_obtenir_array_modificacions(app);
    fullFileName = app.vapp_ruta_img_origin;
    imatge_original = imread_ifgrey(fullFileName);
    % Processament imatge
    [BW_final, ~] = processament_imatge_llistat(imatge_original, array_processaments);

    %Crop
    img_example_crop = imcrop(BW_final); close
    
    % Processament, per a obtenció de paràmetres
    img_example_crop_imgray = im2gray(img_example_crop);

    % Obtencio parametres
    Idouble = im2double(img_example_crop_imgray); 
    param_average = mean2(Idouble);
    param_sigma = std2(Idouble);
    
    % Afegim al text la modificació
    [field_set] = app_proc_obten_fieldset(app);            
    txt_seg(field_set, strcat("imadjust_croped","(", string(param_average), ", ", string(param_sigma),")"), ";") % seguiment config.
   

    % VISUALIZATION OF THE MODIFICATIONS
    app_proc_visual_modif(app)

    app.Image2.Visible = 'off';     

% END OF THE FUNCTION


end