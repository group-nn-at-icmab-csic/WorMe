function imageArray_fintot = suma_semiBW_norm_millorat(imageArray, BW_semi)

% Given a normal 3D image (imageArray), and another binary 3D image (BW_semi), 
% that is, where most of its values ​​are 0, but others have values ​​between 0 and 255,
% the binary image is superimposed on the 3D image.
%
% _Variables_
%
% imageArray : 3D RGB image
% BW_semi : 3D RBG image, with many points with 0's.
%
% % Example variables
% BW_semi = new_object_colored;
% imshow(BW_semi)
% imshow(imageArray)
%
%
% IMAGE COMBINATION
% What is done is combine the main image v'imageArray' with the semi-binary image
% v'zeros_image', which has three matrices that go from 0 to 255.
% To do this, we must change the main image to type 'double',
% set the places where it matches with the binary image to zero, and then
% add the semi-binary image, for each dimension of the matrix,
% so that the places of the binary image are subtracted and those of the
% same binary image but with color are added.
%
%
% % See also
% BW_objects_to_color


% START FUNCTION

if size(BW_semi) ~= size(imageArray)
    msgbox('Images different size', 'Error','error');
    error("Error in f'suma_semiBW_norm_millorat': Images different size")
end


% Define the binary image
BW_proba_temp = BW_semi(:,:,1);
BW_proba = imbinarize(BW_proba_temp); 
% Do imbinarize and not 'im>0' because since the image could come from a '.jpg',
% it could have pixels with 1,2,3 values which could distort
% the filtration. 
% BW_proba = BW_proba_temp > 0;
% unique(BW_proba)
% imshow(BW_proba)


% Change to double type (to operate mathematically, if it is uint8 it cannot be done)
imageArray = double(imageArray);


imageArray_1 = imageArray(:,:,1);
imageArray_1(BW_proba) = 0;
%imshow(imageArray_1)
%imageArray_1 = logical(imageArray_1);
imageArray_1_fin = imageArray_1 + double(BW_semi(:, :, 1));

imageArray_2 = imageArray(:,:,2);
imageArray_2(BW_proba) = 0;
imageArray_2_fin = imageArray_2 + double(BW_semi(:, :, 2));

imageArray_3 = imageArray(:,:,3);
imageArray_3(BW_proba) = 0;
imageArray_3_fin = imageArray_3 + double(BW_semi(:, :, 3));

% Combine the three matrices
imageArray_fintot = cat(3, imageArray_1_fin, imageArray_2_fin, imageArray_3_fin);

% Change the type to uint8.
imageArray_fintot = uint8(imageArray_fintot);
%imshow(imageArray_fintot)

% END FUNCTION

end