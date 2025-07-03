function [new_object_colored] = paint_BW_color(BW_to_color, color_kind)

% Paint a binary image a given color.
% Colors: "yellow", "magenta", "cyan", "red", "green", "blue", "white", "orange".
% 
%
% Example
% [BW_colored_new] = pintar_BW_color(BW_llistat_imatges, "red");
% imshow(BW_colored_new)
%
%
% See also
% pintar_indx_to_RGB
% BBxy_to_BBindx
% BW_to_BBindx



% START FUNCTION

% List colors and their values

colors_llista = [255 255 0; ... %yellow
    255 0 255; ... %magenta
    0 255 255; ... %cyan
    255 0 0; ... % red
    0 255 0; ...  % green
    0 0 255; ... % blue
    255 255 255; ... % white
    255,165,0]; % orange

color_strings = ["yellow", "magenta", "cyan", "red", "green", "blue", "white", "orange"];

% Check if the color is in the list
[is_memb, posicio_memb] = ismember(color_kind, color_strings);

if is_memb
    valor_color = colors_llista(posicio_memb, :);
else
    f = msgbox('Color indeterminat', 'Error','error');
end


% Paint
new_object_colored = cat(3, BW_to_color .* valor_color(1), BW_to_color .* valor_color(2),  BW_to_color .* valor_color(3));


% END FUNCTION


end