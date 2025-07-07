function [RGB_to_color_new] = print_RGB_indx_brush(RGB_to_color, indx_to_paint, value_color)

% Given an RGB image, its regions are painted with addition or subtraction of the values.
% That is, the values in the RGB arrays are added, respectively.
% The indexes refer to a binary image.
% 
% __Variables__
% input:
% RGB_to_color : RGB image
% indx_to_paint : index of the BW image
% value_color : array with the variation of colors. Ex: [12 43 0]
% 
% output:
% BRG_to_color_new : resultant image
%
% Example:
% [imageArray_new] = print_RGB_indx_brush(imageArray, indx_to_paint, [120 0 -80]);
% imshow(imageArray_new)
% 
% See also
% pintar_indx_to_RGB


% START FUNCTION

% Paint
size_RGB_to_color = size(RGB_to_color);
sup_RGB_to_color = size_RGB_to_color(1) * size_RGB_to_color(2); % Image area (w*h)

RGB_to_color_new = RGB_to_color;

% We add to each color matrix (RGB) the indicated value:
RGB_to_color_new(indx_to_paint) = RGB_to_color_new(indx_to_paint) + value_color(1);
RGB_to_color_new(indx_to_paint + sup_RGB_to_color) = RGB_to_color_new(indx_to_paint + sup_RGB_to_color) + value_color(2);
RGB_to_color_new(indx_to_paint + (sup_RGB_to_color)*2) = RGB_to_color_new(indx_to_paint + (sup_RGB_to_color)*2) + value_color(3);


% END FUNCTION


end