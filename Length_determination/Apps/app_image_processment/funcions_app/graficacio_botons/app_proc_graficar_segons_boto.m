function app_proc_graficar_segons_boto(app, imatge_original, BW_final, tipus_im_modif)

% Segons algúns botóns estiguin o no apretats (skeletonització,
% modificacio, mask, etc.) es grafica o no la imatge d'una manera u altre.
% 
% Tipologies de la imatge:
% "rgb", "gray", "binary"
% 
% See also
% app_proc_visual_modif

    % INICI FUNCIÓ

     if app.OriginalButton.Value
         % Imatge original
        imatge_3D_sortida = imatge_original;

    elseif app.MaskedButton.Value
        % Mascara de la imatge

        % Si és una imatge binària
        if tipus_im_modif == "binary"
            imoverlay_imatge = imoverlay(imatge_original, BW_final, "red");
            [imatge_3D_sortida] = graficar_rgbgraybw_image(imoverlay_imatge);

        % Si és rgb o grisa
        else
            [imatge_3D_sortida] = graficar_rgbgraybw_image(BW_final);
        end

    elseif app.ModifiedButton.Value
        % Imatge modificada
        [imatge_3D_sortida] = graficar_rgbgraybw_image(BW_final);
     end


     if app.EsqueletonitzarButton.Value && ~app.OriginalButton.Value
         % Esqueletonització

         % Si la imatge és binària:
         if tipus_im_modif == "binary"
             % _Comprovació nombre objectes_
             [~, num] = bwlabel(BW_final);
    
             % Si hi ha menys de 50 objectes (es pot processar)
             if num < 50
    
        
                 % Esqueletonització:
                [BW_skel_join] = esquel_multiple_BWobjects(BW_final);
        
                % Extenem els indx
                indx_endpoints_BWskel = find(bwmorph(BW_skel_join, 'endpoints'));
                [indx_BWskel_obj_fin] = eixamplar_indx_noendpoints(find(BW_skel_join), indx_endpoints_BWskel, size(BW_skel_join));
                % Pintar els indx
                BW_skel_join_extend = false(size(BW_skel_join));
                BW_skel_join_extend(indx_BWskel_obj_fin) = true;
    
                if app.MaskedButton.Value
                    % Printem la imatge
                    imatge_3D_sortida = imoverlay(imoverlay(imatge_original, BW_final, "k"), BW_skel_join_extend, "r");
                elseif app.ModifiedButton.Value
                    imatge_3D_sortida = imoverlay(BW_final, BW_skel_join_extend, "r");
                end
    
            % Si hi ha masses objectes, no s'executen aquests:
             else
                         %[imageArray_text] = graficar_text_img(imageArray)
                if app.MaskedButton.Value
                    % Printem la imatge
                    imatge_3D_sortida = imoverlay(imatge_original, BW_final, "k");
                    [imatge_3D_sortida] = graficar_text_img(imatge_3D_sortida);
    
                elseif app.ModifiedButton.Value
                    imatge_3D_sortida = (BW_final);
                    [imatge_3D_sortida] = graficar_text_img(graficar_rgbgraybw_image(imatge_3D_sortida));                
                end
             end
    
         % Si la imatge és original o gris
         else
            [imatge_3D_sortida] = graficar_rgbgraybw_image(BW_final);

         end

     end
    

     % Graficació en la imatge resultant
    app.Image.ImageSource = imatge_3D_sortida;
    

    %Obtenir num objectes binaris:
    app.num_objectes_binarisLabel.Text = obtenir_num_BW(BW_final);



% Codi antic:
%     if app.OriginalMaskedModified_typeLabel.Text == "Original"
%         app.Image.ImageSource = imatge_original;
%     elseif app.OriginalMaskedModified_typeLabel.Text == "Masked"
%         imoverlay_imatge = imoverlay(imatge_original, BW_final, "red");
%         [imatge_3D_sortida] = graficar_rgbgraybw_image(imoverlay_imatge);
%         app.Image.ImageSource = imatge_3D_sortida;
%     elseif app.OriginalMaskedModified_typeLabel.Text == "Modified"
%         [imatge_3D_sortida] = graficar_rgbgraybw_image(BW_final);
%         app.Image.ImageSource = imatge_3D_sortida;            
%     elseif app.OriginalMaskedModified_typeLabel.Text == "Skeletized"
%         [~, sfMaskBurn_new] = esqueletonitzacio_rapida_josep(BW_final, imatge_original);
%         [imatge_3D_sortida] = graficar_rgbgraybw_image(sfMaskBurn_new);
%         app.Image.ImageSource = imatge_3D_sortida;
%      end
% 



    % FINAL FUNCIÓ




end
