function [RGB_to_color_new] = pintar_indx_to_RGB(RGB_to_color, indx_to_paint, color_determinat)

% Given an RGB image, the indices of the 
% first matrix of the image are printed, based on a given color.
% For example, given BoundingBox indices of a binary image, 
% these are painted with a certain color in an RGB image.
%
%
% Variables
% ---------
% input
%   RGB_to_color - RGB image
%   indx_to_paint - index of the BW image
%   color_determinat - color type ["yellow", "magenta", "cyan", "red", "green", "blue", "white", "orange", "black"]
%
% output
%   RGB_to_color_new - RGB image with the colored pinted in the index regions.
% 
%
% See also
% BBxy_to_BBindx
% eixamplar_indx_BB

% START FUNCTION

% List colors and their values

colors_llista = [255 255 0; ... %yellow
    255 0 255; ... %magenta
    0 255 255; ... %cyan
    255 0 0; ... % red
    0 255 0; ...  % green
    0 0 255; ... % blue
    255 255 255; ... % white
    255,128,0; ... % orange
    0, 0, 0]; % black 

color_strings = ["yellow", "magenta", "cyan", "red", "green", "blue", "white", "orange", "black"];

% Check if the color is in the list
[is_memb, posicio_memb] = ismember(color_determinat, color_strings);

if is_memb
    valor_color = colors_llista(posicio_memb, :);
else
    f = msgbox('Color indeterminat', 'Error','error');
end


% Paint
size_RGB_to_color = size(RGB_to_color);
sup_RGB_to_color = size_RGB_to_color(1) * size_RGB_to_color(2); % Area of the image (w*h)

RGB_to_color_new = RGB_to_color;

RGB_to_color_new(indx_to_paint) = 1 * valor_color(1);
RGB_to_color_new(indx_to_paint + sup_RGB_to_color) = valor_color(2);
RGB_to_color_new(indx_to_paint + (sup_RGB_to_color)*2) = valor_color(3);

%imshow(RGB_to_color)

% END FUNCTION


end