function graficar_rectangle(indx_endpoints, size_BW, grandaria_linia)

% Grafica rectangles dels index indicats d'una imatge binaria
%
%
% Variables:
% indx_endpoints : index on hi anirà el rectangle.
%                 : exemple: indx_endpoints = find(bwmorph(BW_skel_extes,'endpoints'));
% size_BW : grandaria de la imatge
%               : exemple : size_BW = size(BW_skel_extes)
% grandaria_linia : gradaria del rectangle
%                   : exemple:  grandaria_linia = 5;
%
% See also:
% rectangle

% % Exemple funció
% imshow(BW_skel_extes)
% indx_endpoints = find(bwmorph(BW_skel_extes,'endpoints'));
% graficar_rectangle(indx_endpoints, size(BW_skel_extes), 4)

% INICI FUNCIÓ

%imshow(BW_skel_extes)
%indx_endpoints = find(bwmorph(BW_skel_extes,'endpoints'));

% Passem de index a punts xy
[x_endpoints, y_endpoints] = ind2sub(size_BW, indx_endpoints);

% Obtenim els punts del rectangle
rectangle_punts = [y_endpoints - grandaria_linia, x_endpoints-grandaria_linia, repelem(grandaria_linia+grandaria_linia, length(x_endpoints))', repelem(grandaria_linia+grandaria_linia, length(x_endpoints))'];

% Grafiquem el rectangle, cada un
for n_rect = 1:numel(indx_endpoints)
    rectangle("Position", rectangle_punts(n_rect,:), "EdgeColor","r", "LineWidth", 2)
end


% FINAL FUNCIÓ

end