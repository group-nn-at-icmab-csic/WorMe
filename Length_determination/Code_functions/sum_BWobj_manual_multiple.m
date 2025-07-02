function [bwlabel_BW_obj_sumatlinia, imatge_BW_colors, porta_window_drawline, zeros_imatge_cotxe_punts_units] = sum_BWobj_manual_multiple(BWobj_image, im_original, val_exampl)

% Given a single binary image, a line is manually defined with which the binary image is cut.
% Returns a cropped binary image (bwlabel_BW_obj_sumatlinia), as well as
% the cropped color image (imatge_BW_colors).
% This last procedure uses the function f'BW_objects_to_color'.
% If a second color image (3D) is defined, it is overlaid
% (f'imoverlay) on the image when selecting the line.
%
% The image can have more than one binary object, but it must be binary.
% The image will be cropped.
%
% Variables
% ---------
% input:
% BWobj_image : Binary image with a single binary object
% im_original : (optional) Original image to overlay on the binary image
%
% output:
% bwlabel_BW_obj_sumatlinia : BW image with the subtracted line.
% porta_window_drawline : Status flag to check whether or not the function was successfully executed.
% image_BW_colors : Colored BW image
% zeros_image_cotxe_punts_units : Defined line.
%
%
% See also
% BW_objects_to_color


% %Example variable
% bwlabel_BW_obj_sumatlinia2 = BW_listat_images;
% imshow(bwlabel_BW_obj_sumatlinia2)
% BWobj_image = bwlabel_BW_obj_sumatlinia2;

% START FUNCTION

% Draw the line
try

    if exist('im_original','var')
        %imoverlay_Bnorm = imoverlay(im_original, BWobj_image, "r");
        %imoverlay_Bnorm = imoverlay(im_original, BWobj_image, [0 0 0]);
        [imoverlay_Bnorm] = print_RGB_indx_brush(im_original, find(BWobj_image), [1 1 1]*-90);
        s_var = get(0, 'ScreenSize');
        imshow(imoverlay_Bnorm)
        set(gcf,'Units', 'pixels', 'Position',[0 0 s_var(3) s_var(4)])

    else
        s_var = get(0, 'ScreenSize');
        imshow(BWobj_image)
        set(gcf,'Units', 'pixels', 'Position',[0 0 s_var(3) s_var(4)])
    
    end


    try
        h1 = drawpolyline('SelectedColor','yellow');
        % h2 = drawline('SelectedColor','magenta');
        h1.Selected = true;
    
        % Position of the line points
        ep = h1.Position;
        % Rounding positions
        ep_rounded = round(ep);
    
        close
    
        if isempty(ep)
            porta_window_drawline = false;
        else
            porta_window_drawline = true;
        end


    catch
        porta_window_drawline = false;

        % Defining variables:
        bwlabel_BW_obj_sumatlinia = false;
        imatge_BW_colors = false;
        zeros_imatge_cotxe_punts_units = false;



    end
    
    if porta_window_drawline
        % DEFINE THE LINE IN THE BINARY IMAGE
        
        % Image made from zeroes equal to the initial image
        [xd1, xd2, ~] = size(BWobj_image);
        zeros_imatge_cotxe = zeros(xd1, xd2);
        %size(zeros_imatge_cotxe)
        %imshow(zeros_imatge_cotxe)
        
        % Draw the points in the image made from zeroes
        for cada_lin = 1:length(ep_rounded)
            %zeros_imatge_cotxe(ep_rounded(cada_lin,2), ep_rounded(cada_lin,1)) = 1;
            
            if cada_lin > 1
                % Make a blank image with zeroes and add the two pixels
                zeros_imatge_cotxe_blanc = zeros(xd1, xd2);
                
                % Front point
                zeros_imatge_cotxe_blanc(ep_rounded(cada_lin-1,2), ep_rounded(cada_lin-1,1)) = 1;   
                % Back point
                zeros_imatge_cotxe_blanc(ep_rounded(cada_lin,2), ep_rounded(cada_lin,1)) = 1;
                
        
                % Draw the line
                zeros_imatge_cotxe_blanc_linea = bwconvhull(zeros_imatge_cotxe_blanc);
                
                % Add the line to the main image made from zeroes
                zeros_imatge_cotxe = zeros_imatge_cotxe + zeros_imatge_cotxe_blanc_linea;
            end
        end
        
        % Equal the values
        zeros_imatge_cotxe = zeros_imatge_cotxe>0;
        
        
        % The line must be thick, as a single pixel cannot separate the image.
        zeros_imatge_cotxe_punts_units = bwmorph(zeros_imatge_cotxe, 'diag');
        
        
        % Widen the pixels of the line
        [total_indx_fin] = eixamplar_indx_BB(find(zeros_imatge_cotxe_punts_units), val_exampl, size(zeros_imatge_cotxe_punts_units));
        zeros_imatge_cotxe_punts_units(total_indx_fin) = 1;
        
        
        % SUBSTRACT THE LINE FROM THE INITIAL BINARY IMAGE
        bwlabel_BW_obj_sumatlinia = BWobj_image + zeros_imatge_cotxe_punts_units;
        bwlabel_BW_obj_sumatlinia = bwlabel_BW_obj_sumatlinia > 0;
        %unique(bwlabel_BW_obj_sumatlinia)
        
        [imatge_BW_colors, ~, ~] = BW_objects_to_color(bwlabel_BW_obj_sumatlinia);
        %imshow(imatge_BW_colors)
        
        
        % % Example back image skeletonization
        % bwlabeled_obj_tot = bwlabel(bwlabel_BW_obj_sumatlinia);
        % bwlabeled_obj_tot_2 = bwlabeled_obj_tot == 2;
        % imshow(bwlabeled_obj_tot_2)
        % 
        % [~, ~, sfMaskBurn_newfunction, ~, ~] = ...
        %     esqueletonitzacio_josep(bwlabeled_obj_tot_2, imageArray, escala_imatge, 1);
        % imshow(sfMaskBurn_newfunction)

    else

        bwlabel_BW_obj_sumatlinia = false;
        imatge_BW_colors = false;
        porta_window_drawline = false;
        zeros_imatge_cotxe_punts_units = false;

    end

catch
    
    % If there is an error, such as the draw window being closed,
    % we return the status flag 'porta_window_drawline' as 'false'
    % so that it can be announced outside the function that there
    % is an error, so the action must be repeated if needed.
    % The binary objects are returned without any modification.

    porta_window_drawline = false;

    % Define variables:
    bwlabel_BW_obj_sumatlinia = false;
    imatge_BW_colors = false;
    zeros_imatge_cotxe_punts_units = false;   


end
% END FUNCTION

end
