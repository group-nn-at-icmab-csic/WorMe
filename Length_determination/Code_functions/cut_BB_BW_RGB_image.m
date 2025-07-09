function [imageArray_cropped, BW_ini_regio_cropped, BB_values, proporcio_img_new] = cut_BB_BW_RGB_image(imageArray, BW_ini_regio, percentatge_img_origin)

% Given an image where there is only one binary object, a bounding box 
% is made of it and the original image of it is obtained.
% Optimized the cut of binary object in the 'cut_BB_BW_image_2' function.
%
% Variables 
% imageArray  : RGB image
%
% BW_ini_regio : Binary image with just the binary object.
%
% percentatge_img_origin :  percentage by which the bounding box of the binary object will be enlarged. 
%                           It needs to be larger if you want to obtain regions outside the initial 
%                           bounding box (for example, when the tail is not selected).
% 
% Output
% imageArray_cropped : cropped original image
% BW_ini_regio_cropped : cropped binary image
% BB_values : BB values
% proporcio_img_new : proportion values
%
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
% See also
% retallar_BWRGBimatge_BB
% cut_BB_BW_RGB_image
% extend_img_regions
% dimension_output_correction
% cut_BB_BW_image_3

% START FUNCTION 

prop_regions_BW = regionprops(BW_ini_regio,'BoundingBox');  %<--- relevant
[valor_percentual_imatge] = img_percentage(BW_ini_regio, percentatge_img_origin);

BB_values = prop_regions_BW.BoundingBox;

proporcio_img = round(prop_regions_BW.BoundingBox + valor_percentual_imatge .* [-1 -1 2 2]);

% Check if the value is 0, and change it to 1
if sum(ismember(proporcio_img, 0)) > 0
    proporcio_img(ismember(proporcio_img, 0)) = 1;
end

% Old initial proportions
%[BW_ini_regio_cropped] = imcrop(BW_ini_regio, proporcio_img);         %Cut the image based in the BoundingBox.
%imshow(BW_ini_regio_cropped)
%size(BW_ini_regio_cropped)

% _Correct possible out of bounds measurements_
[proporcio_img_new] = dimension_output_correction(proporcio_img, size(BW_ini_regio)); %ex: 1080        1920


[BW_ini_regio_cropped] = imcrop(BW_ini_regio, proporcio_img_new);         %Cut the image based in the BoundingBox.
% imshow(BW_ini_regio_cropped)
% size(BW_ini_regio_cropped)

imageArray_cropped = imcrop(imageArray, proporcio_img_new);
%imshow(imageArray_cropped)

% END FUNCTION

end
