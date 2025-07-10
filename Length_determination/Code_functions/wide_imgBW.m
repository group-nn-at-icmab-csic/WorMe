function [BW_img_final] = wide_imgBW(BW_img, value_eixmp)

% Given an BW image, the line of it is extended to desired value. Useful for to swell skeletonize images or bounding boxes.
%
% Variables
%   input
%       BW_img - Binary image
%       value_eixmp - value to swall the image (1, 2, 3..) . 1 = 1 pixe.
%   output
%       BW_img_final - Binary resulted image.
%
%
% % Example:
% [BW_img_final] = wide_imgBW(BW_skel_raw, 2);
% imshow(imoverlay(BW_ini_regio_cropped, BW_skel_raw, "r"))
% imshow(imoverlay(BW_ini_regio_cropped, BW_img_final, "r"))
%
%
%
%
% See also:


% START FUNCTION

indx_BWskel_obj = find(BW_img);
size_BW_objecte_skel= size(BW_img);

[indx_BWskel_obj_eixamp] = wide_indx_BB(indx_BWskel_obj, value_eixmp, size_BW_objecte_skel);

BW_img_final = zeros(size(BW_img));
BW_img_final(indx_BWskel_obj_eixamp) = true;

% END FUNCTION

end