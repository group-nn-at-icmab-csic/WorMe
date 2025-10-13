function [imageArray_text] = graph_text_img(imageArray)

% Given an image, the text is graphed in proportion.
% Note that the text is defined inside the function code.
%
% See also

% START FUNCTION

% Obtain dimensions
[h_img, l_img, ~] = size(imageArray);
% We will use these as a base to graph the text proportionally.


% Obtain position
pos_text = [h_img*0.1, l_img*0.1];

% Obtain font size
font_text = round(sqrt(sqrt(h_img * l_img)));
% Note: based on the fourth root of the image area

imageArray_text = insertText(imageArray, pos_text, "Too many objects for skeletonization", 'FontSize', font_text, 'BoxColor', 'red', 'BoxOpacity',1);


% END FUNCTION

end