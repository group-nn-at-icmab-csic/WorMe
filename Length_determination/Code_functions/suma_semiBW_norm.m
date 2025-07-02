function imFinal = suma_semiBW_norm(imageArray2, image_semiBW)

%

% imshow(imageArray2)

%imshow(image_semiBW)

% Obtain which are zeroes and which are not
zeros_imBW_1D = image_semiBW(:, :, 1) ~= 0 + ...
    image_semiBW(:, :, 2) ~= 0 + ...
    image_semiBW(:, :, 3) ~= 0;
%sum(zeros_imBW_1D(:))

zeros_imBW_1D = zeros_imBW_1D ~= 0;
%zeros_imBW_1D
%unique(zeros_imBW_1D)
%sum(zeros_imBW_1D(:))

imageArray2_1d = imageArray2(:,:,1);
imageArray2_1d(zeros_imBW_1D) = 0;

imageArray2_2d = imageArray2(:,:,1);
imageArray2_2d(zeros_imBW_1D) = 0;

imageArray2_3d = imageArray2(:,:,1);
imageArray2_3d(zeros_imBW_1D) = 0;

imageArray3 = cat(3, imageArray2_1d, imageArray2_2d, imageArray2_3d);
%imshow(imageArray3)

imFinal = imageArray3 + image_semiBW;
%imshow(imFinal)

end