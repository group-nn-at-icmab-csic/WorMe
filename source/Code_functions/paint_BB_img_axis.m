function [img_RGB_sortida] = paint_BB_img_axis(img_RGB, BB_prop, eixamplar_BB, eixamplar_BB_value)

% Given an image and a bounding box parameteres, returns the image with the
% bounding box printed. There is the option to modify the width of BoundingBox.
%
%
% Variables
% ---------
% Input
%   img_RGB - RGB image
%   BB_prop - values of bounding box (provinent from imcrop for example).
%           ex: 69.5000  683.5000  991.0000  308.0000
%   eixamplar_BB -  'true' if wants to augment the bounding box width.
%   eixamplar_BB_value - value to expand the bounding box width.
% Output
%   img_RGB_out - RGB image with the bounding box.
%
%
% % Example:
% img_RGB = imageArray_escala;
% imshow(img_RGB)
% [img_RGB_retall, BB_prop] = imcrop(img_RGB); close
% RGB_BB = paint_BB_img(img_RGB, BB_prop);
% imshow(RGB_BB)
% 
% RGB_BB_img_eix = paint_BB_img_axis(img_RGB, BB_prop, true, 1);
% imshow(RGB_BB_img_eix)
%
%
% See also
% wide_indx_BB
% paint_BB_img
% paint_BB_img_axis


% START FUNCTION
    
   
    size_img = [size(img_RGB, 1) size(img_RGB, 2)];
    
    [BB_index_punts] = BBxy_to_BBindx(floor(BB_prop), size_img);
    
    % Widen the indices:
    if eixamplar_BB
        BB_index_punts = wide_indx_BB(BB_index_punts, eixamplar_BB_value, size_img);
    end
    
    [img_RGB_sortida] = paint_indx_to_RGB(img_RGB, BB_index_punts, "red");
    
    
    % imshow(img_RGB_sortida)
% END FUNCTION

end