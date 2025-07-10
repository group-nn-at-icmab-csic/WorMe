function app_proc_button_imadjust_select(app)

% In app_image_processing App, the button of imadjust select, for to retail and select the area to do base the imadjust.
%
%
% See also
% app_image_processment


% START OF THE FUNCTION

    % Crop button to configure adjustment
    % Imadjust by cropping

    % Crops a part of the image (C. elegans) and applies the filter value
    % to the whole image. Binarizes the image

    % COPY of imadjust button
    % "imadjust" button

    % Image modification button 1: Binarization

    app.Image2.Visible = 'on';

    % __Modification imcrop:__
    % Crop the modified image:
    % Obtain array reading from the text document and print it            
    [array_processaments, ~] = app_proc_obtenir_array_modificacions(app);
    fullFileName = app.vapp_ruta_img_origin;
    imatge_original = imread_ifgrey(fullFileName);
    % Image processing
    [BW_final, ~] = processment_img_list(imatge_original, array_processaments);

    % Crop
    img_example_crop = imcrop(BW_final); close
    
    % Processing, for parameter obtaining
    img_example_crop_imgray = im2gray(img_example_crop);

    % Obtain parameters
    Idouble = im2double(img_example_crop_imgray); 
    param_average = mean2(Idouble);
    param_sigma = std2(Idouble);
    
    % Add the modification to the text
    [field_set] = app_proc_obten_fieldset(app);            
    txt_seg(field_set, strcat("imadjust_croped","(", string(param_average), ", ", string(param_sigma),")"), ";") % config tracking

    % VISUALIZATION OF THE MODIFICATIONS
    app_proc_visual_modif(app)

    app.Image2.Visible = 'off';    
  

% END OF THE FUNCTION


end