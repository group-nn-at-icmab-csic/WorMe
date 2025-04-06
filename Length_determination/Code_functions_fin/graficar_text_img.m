function [imageArray_text] = graficar_text_img(imageArray)

% Given an image, the text is graphed in proportion.
% Note that the text is defined inside the function code... (see graficar_text_img_main)
%
% See also
% graficar_text_img_main

% INICI FUNCIÓ

% Obtneim dimensions
[h_img, l_img, ~] = size(imageArray);
% Amb aquestes ens basarem per a graficar el text de manera proporcional.


% Obtenim posicio
pos_text = [h_img*0.1, l_img*0.1];

% Obtenim la grandaria de la font
font_text = round(sqrt(sqrt(h_img * l_img)));
% Nota: ens basem en l'arrel cuarta de l'àrea de la imatge.

imageArray_text = insertText(imageArray, pos_text, "Too many objects for skeletonization", 'FontSize', font_text, 'BoxColor', 'red', 'BoxOpacity',1);


% FINAL FUNCIÓ

end