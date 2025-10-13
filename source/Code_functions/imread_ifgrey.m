function [imatge_original] = imread_ifgrey(ruta_imatge_original)

% Read the image: transform to rgb if it is grayscale.

imatge_original = imread(ruta_imatge_original);

% If the image is black and white it is converted to rgb
if numel(size(imatge_original)) == 2
    % Convert black and white image to RGB (does not change)
    imatge_original = cat(3, imatge_original, imatge_original, imatge_original);

else
    
end



end