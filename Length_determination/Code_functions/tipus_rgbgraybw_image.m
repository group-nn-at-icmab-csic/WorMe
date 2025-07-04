function [tipus_imatge] = tipus_rgbgraybw_image(imatge_input)

% Given an image (rgb, gray or BW), the image type is returned ('image_type'), 
% in the form of the string "rgb", "gray", or "binary".

% START FUNCTION

[~, ~, dim_im] = size(imatge_input); % Dimensions

if dim_im == 3
    % The image is RGB
    tipus_imatge = "rgb";
elseif dim_im ~= 1
    error("Error in f'graficar_rgbgraybw_image', the dimensions are neither 3 nor 1", "")
else
    % The dimensions are 1
    % The image is either binary or grayscale.
    
    if ~islogical(imatge_input)
        % The image is grayscale
        tipus_imatge = "gray";
    else
        % Otherwise, it is binary
        tipus_imatge = "binary";

    end
end

% END FUNCTION


end