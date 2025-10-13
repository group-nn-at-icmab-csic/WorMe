function [proporcio_img_new] = dimension_output_correction(proporcio_img, size_final)

% Given a position of the measurements, if they exceed the image, they are
% corrected.
%
%
%
% See also
% cut_BB_BW_image_1
% cut_BB_BW_RGB_image


% START FUNCTION

% size_final = size(BW_final)
x_size = size_final(1);
y_size = size_final(2);

% _Possible correction of the measurement output_
proporcio_img_new = proporcio_img;

% IF there are non-positive numbers.
if ismember(1, proporcio_img_new <= 0)
    % The value is changed to 0, and it is added to its width/height.
    % In X:
    if proporcio_img_new(1) <= 0
    valor_x = proporcio_img_new(1);
    proporcio_img_new(3) = proporcio_img_new(3) + valor_x +1;
    proporcio_img_new(1) = 1; % It must be 1, not 0, because we are talking about X,Y positions
    end
    % In Y:
    if proporcio_img_new(2) <= 0
        valor_x = proporcio_img_new(2);
        proporcio_img_new(4) = proporcio_img_new(4) + valor_x +1;
        proporcio_img_new(2) = 1;
    end
end


% If the size of the cropped image is greater than the measurements of the original image:
% In Y
if proporcio_img_new(2) + proporcio_img_new(4) > x_size
    diferencia_x = x_size - (proporcio_img_new(2) + proporcio_img_new(4) );
    proporcio_img_new(4) = proporcio_img_new(4) + diferencia_x;
end

% In X
if proporcio_img_new(1) + proporcio_img_new(3) > y_size
    diferencia_y = y_size - (proporcio_img_new(1) + proporcio_img_new(3) );
    proporcio_img_new(3) = proporcio_img_new(3) + diferencia_y;
end


% END FUNCTION


end