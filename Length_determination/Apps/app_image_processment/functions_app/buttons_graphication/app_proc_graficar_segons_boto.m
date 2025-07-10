function app_proc_graficar_segons_boto(app, imatge_original, BW_final, tipus_im_modif)

% Depending on whether some buttons are pressed or not (skeletonization, 
% modification, mask, etc.) the image is displayed in one way or another.
% 
% Image typologies:
% "rgb", "gray", "binary"
% 
% See also
% app_proc_visual_modif

    % START OF FUNCTION

     if app.OriginalButton.Value
         % Original image
        imatge_3D_sortida = imatge_original;

    elseif app.MaskedButton.Value
        % Mask of the image

        % If it is a binary image
        if tipus_im_modif == "binary"
            imoverlay_imatge = imoverlay(imatge_original, BW_final, "red");
            [imatge_3D_sortida] = graph_rgbgraybw_image(imoverlay_imatge);

        % If it is rgb or grayscale
        else
            [imatge_3D_sortida] = graph_rgbgraybw_image(BW_final);
        end

    elseif app.ModifiedButton.Value
        % Modified image
        [imatge_3D_sortida] = graph_rgbgraybw_image(BW_final);
     end


     if app.EsqueletonitzarButton.Value && ~app.OriginalButton.Value
         % Skeletonization

         % If the image is binary:
         if tipus_im_modif == "binary"
             % _Check number of objects_
             [~, num] = bwlabel(BW_final);
    
             % If there are fewer than 50 objects (can be processed)
             if num < 50
    
                 % Skeletonization:
                [BW_skel_join] = skel_multiple_BWobjects(BW_final);
        
                % Extend the indices
                indx_endpoints_BWskel = find(bwmorph(BW_skel_join, 'endpoints'));
                [indx_BWskel_obj_fin] = wide_indx_nonendpoints(find(BW_skel_join), indx_endpoints_BWskel, size(BW_skel_join));
                % Paint the indices
                BW_skel_join_extend = false(size(BW_skel_join));
                BW_skel_join_extend(indx_BWskel_obj_fin) = true;
    
                if app.MaskedButton.Value
                    % Display the image
                    imatge_3D_sortida = imoverlay(imoverlay(imatge_original, BW_final, "k"), BW_skel_join_extend, "r");
                elseif app.ModifiedButton.Value
                    imatge_3D_sortida = imoverlay(BW_final, BW_skel_join_extend, "r");
                end
    
            % If there are too many objects, these are not executed:
             else
                % [imageArray_text] = graph_text_img(imageArray)
                if app.MaskedButton.Value
                    % Display the image
                    imatge_3D_sortida = imoverlay(imatge_original, BW_final, "k");
                    [imatge_3D_sortida] = graph_text_img(imatge_3D_sortida);
    
                elseif app.ModifiedButton.Value
                    imatge_3D_sortida = (BW_final);
                    [imatge_3D_sortida] = graph_text_img(graph_rgbgraybw_image(imatge_3D_sortida));                
                end
             end
    
         % If the image is original or grayscale
         else
            [imatge_3D_sortida] = graph_rgbgraybw_image(BW_final);

         end

     end
    

     % Display in the resulting image
    app.Image.ImageSource = imatge_3D_sortida;
    

    % Obtain number of binary objects:
    app.num_objectes_binarisLabel.Text = obtain_num_BW(BW_final);



    % END OF FUNCTION





end
