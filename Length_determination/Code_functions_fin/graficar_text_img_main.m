function [imageArray_text] = graficar_text_img_main(imageArray, por_h, por_l, text_img, color_box, box_opacity)

% Given an image and a text, it is drawed into it as characteristics are descrived.
%
% Note: It uses mainly the insertText MATLAB function.
%
%
% Variables
%   input:
%       imageArray: main RGB image
%       por_h & por_l: relative positions of the box. ex: 0.1, 0.6. Means from the initial or final proportion.
%           ex: 0.5 and 0.5 the text will be in the middle of the image.
%       text_img: text to write in the image.
%           ex: "Hello little worm"
%       color_box: Box color. ex: 'red'
%           Supported colors: 'blue', 'green', 'red', 'cyan', 'magenta', 'yellow','black', and 'white'.
%       box_opacity: box opacity. ex: 1
%
%   output:
%       imageArray_text - image with the text described.
%
% Example:
%       [imageArray_text] = graficar_text_img_main(imageArray, 0.1, 0.1, "Hello worm", "red", 0.8);
%       imshow(imageArray_text)
%
% See also
% insertText


% START FUNCTION

% Obtneim dimensions
[h_img, l_img, ~] = size(imageArray);
% Amb aquestes ens basarem per a graficar el text de manera proporcional.


% Obtenim posicio
pos_text = [h_img * por_h, l_img * por_l];

% Obtenim la grandaria de la font
font_text = round(sqrt(sqrt(h_img * l_img)));
% Nota: ens basem en l'arrel cuarta de l'àrea de la imatge.

imageArray_text = insertText(imageArray, pos_text, text_img, 'FontSize', font_text, 'BoxColor', color_box, 'BoxOpacity', box_opacity);


% END FUNCTION

end