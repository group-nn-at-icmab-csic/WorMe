function [imatge_3D_sortida] = graph_rgbgraybw_image(imatge_input)

% Given any kind of image (rgb, gray, BW), returns the 3 dimensional image,
% mainly for their graphication.
% This helps solving problems when graphing non rgb images.
%
% Example :
%   class(graph_rgbgraybw_image(BW_final))
%   size(graph_rgbgraybw_image(BW_final))
%   max(graph_rgbgraybw_image(BW_final(:)))
% 
%   imshow(insertText(graph_rgbgraybw_image(BW_final), [100,200], "Hola", 'FontSize',50))


% START FUNCTION

[~, ~, dim_im] = size(imatge_input); % Dimensions

if dim_im == 3
    % The image is RGB, no need to modify
    imatge_3D_sortida = imatge_input;
elseif dim_im ~= 1
    error("Error in f'graph_rgbgraybw_image', the dimensions are neither 3 nor 1", "")
else
    % The dimensions are 1
    % The image is either binary or grayscale.
    
    if ~islogical(imatge_input)
        % If the image is grayscale
        % Convert to 3D
        imatge_3D_sortida = cat(3, imatge_input, imatge_input, imatge_input);
    else
        % Otherwise, it is binary
        % Convert to 3D
        imatge_3D_sortida = cat(3, imatge_input.* 255, imatge_input.* 255, imatge_input .* 255);

    end
end

% END FUNCTION


end