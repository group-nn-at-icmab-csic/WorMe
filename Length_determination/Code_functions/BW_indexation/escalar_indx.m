function [indx_BW_scal] = escalar_indx(indx_BWcrop, size_BW, size_BWcrop, proporcio_img)

% Given a cropped binary image, this function returns
% the indices of this image in the scaled image.
%
% Variables
% indx_BWcrop - Indices of the object(s) in the cropped binary image
% size_BW - Dimensions of the binary image
% size_BWcrop - Dimensions of the cropped binary image
% proporcio_img - Proportion measurements of the cropping (obtained from the function retallar_BWRGBimatge_BB)
%
%
% Processing time: 0.0018s (50 loops, 8GB Ram)
%
% Example:
% montage({BW_filt, BW_filt_crop, imageArray, imageArray_crop_new})
% % Scalar index function (f'escalar_indx)
% [indx_BW_scal] = escalar_indx(indx_BWobj, size(BW_filt), size(BW_filt_crop), proporcio_img);
% % Print the region function
% [imageArray_new] = pintar_BWindx_RGB(imageArray, imageArray_crop_new, indx_BWobj, indx_BWobj_escalat);
% imshow(imageArray_new)
%
%
% % _Example 2_
% imshow(BW_final)
% [BW_ini_regio_cropped, BB_values, proporcio_img_new] = retallar_BWimatge_BB_2(BW_final, 4);
% imshow(BW_ini_regio_cropped)
% 
% % Obtain the indices
% [indx_BW_scal] = escalar_indx(find(BW_ini_regio_cropped), size(BW_final), size(BW_ini_regio_cropped), proporcio_img_new);
% 
% % Compare indices:
% unique(find(BW_final) == indx_BW_scal)
% 
% % Visual comparison:
% BW_scaled = false(size(BW_final));
% BW_scaled(indx_BW_scal) = true;
% imshowpair(BW_scaled, BW_final)
%
% See also
% retallar_BWRGBimatge_BB_nou
% pintar_BWindx_RGB_new

% START FUNCTION

% Get x,y from the cropped image
[x_BWobj, y_BWobj] = ind2sub(size_BWcrop, indx_BWcrop);

% Scale the values
x_BWobj_nou = x_BWobj + proporcio_img(2) -1; %Substract 1 to correct the sum.
y_BWobj_nou = y_BWobj + proporcio_img(1) -1; %Substract 1 to correct the sum.

% Obtain the indices
indx_BW_scal = sub2ind(size_BW, x_BWobj_nou, y_BWobj_nou);

% END FUNCTION

end