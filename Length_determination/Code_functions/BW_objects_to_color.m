function [image_BW_colors, obj_num, imageArray_fintot] = BW_objects_to_color(BW_obj, imageArray)

% Given a binary image with different objects, the objects are returned in different colors each. 
% If an original image is added, these objects printed in the original image are also returned.
%
% Variables
% ---------
% input
% BW_obj : Binary object/s
% imageArray : Original image (optional)
%
%
% output
% image_BW_colors : labeled image
% obj_num : number objects
% imageArray_fintot : RGB image with colored objects
%
% See also
% print_RGB_indx_brush
% dividie_BWobj_manual_multiple



% START FUNCTION

% _Diferentiation of the objects_
% A binary image with differential values of each object is obtained, by means of the function f'bwlabel'.
bwlabel_BW_proba = bwlabel(BW_obj);
% imshow(bwlabel_BW_proba, [])

% We define a matrix of zeros (zeros image), where the objects of the binary image will be 'painted':

% unique(bwlabel_BW_proba)
zeros_image = cat(3, zeros(size(BW_obj)), zeros(size(BW_obj)), zeros(size(BW_obj)));
%size(zeros_image)

% Color list 
colors_llista = [255 255 0; ... %yellow
    255 0 255; ... %magenta
    0 255 255; ... %cyan
    255 0 0; ... % red
    0 255 0; ...  % green
    0 0 255; ... % blue
    255 255 255]; % white

% For each object (of value 1, 2, 3...), we make a 3D matrix, with which we will add to the base matrix v'zeros_image'.
for cada_num = 1:length(unique(bwlabel_BW_proba))-1
    %cada_num

    % Every object
    new_object = bwlabel_BW_proba == cada_num;
    %imshow(new_object)
    
% Color to each object
     % If the number of objects in the color list is exceeded, the
     % following objects will have random color.
    if cada_num <= 7
        new_object_colored = cat(3, new_object .* colors_llista(cada_num, 1), new_object .* colors_llista(cada_num, 2),  new_object .* colors_llista(cada_num, 3));
    else
        new_object_colored = cat(3, new_object .* rand(1) .*255, new_object .* rand(1) .*255,  new_object .* rand(1) .*255);
    end

        
    %Add to zeroes
    zeros_image = zeros_image + new_object_colored;
    
end

% We independently pass the image from v'zeros_image' to uint8, so that it can be an output image, and not just an array.
image_BW_colors = uint8(zeros_image);
%imshow(image_BW_colors)

% Number of objects
obj_num_prov = unique(bwlabel_BW_proba);
obj_num = obj_num_prov(end);

if exist('imageArray','var')
    
    % IMAGE COMBINATION
    % What is done is combine the main image v'imageArray' with the semi-binary image
    % v'zeros_image', which has three matrices that go from 0 to 255.
    % To do this, we must change the main image to type 'double',
    % set the places where it matches with the binary image to zero, and then
    % add the semi-binary image, for each dimension of the matrix,
    % so that the places of the binary image are subtracted and those of the
    % same binary image but with color are added.
    
    % Change to double type (to operate mathematically, if it is uint8 it cannot be done)
    imageArray = double(imageArray);
    
    imageArray_1 = imageArray(:,:,1);
    imageArray_1(BW_obj) = 0;
    %imshow(imageArray_1)
    imageArray_1_fin = imageArray_1 + zeros_image(:, :, 1);
    
    imageArray_2 = imageArray(:,:,2);
    imageArray_2(BW_obj) = 0;
    imageArray_2_fin = imageArray_2 + zeros_image(:, :, 2);
    
    imageArray_3 = imageArray(:,:,3);
    imageArray_3(BW_obj) = 0;
    imageArray_3_fin = imageArray_3 + zeros_image(:, :, 3);
    
    % Combine the three matrices
    imageArray_fintot = cat(3, imageArray_1_fin, imageArray_2_fin, imageArray_3_fin);
    
    % Change the type to uint8.
    imageArray_fintot = uint8(imageArray_fintot);
    %imshow(imageArray_fintot)

else
    imageArray_fintot = false;

end


% END FUNCTION

end