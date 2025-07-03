function [imageArray_text] = graficar_text_img_main(imageArray, por_h, por_l, text_img, color_box, box_opacity)

% Given an image and a text, draw the text into it as described.
%
% Note: It uses mainly the insertText MATLAB function.
%
%
% Variables
%   input:
%       imageArray: main RGB image
%       por_h & por_l: relative positions of the box. 
%           ex: 0.1, 0.6. Means from the initial or final proportion.
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

% Obtain dimensions
[h_img, l_img, ~] = size(imageArray);
% We will use these as a base to graph the text proportionally.


% Obtain position
pos_text = [h_img * por_h, l_img * por_l];

% Obtain font size
font_text = round(sqrt(sqrt(h_img * l_img)));
% Note: based on the fourth root of the image area

imageArray_text = insertText(imageArray, pos_text, text_img, 'FontSize', font_text, 'BoxColor', color_box, 'BoxOpacity', box_opacity);

% END FUNCTION

end