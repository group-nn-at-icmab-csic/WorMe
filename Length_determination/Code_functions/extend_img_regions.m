function [BW_img_final] = extend_img_regions(BW_img_ini, regions_xywh, BW_img_ajunt)

% Given an original image, and an image to be joined within it, 
% in certain positions, combines the regional image with the general image.
%
%
% Processing time
% Elapsed time is 0.004980 seconds.
%
%
% _Variables_
% input:
% BW_img_ini   : original binary image
% regions_xywh : regions to combine
% BW_img_ajunt : binary image to combine
%
%
% Example: cropping and re-scaling of the cropped image:
% imshow(BW_final_object)
% [imageArray_crop, BW_filt_crop, prop_BB, proporcio_img] = cut_BB_BW_RGB_image(imageArray, BW_final_object, 5);
% imshow(BW_filt_crop)
% BW_img_final_sized = extend_img_regions(BW_final_object, proporcio_img, BW_filt_crop);
% imshow(BW_img_final_sized)
% unique(BW_img_final_sized == BW_final_object)
%
%
% Example 2:
% I_rice = imread("rice.png"); imshow(I_rice)
% BW_rice = imbinarize(I_rice); imshow(BW_rice)
% BW_rice_singular = bwpropfilt(BW_rice, "Area", 1, "largest");
% imshow(BW_rice_singular)
% 
% [BW_rice_singular_cut, proporcio_img_rice] = cut_BB_BW_image_1(BW_rice_singular, 5);
% figure; imshow(BW_rice_singular_cut)
% 
% % Sum it to an original-like image
% [BW_rice_singular_other] = extend_img_regions(false(size(I_rice)), proporcio_img_rice, BW_rice_singular_cut);
% imshow(BW_rice_singular_other)
%
%
% See also
% retallar_BWRGBimatge_BB
% cut_BB_BW_image_1
% cut_BB_BW_RGB_image


% START FUNCTION

% Define the dimensions of the image:
[~, ~, dimensio] = size(BW_img_ini);

if dimensio == 1
    % In binary images or grayscale
    BW_img_ini(regions_xywh(2) : (regions_xywh(2) + regions_xywh(4)) , regions_xywh(1) : (regions_xywh(1) + regions_xywh(3)) ) = BW_img_ajunt;
    BW_img_final = BW_img_ini;
elseif dimensio == 3
    % In RGB images
    BW_img_ini(regions_xywh(2) : (regions_xywh(2) + regions_xywh(4)) , regions_xywh(1) : (regions_xywh(1) + regions_xywh(3)), : ) = BW_img_ajunt;
    BW_img_final = BW_img_ini;
else
    msgbox("No dimension error in f' extend_img_regions")
end

% END FUNCTION


end