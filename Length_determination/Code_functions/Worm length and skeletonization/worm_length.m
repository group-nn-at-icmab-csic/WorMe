function [Area_final] = worm_length(BW_skel)

% Given a skeletonized image, return its length.

% We enlarge the skeletonization line, for better graphics.
% The 'diag' option joins those pixels that have a diagonal separation
% between them.
%      0  1  0           0  1  0 
%      1  0  0  becomes  1  1  0 
%      0  0  0           0  0  0

BW_skel_diag = bwmorph(BW_skel, 'diag');

%BW_final_skel = imoverlay(BW_final, BW_skel_diag, 'r');
%BW_final_skel = BW_final_skel.CData;
% Remember, this image is for graphics, it is not valid to be
% used for analysis.


%Area of ​​the skeletonized image
Area_skel = sum(BW_skel(:));

%Area of ​​the skeletonized image, and modified pixel angles
Area_skel_diag = sum(BW_skel_diag(:));

%Area of ​​the skeletonized image: another theory
% 1. from the initial skeletonization, the value of the diagonal singular pixels is subtracted, 
% and that same value multiplied by the square root of 2 is added,
% which belongs to the diagonal distance of two straight lines of distance 1.
% 2. each of the two pixels of 'diag' that are attributed to each diagonal pixel.

Area_diag = (Area_skel_diag - Area_skel)/2;
Area_final = Area_skel - Area_diag + Area_diag * sqrt(2);




end