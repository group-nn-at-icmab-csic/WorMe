function [BW_skel_join] = skel_multiple_BWobjects(BW_final)

% Given a binary image with different objects, all of them are skeletonized
% and an image with them all is returned.
%
%
% See also
% worm_skeletonization
% extend_img_regions
% cut_BB_BW_image_2

% START FUNCTION


% __We take each binary object from the image__
[BW_label, num] = bwlabel(BW_final);

% Create reference image
BW_ref = false(size(BW_final));

% Create image where we will add the skeletons
BW_skel_join = false(size(BW_final));

% For each object in the binary image:
for n_val = 1:num
    
    % Take one object
    BW_object = BW_label == n_val;
    %figure; imshow(BW_object)

    % Crop object
    [BW_filt_crop, ~, proporcio_img] = cut_BB_BW_image_2(BW_object, 5);

    % Skeletonize it:
    [BW_skel_unic, ~] = worm_skeletonization(BW_filt_crop, 1, true, true);

    BW_img_final_sized = extend_img_regions(BW_ref, proporcio_img, BW_skel_unic);

    BW_skel_join(find(BW_img_final_sized)) = true; % find: Elapsed time is 0.000972 seconds.
end


% END FUNCTION




end