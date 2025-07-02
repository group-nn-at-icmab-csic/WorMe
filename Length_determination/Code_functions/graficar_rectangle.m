function graficar_rectangle(indx_endpoints, size_BW, grandaria_linia)

% Plots rectangles at the indicated indexes on a binary image
%
%
% Variables:
% indx_endpoints : index where the rectangle will be placed.
%                  example: indx_endpoints = find(bwmorph(BW_skel_extes,'endpoints'));
% size_BW : size of the image
%           example: size_BW = size(BW_skel_extes)
% grandaria_linia : size of the rectangle
%                  example: grandaria_linia = 5;
%
% See also:
% rectangle

% % Example function

% imshow(BW_skel_extes)
% indx_endpoints = find(bwmorph(BW_skel_extes,'endpoints'));
% graficar_rectangle(indx_endpoints, size(BW_skel_extes), 4)

% START OF THE FUNCTION

%imshow(BW_skel_extes)
%indx_endpoints = find(bwmorph(BW_skel_extes,'endpoints'));

% Fomr index to xy points
[x_endpoints, y_endpoints] = ind2sub(size_BW, indx_endpoints);

% Rectangle points obtantion:
rectangle_punts = [y_endpoints - grandaria_linia, x_endpoints-grandaria_linia, repelem(grandaria_linia+grandaria_linia, length(x_endpoints))', repelem(grandaria_linia+grandaria_linia, length(x_endpoints))'];

% Graph the rectangle, each:
for n_rect = 1:numel(indx_endpoints)
    rectangle("Position", rectangle_punts(n_rect,:), "EdgeColor","r", "LineWidth", 2)
end


% FINAL OF THE FUNCIÓ

end