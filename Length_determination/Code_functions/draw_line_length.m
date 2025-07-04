function [dades_imatge, dades_imatge_punts, zeros_imatge_cotxe, porta_window_drawline, ep_rounded] = draw_line_length(im_original, escala_imatge)
% Given an original image, a line is drawn on it, and the measurement is obtained.
%
%
% Variables
% ---------
% input:
%   im_original : (optional) Original image to overlay on the binary image
%   escala_imatge : image scale.
%
% output:
%   dades_imatge : length of the line pixel by pixel
%   dades_imatge_punts : length of the line only at certain positions (Fiji error)
%   zeros_imatge_cotxe : skeletonized image
%   porta_window_drawline : indicator whether the function executed correctly or not.
%   ep_rounded : points of the image.
%
% See also
% dividie_BWobj_manual_multiple

% START OF FUNCTION

% Draw line

try
    

    s_var = get(0, 'ScreenSize');
    imshow(im_original)
    set(gcf,'Units', 'pixels', 'Position',[0 0 s_var(3) s_var(4)])



    h1 = drawpolyline('Color', 'Yellow', 'SelectedColor','yellow');
    % h2 = drawline('SelectedColor','magenta');
    h1.Selected = true;

    % Position of the points in the line
    ep = h1.Position;
    % Round positions
    ep_rounded = round(ep);





    close

    
    if isempty(ep)
        porta_window_drawline = false;
    else
        porta_window_drawline = true;
    end
    
    % DEFINE LINE IN BINARY IMAGE 

    % Image of zeros same as the initial one
    [xd1, xd2, ~] = size(im_original);
    zeros_imatge_cotxe = zeros(xd1, xd2);
    %size(zeros_imatge_cotxe)
    %imshow(zeros_imatge_cotxe)
    
   % We print dots in image of zeros
    for cada_lin = 1:length(ep_rounded)
        %zeros_imatge_cotxe(ep_rounded(cada_lin,2), ep_rounded(cada_lin,1)) = 1;
        
        if cada_lin > 1
            % Make a blank zeros image containing the two pixels
            zeros_imatge_cotxe_blanc = zeros(xd1, xd2);
            
            % Anterior point
            zeros_imatge_cotxe_blanc(ep_rounded(cada_lin-1,2), ep_rounded(cada_lin-1,1)) = 1;   
            % Posterior point
            zeros_imatge_cotxe_blanc(ep_rounded(cada_lin,2), ep_rounded(cada_lin,1)) = 1;
            
    
            % We make the line
            zeros_imatge_cotxe_blanc_linea = bwconvhull(zeros_imatge_cotxe_blanc);
            
            % We sum it to the main zeros image
            zeros_imatge_cotxe = zeros_imatge_cotxe + zeros_imatge_cotxe_blanc_linea;
        end
    end
    
    % Equal the values
    zeros_imatge_cotxe = zeros_imatge_cotxe>0;
    
    % This is the skeletonized image.
    
    % imshow(zeros_imatge_cotxe)
    
    % _Check_ that it is a single skeletonized image, and that it has no widths:
    BWskel_zeros_imatge_cotxe = bwskel(zeros_imatge_cotxe);
    
    if unique(BWskel_zeros_imatge_cotxe  == zeros_imatge_cotxe) ~= 1
        error("error in draw_line_length: it is not an skel image?")
        porta_window_drawline = false;
    end
    
    
    % ___Obtaining the numerical length___
    
    % _By sum of pixels of the defined skeletonized image_
    [Area_Josep] = worm_length(zeros_imatge_cotxe); % LLargada Josep de la imatge esqueletonitzada
    % You could incorporate: worm_length_manual, but it is more accurate to
    % determine by the points defined in the draw, how it is done and obtained
    % dades_imagte_2

    Area_Josep_scaled = Area_Josep / escala_imatge; % Multiplies by the scale ratio (pixels / unit)
    
    dades_imatge = Area_Josep_scaled;

    % _By sum of the distance between the defined points (Fiji error)_
    [Area_Josep2] = ditancia_varis_punts(ep_rounded); % Legth of the defined points.    

    Area_Josep_scaled_2 = Area_Josep2 / escala_imatge; % Multiplies by the scale ratio (pixels / unit)
    
    dades_imatge_punts = Area_Josep_scaled_2;
    

catch
    % If there is a failure, such as the draw window being closed,
% what is done is to return the port counter
% v'porta_window_drawline' as 'false', so that it can be announced outside the
% function that there is a failure, and that it must be repeated, or not.
% The binary objects are returned without any modification to them.
    
   porta_window_drawline = false; 
   
   dades_imatge = 0;
   dades_imatge_punts = 0;
   zeros_imatge_cotxe = false;
   ep_rounded = [];

end


% FINAL OF THE FUNCIÓN


end