function app_proc_visual_modif(app)
% From the app_image_processment,
% the modifications loaded are visualized in the App.
%
% Synthesis function. Synthesis of the functions for reading and applying image processing.
% It is used to update the image once configurations are modified,
% for example, when a new processing step is added, or the modification is changed, or a new one is created, etc.
%
% The workflow is:
% 1. The list of modifications stored in
% Results_out/Internal_code_files/*Name_of_modification* is obtained:
%
%         Order of process; Type of process
%         1;imadjust_croped(0.75524, 0.092623)
%         2;imadjust
%         3;imadjust_croped(0.64966, 0.35182)
%         4;Flip
%         5;close_disc(1)
%         6;bwareaopen(0.5)
%         7;bwareaopen(1.5)
%         8;imfill
%         9;open_disc(1)
%         10;bwareaopen(3)
%         11;bwareaopen(4)
%         12;bwareaopen(5.5)
%         13;Imclearborder
% 
% 2. The image is read and the modifications
% (array_processaments) are applied, obtaining the final modified image (BW_final).
% 
% 3. The image is then plotted, and the buttons updated.
% 
% See also:
% app_proc_obtenir_array_modificacions
% processament_imatge_llistat



% START OF THE FUNCTION

    % VISUALIZATION OF THE MODIFICATIONS

    % Get the text selected from the ListBox:
    [array_processaments, tipus_im_modif] = app_proc_obtenir_array_modificacions(app);

    % Modify the original image and display it:
    imatge_original = imread(app.vapp_ruta_img_origin);
    [BW_final, ~] = processament_imatge_llistat(imatge_original, array_processaments);

    % Plot the image
    app_proc_graficar_segons_boto(app, imatge_original, BW_final, tipus_im_modif)

    % Deactivate/Activate buttons depending on image modification type
    app_proc_desact_act_buttons(app, tipus_im_modif)

% END OF THE FUNCTION



end