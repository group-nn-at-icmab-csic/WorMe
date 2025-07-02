function [Area_Josep] = determinar_area_josep_bw(BW_skel)

% The area of ​​a line, or set, is returned.
% The binary image cannot have volume, so the area of ​​the line is analyzed.

% %Variables exemple
% BW_skel = bwskel(imatge_primera_retallada);
% imshow(BW_skel, 'InitialMagnification','fit')

% We enlarge the skeletonization line, for better graphics.
% The 'diag' option does is join those pixels that have a diagonal separation
% between them.
%      0  1  0           0  1  0 
%      1  0  0  becomes  1  1  0 
%      0  0  0           0  0  0

BW_skel_diag = bwmorph(BW_skel, 'diag');
% imshow(BW_skel_diag, 'InitialMagnification','fit')

% BW_skel_diag_show = BW_skel - BW_skel_diag;
% BW_final_skel = imoverlay(BW_skel, BW_skel_diag_show, 'r');
% imshow(BW_final_skel, 'InitialMagnification','fit')
% Remember, this image is for graphics, it is not valid to be
% used for analysis.


%Area of the skeletonized image
Area_skel = sum(BW_skel(:));

%Area of the skeletonized image, and modified the pixels angles 
Area_skel_diag = sum(BW_skel_diag(:));

%Area of ​​the skeletonized image, according to Josep's theory
% 1. from the initial skeletonization, the value of the diagonal singular pixels is subtracted, and that same value multiplied by the square root of 2 is added,
% which belongs to the diagonal distance of two straight lines of distance 1.
% 2. each of the two pixels of 'diag' that are attributed to each diagonal pixel.

Area_diag = (Area_skel_diag - Area_skel)/2; % diagonal pixels. Divide by 2 because two pixels are generated for each corner. This only happens, however, in linear, skeletonized pixel images.
Area_Josep = Area_skel - Area_diag + Area_diag * sqrt(2);


end