function [valors_lineals_bwdist] = linear_bwdist_values_new(BW_filt_crop, BW_skel)

% Given a binary image and its skeleton, returns the linear (ordered) values
% of the width relative to the nearest perimeter (using the bwdist function)
% for each point of the skeleton.
% Improved upgrade: width_bwskeldist_values
%
% See also
% width_bwskeldist_values

% START FUNCTION


% We see the bwdist
BW_bwdist = bwdist(~BW_filt_crop);
% imshow(BW_bwdist, [])



% If we do bwdistgeodesic

B =  bwmorph(BW_skel,'endpoints');
indx_endpoints = find(B);

D = bwdistgeodesic(BW_skel,indx_endpoints(1),'quasi');

% But now we just have elements that are not NaN. 
newD = D(~isnan(D));

% We see that it is irregular. This is because each value is not linear, but
% defined by its position along the y-axis, so some positions come before others.

% If we sort it:
% plot(sort(newD))

% We assign it to a variable
newDsort = sort(newD);

% What we need to relate is this value with the one from the skeletonized image.
% (It's a bit of a quick fix, but for now this is what I'd try...)
% find(D == newDsort(1))

% This is point 1 of the skeletonized image.
% If we do this for every element

% It delays
indx_D_ordenats = [];
for n_D = 1:length(newDsort)
    indx_D_ordenats = [indx_D_ordenats, find(D == newDsort(n_D))];
end
% These, theoretically, are the ordered indices of each element in BWskel
% indx_D_ordenats

% Ok, what do we have? We have the lengthened BWskel, and its bwdist. Similarly, we have the ordered indices of each point in BWskel.
% This way we can get the bwdist value for each BWskel value, because we take the point from the ordered index, that is, point 1, 2, 3, 4, etc. of the skeletonization,
% and in the bwdist image we obtain the value, which will be relative to the distance to the binary object.
% BW_bwdist(indx_D_ordenats)

valors_lineals_bwdist = BW_bwdist(indx_D_ordenats);



% FINAL OF THE FUNCTION


end