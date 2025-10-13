function [BB_values_list, proporcio_img_list] = cut_BB_BW_image_3(BW_final)

% Given a binary image with multiple objects, the bounding box values and proportions of
% them are returned.
%

% START FUNCTION

% Output variables
BB_values_list = [];
proporcio_img_list = [];

% __We take each binary object from the image__
[BW_label, num] = bwlabel(BW_final);

% For each object in the binary image:
for n_val = 1:num

            % Take an object
            BW_object = BW_label == n_val;

            [~, BB_values, proporcio_img_new] = cut_BB_BW_image_2(BW_object, 5);

            BB_values_list = [BB_values_list; BB_values];

            proporcio_img_list = [proporcio_img_list; proporcio_img_new];

end

% END FUNCTION

end