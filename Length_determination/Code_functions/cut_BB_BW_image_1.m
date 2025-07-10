function [BW_ini_regio_cropped, proporcio_img] = cut_BB_BW_image_1(BW_ini_regio, percentatge_img_origin)

% Given a binary image with just one binary object, a bounding box is generated and
% we obtain the cropped region, and its data (proportions, coordinates).
% Function used for optimization
%
% Like cut_BB_BW_image_2
%
%
% Variables 
% BW_ini_regio : binary image with one binary object
%
% percentatge_img_origin :  percentage by which the bounding box of the binary object will be enlarged. 
%                           It needs to be larger if you want to obtain regions outside the initial 
%                           bounding box (for example, when the tail is not selected).
%
% Output
% BW_ini_regio_cropped : cropped binary image
%
%
% Funcions relacionades
% extend_img_regions : per a juntar la imatge retallada, amb les
% proporcions determinades, una vegada obtinguda.
%
%
% 
% 
%
%
% See also
% extend_img_regions
% cut_BB_BW_RGB_image

% START FUNCTION

[x_size, y_size] = size(BW_ini_regio); %ex: 1080        1920

prop_regions_BW = regionprops(BW_ini_regio,'BoundingBox');  %<--- relevant
[valor_percentual_imatge] = img_percentage(BW_ini_regio, percentatge_img_origin);

proporcio_img = round(prop_regions_BW.BoundingBox + valor_percentual_imatge .* [-1 -1 2 2]);

% Initial old ratio (BB cut check)
% [BW_ini_regio_cropped] = imcrop(BW_ini_regio, proporcio_img);        %The image is cropped based on the BoundingBox.
%imshow(BW_ini_regio_cropped)
%size(BW_ini_regio_cropped)

% If negative number.
if ismember(1, proporcio_img < 0)
    % The value is changed by 0, and added to its width/length.
    % In X:
    if proporcio_img(1)<0
    valor_x = proporcio_img(1);
    proporcio_img(3) = proporcio_img(3) + valor_x +1;
    proporcio_img(1) = 1;   % It must be 1, not 0, because we are talking about X,Y positions
    end
    % In Y:
    if proporcio_img(2)<0
        valor_x = proporcio_img(2);
        proporcio_img(4) = proporcio_img(4) + valor_x +1;
        proporcio_img(2) = 1;
    end
end


% If the size of the cropped image is greater than the measurements of the initial image:
% In Y
if proporcio_img(2) + proporcio_img(4) > x_size
    diferencia_x = x_size - (proporcio_img(2) + proporcio_img(4) );
    proporcio_img(4) = proporcio_img(4) + diferencia_x;
end

% In X
if proporcio_img(1) + proporcio_img(3) > y_size
    diferencia_y = y_size - (proporcio_img(1) + proporcio_img(3) );
    proporcio_img(3) = proporcio_img(3) + diferencia_y;
end


[BW_ini_regio_cropped] = imcrop(BW_ini_regio, proporcio_img);        %Cut the image based in the BoundingBox.
% imshow(BW_ini_regio_cropped)
% size(BW_ini_regio_cropped)


% END FUNCTION

end