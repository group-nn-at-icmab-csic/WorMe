function [proporcio_img] = comprovacio_size_posicio(proporcio_img, size_imatge)

% Given the position of an image (ex: 1 985 176 95), [x y w h]
% this is returned without there being any overhangs of
% it, that is, without it being possible for it to exceed the dimensions of the
% image, or for it to be less than x or y.

% START FUNCTION

x_size = size_imatge(1);
y_size = size_imatge(2);

% If there is negative values.
if ismember(1, proporcio_img < 0)
    % Change the value for 0, and is sum the width/length of it.
    % En X:
    if proporcio_img(1)<0
    valor_x = proporcio_img(1);
    proporcio_img(3) = proporcio_img(3) + valor_x +1;
    proporcio_img(1) = 1; % % It must be 1, not 0, because we are talking about X,Y positions
    end
    % En Y:
    if proporcio_img(2)<0
        valor_x = proporcio_img(2);
        proporcio_img(4) = proporcio_img(4) + valor_x +1;
        proporcio_img(2) = 1;
    end
end


% If the cropped image size is greater than the initial image measurements:
% In Y
if proporcio_img(2) + proporcio_img(4) > x_size
    diferencia_x = x_size - (proporcio_img(2) + proporcio_img(4) );
    proporcio_img(4) = proporcio_img(4) + diferencia_x;
end

% En X
if proporcio_img(1) + proporcio_img(3) > y_size
    diferencia_y = y_size - (proporcio_img(1) + proporcio_img(3) );
    proporcio_img(3) = proporcio_img(3) + diferencia_y;
end


end

% EN OF THE FUNCTION