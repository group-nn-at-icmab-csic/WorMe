function app_interf_graficar_BB_imatge_ultima(app)

% Grafica la última imatge seleccionada.

% INICI FUNCIO

if ~isempty(app.global_S_textscan_table)

    app.Image2.Visible = 'on';
    app.Image3.Visible = 'on';
    app.LastmodifLabel.Visible = 'on';

    % Obtenim la última fila de la taula principal:
    S_textscan_table = app.global_S_textscan_table(end,:);
    
    
    BB_values = appf_split_strindex(S_textscan_table.Bounding)';
    
    % Definim resolució de la imatge:
    size_BW = [double(strsplit(app.resolucio_img, ";"))];
    
    % Creem imatge esqueletonització
    BW_skel = false(size_BW);
    BW_skel(appf_split_strindex(S_textscan_table.Indx_skel)) = true;
    
    % waitfor(imshow(BW_skel))
    
    % Retallem pels BB
    BW_skel_crop = imcrop(BW_skel, BB_values);
    % waitfor(imshow(BW_skel_crop))
    
    % Eixamplar index
    indx_BW_skel_crop_eix = wide_indx_BB(find(BW_skel_crop), 1, size(BW_skel_crop));
    BW_skel_crop_eix = false(size(BW_skel_crop));
    BW_skel_crop_eix(indx_BW_skel_crop_eix) = true;
    
    % Obtenim la imatge original:
    imageArray = imread(strcat(app.dir_imgs_orig, "\", S_textscan_table.NomWorm)); % app.img_original_nomLabel.Text
    
    
    imageArray_croped = imcrop(imageArray, BB_values);
    
    
    imageArray_crop_skel = imoverlay(imageArray_croped, BW_skel_crop_eix, "k");
    
    
    % Mostrem la imatge temporal:
    if ~isempty(app.imatge_anterior_1)
        app.Image2.ImageSource = imageArray_crop_skel;
    
        % Graficar imatge anterior:
        
        if S_textscan_table.IsCeleg == "no"
            app.Image3.ImageSource = "Apps\app_selection_pannel\images_useful\cross.png";
        else
            app.Image3.ImageSource = "Apps\app_selection_pannel\images_useful\greentick.png";
        end
        
    end
    
else
    app.Image2.Visible = 'off';
    app.Image3.Visible = 'off';
    app.LastmodifLabel.Visible = 'off';
           
end




% FINAL FUNCIO

end