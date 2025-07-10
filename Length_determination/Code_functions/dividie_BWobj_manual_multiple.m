function [bwlabel_BW_obj_sumline, image_BW_colors, door_window_drawline, defined_line] = dividie_BWobj_manual_multiple(BWobj_image, im_original)

% Given a singular binary image, manually define a line that cuts the binary image.
% Returns a cropped binary image (bwlabel_BW_obj_sumline),
% the cropped color image (image_BW_colors), and the line (defined_line).
% This last procedure uses the function f'BW_objects_to_color'.
% If a second color image (3D) is defined, it is overlaid
% (f'imoverlay) on the image when selecting the line.
%
% The image can have more than one binary object, but it must be binary.
% The image will be cropped.
%
%
% Variables
% ---------
% input:
% BWobj_image : Binary image with a single binary object
% im_original : (optional) Original image to overlay on the binary
%
% output:
% bwlabel_BW_obj_sumline : BW image with the line subtracted.
% door_window_drawline : Status flag to check whether or not the function was successfully executed.
% image_BW_colors : Colorized BW image
% defined_line : Defined line.
%
%
% See also
% BW_objects_to_color

% START FUNCTION

% We draw the line
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
        % We round positions
        ep_rounded = round(ep);
    
        close
    
        if isempty(ep)
            door_window_drawline = false;
        else
            door_window_drawline = true;
        end


    catch
        door_window_drawline = false;

        % Variable definition
        bwlabel_BW_obj_sumline = false;
        image_BW_colors = false;
        defined_line = false;



    end
    
    if door_window_drawline
        % DEFINITION OF THE LINE IN THE BINARY IMAGE
        
        % Image made from zeroes equal to the initial image
        [xd1, xd2, ~] = size(BWobj_image);
        zeros_imatge_cotxe = zeros(xd1, xd2);
        %size(zeros_imatge_cotxe)
        %imshow(zeros_imatge_cotxe)
        
        % Draw the points in the image made from zeroes
        for cada_lin = 1:length(ep_rounded)
            %zeros_imatge_cotxe(ep_rounded(cada_lin,2), ep_rounded(cada_lin,1)) = 1;
            
            if cada_lin > 1
                % We make a blank zeros image and add the two pixels
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
        
        % Match the values
        zeros_imatge_cotxe = zeros_imatge_cotxe>0;
        
        % The line must be thick, as a single pixel cannot separate the image.
        defined_line = bwmorph(zeros_imatge_cotxe, 'diag');
        
        % SUBSTRACT THE LINE FROM THE INITIAL BINARY IMAGE
        bwlabel_BW_obj_sumline = BWobj_image - defined_line;
        bwlabel_BW_obj_sumline(bwlabel_BW_obj_sumline == -1) = 0;
        %unique(bwlabel_BW_obj_sumline)
        
        [image_BW_colors, ~, ~] = BW_objects_to_color(bwlabel_BW_obj_sumline);
        %imshow(image_BW_colors)


    else

        bwlabel_BW_obj_sumline = false;
        image_BW_colors = false;
        door_window_drawline = false;
        defined_line = false;

    end

catch

    % If there is an error, such as the draw window being closed,
    % we return the status flag 'porta_window_drawline' as 'false'
    % so that it can be announced outside the function that there
    % is an error, so the action must be repeated if needed.
    % The binary objects are returned without any modification.
    
    door_window_drawline = false;

    % Define variables:
    bwlabel_BW_obj_sumline = false;
    image_BW_colors = false;
    defined_line = false;   


end
% END FUNCTION



end
