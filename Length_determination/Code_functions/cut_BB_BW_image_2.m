function [BW_ini_regio_cropped, BB_values, proporcio_img_new] = cut_BB_BW_image_2(BW_ini_regio, percentatge_img_origin)

% Given a binary image with just one binary object, a bounding box is generated and
% we obtain the cropped region, and its data (proportions, coordinates).
% Function used for optimization
%
%
% UPGRADE from cut_BB_BW_RGB_image: remove RGB.
%
% Variables 
% BW_ini_regio : binary image with one binary object
%
% percentatge_img_origin :  percentage by which the bounding box of the binary object will be enlarged. 
%                           It needs to be larger if you want to obtain regions outside the initial 
%                           bounding box (for example, when the tail is not selected).
%
% Output
% BW_ini_regio_cropped : cropped binary image
%
% Example crop and rescaling of cropped image:
% imshow(BW_final_object)
% [imageArray_crop, BW_filt_crop, prop_BB, proporcio_img] = cut_BB_BW_RGB_image(imageArray, BW_final_object, 5);
% imshow(BW_filt_crop)
% 
% BW_img_final_sized = extend_img_regions(BW_final_object, proporcio_img, BW_filt_crop);
% imshow(BW_img_final_sized)
% 
% unique(BW_img_final_sized == BW_final_object)
%
%
% % % _Example 2_
% imshow(BW_final)
% [BW_ini_regio_cropped, BB_values, proporcio_img_new] = cut_BB_BW_image_2(BW_final, 4);
% imshow(BW_ini_regio_cropped)
% 
% % Obtain the indices
% [indx_BW_scal] = scale_indx(find(BW_ini_regio_cropped), size(BW_final), size(BW_ini_regio_cropped), proporcio_img_new);
% 
% % Compare the indices:
% unique(find(BW_final) == indx_BW_scal)
% 
% % Visual comparison:
% BW_scaled = false(size(BW_final));
% BW_scaled(indx_BW_scal) = true;
% imshowpair(BW_scaled, BW_final)
%
%
% See also
% retallar_BWRGBimatge_BB
% cut_BB_BW_RGB_image
% extend_img_regions
% dimension_output_correction

% START FUNCTION 

prop_regions_BW = regionprops(BW_ini_regio,'BoundingBox');  %<--- relevant
[valor_percentual_imatge] = img_percentage(BW_ini_regio, percentatge_img_origin);

BB_values = prop_regions_BW.BoundingBox;

proporcio_img = round(prop_regions_BW.BoundingBox + valor_percentual_imatge .* [-1 -1 2 2]);

% Old initial proportions
%[BW_ini_regio_cropped] = imcrop(BW_ini_regio, proporcio_img);        %Cut the image based in the BoundingBox.
%imshow(BW_ini_regio_cropped)
%size(BW_ini_regio_cropped)

% _Correct possible out of bounds measurements_
[proporcio_img_new] = dimension_output_correction(proporcio_img, size(BW_ini_regio)); %ex: 1080        1920


[BW_ini_regio_cropped] = imcrop(BW_ini_regio, proporcio_img_new);        %Cut the image based in the BoundingBox.
% imshow(BW_ini_regio_cropped)
% size(BW_ini_regio_cropped)


% END FUNCTION

end
