function app_proc_visual_modif(app)

% From the app_image_processment,
% the modifications loaded are visualized in the App.
%
% Funció de síntesis. Síntesis de les funcións de lectura i aplicació de processat d'imatge. 
% Es fa servir per a actualitzar la imatge una vegada es modifiquen configuracións com per exemple, 
% s'afegeix un nou processament, o es canvia la modificació, o es crea una de nova etc.
%
% El funcionament és: 
% 1: S'obté el llistat de modificacións, guardat en
% Results_out/Internal_cod_files/*Name_of_modification* :
%
%         Ordre proces;Tipus proces
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
% 2. The image is readed, and applied the modifications
% (array_processaments), obtaining the modified final image (BW_final).
% 
% 3. The image is then graphed, and the buttons uploaded.
% 
% See also:
% app_proc_obtenir_array_modificacions
% processament_imatge_llistat



% START OF THE FUNCTION

    % VISUALITZACIÓ DE LES MODIFICACIONS

    % Agafem el text seleccionat del ListBox:
    [array_processaments, tipus_im_modif] = app_proc_obtenir_array_modificacions(app);

    % Modifiquem la imatge original i la mostrem:
     imatge_original = imread(app.vapp_ruta_img_origin);
     [BW_final, ~] = processament_imatge_llistat(imatge_original, array_processaments);

     % Grafiquem la imatge
     app_proc_graficar_segons_boto(app, imatge_original, BW_final, tipus_im_modif)

    % Desactivació/Activacio botons segons tipu modif imatge
    app_proc_desact_act_buttons(app, tipus_im_modif)

% END OF THE FUNCTION


end