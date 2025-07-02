function [imageArray_new] = pintar_BWindx_RGB_new(imageArray, imageArray_crop, indx_BWobj, indx_BWobj_escalat)

% Given a region of an image, as RGB and binary, this section is introduced to the original image.
%
% This function is useful for to process regions of a whole image and then
% re-introduce that in the original one, optimizing the process by this
% way.
% Methodology based on the object indexs, and the scaled image.
%
% Variables
% ---------
% 
% Variables
%   input
%       imageArray      - RGB original image
%       imageArray_crop - RGB cropped image
%       indx_BWobj      - index of the binary objects in retailed image
%       indx_BWobj_escalat - index of the binary object, scaled in the original image. 
%   output
%       imageArray_new - original image modified by the rgb region
%
% Processment time: 0.0065s (50 loops, 8Gb Ram)
% 
% Example:
% montage({BW_filt, BW_filt_crop, imageArray, imageArray_crop_new})
% [imageArray_new] = pintar_BWindx_RGB_new(imageArray, imageArray_crop+75, find(BW_filt_crop), find(BW_final));
% imshow(imageArray_new)
%
% See also
% escalar_indx
% retallar_BWRGBimatge_BB


% START FUNCTION
imageArray_new = imageArray;

[x_rgbc, y_rgbc, ~] = size(imageArray_crop);
rgb_perim = x_rgbc * y_rgbc;
indx_BWobj_new = [indx_BWobj; indx_BWobj + rgb_perim; indx_BWobj + rgb_perim*2];

[x_rgbc, y_rgbc, ~] = size(imageArray);
rgb_perim = x_rgbc * y_rgbc;
indx_BWobj_escalat_new = [indx_BWobj_escalat; indx_BWobj_escalat + rgb_perim; indx_BWobj_escalat + rgb_perim*2];

imageArray_new(indx_BWobj_escalat_new) = imageArray_crop(indx_BWobj_new);
%imshow(imageArray_new)

% END FUNCTION

end