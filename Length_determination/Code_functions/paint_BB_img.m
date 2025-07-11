function [img_RGB_out] = paint_BB_img(img_RGB, BB_prop)

% Print the bounding box parameter in an image. The width of bounding box is 1 pixel.
%
% Variables
% ---------
% Input
%   img_RGB - RGB image
%   BB_prop - values of bounding box (coming from imcrop for example).
%           ex: 69.5000  683.5000  991.0000  308.0000
% Output
%   img_RGB_out - RGB image with the bounding box.
%
% Example:
% img_RGB = imageArray_escala;
% imshow(img_RGB)
% [img_RGB_retall, BB_prop] = imcrop(img_RGB); close
% RGB_BB = paint_BB_img(img_RGB, BB_prop);
% imshow(RGB_BB)
% 
% See also
% wide_indx_BB
% paint_BB_img_axis


% START FUNCTION
   
    size_img = [size(img_RGB, 1) size(img_RGB, 2)];
    
    [BB_index_punts] = BBxy_to_BBindx(floor(BB_prop), size_img);
    
    
    [img_RGB_out] = paint_indx_to_RGB(img_RGB, BB_index_punts, "red");
    
    
    % imshow(img_RGB_out)
% END FUNCTION

end