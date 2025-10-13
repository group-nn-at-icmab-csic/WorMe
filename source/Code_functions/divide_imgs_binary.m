function [llistat_imatges] = divide_imgs_binary(BW_final_conjunts)

% From a binary image, return a cell with the image where each
% object appears.

% START FUNCTION

% -- input: BW_final_conjunts
% -- output: listat_imatges

%From here we have the binarized image. What we want to determine,
%however, is the images with a skeletonization length. To do this,
%we will need to segment the image and analyze each image
%uniquely.

% %If we skeletonize:
% BW_skel = bwskel(BW_final_conjunts);
% imshow(BW_skel)
%

% SEPARATION OF BINARY IMAGES.
% Result: cell with the separated images
[L_variable, num] = bwlabel(BW_final_conjunts);
% imshow(L_variable, [])


%unique(L) equals num, equals number of differences

llistat_imatges = {};

%Separate each one and show
for k_for_cada = 1 : num
    thisBlob = ismember(L_variable, k_for_cada);
%     figure
%     imshow(thisBlob, []);
    llistat_imatges{length(llistat_imatges)+1} = thisBlob;
end

%We have'llistat_imatges', which is a cell that has each image
% llistat_imatges
% length(llistat_imatges)


% The result of the function is a cell with several images. From here,
% each of these images should be read and filtered.

% END FUNCTION


end