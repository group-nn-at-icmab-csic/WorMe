function [valors_lineals_bwdist, BW_skel_large] = linear_bwdist_values(BW_filt_crop)

% Given a binary object, it is skeletonized down to a single branch,
% and the ordered values of this branch related to the bwdist are returned,
% that is, the distance of these points to the closest perimeter.
%
% Improved upgrade: width_bwskeldist_values
%
% 
% See also 
% width_bwskeldist_values
 
% START FUNCTION

% Object skeletonization
BW_skel = bwskel(BW_filt_crop);

% figure; montage({imageArray_crop, BW_filt_crop, imoverlay(BW_filt_crop, BW_skel, "r")})

% Cut of the object
% imshow(BW_skel)

% If we do an unique large skeleton
[BW_skel_large] = large_skel_iter(BW_skel);
% imshow(imoverlay(BW_filt_crop, BW_skel_large, "r"))

% We see the bwdist
BW_bwdist = bwdist(~BW_filt_crop);
% imshow(BW_bwdist, [])


% If we obtain values in the positions
% BW_bwdist(BW_skel_large)
indx_BWskel = find(BW_skel_large);

% If we obtain the bwdist of the single skeletonized image
% imshow(~bwdist(BW_skel_large), [])

% All the values are 1.


% If we do bwdistgeodesic

It = BW_skel_large;
B =  bwmorph(It,'endpoints');
indx_endpoints = find(B);

D = bwdistgeodesic(It,indx_endpoints(1),'quasi');
% imshow(D, [])
% unique(D(:))
% For each point we have a value.
% Now we don't have the indexes sorted "randomly", but we have a value for each region of the bwskel. This will allow us to relate it to the value of bwdist in order to make a list of continuous values ​​that will be relative to the width.

% numel(unique(D))
% numel(sort(D))
% size(D)

% But now we just have the non NaN elements
newD = D(~isnan(D));
% numel(unique(newD))
% numel(sort(newD))
% size(newD)

% We see that ebery element of the list have a value


% plot(newD)
% We see that it is irregular. This is because each value is not linear, but is defined by the position on the y-axis, so some positions pass before others.

% If we order it:
% plot(sort(newD))

% We put it in a variable:
newDsort = sort(newD);

% What we have to relate is this value with that of the skeletonized image.
% (it's a mess, but for now it's what I would do...)
% find(D == newDsort(1))

% This is point 1 of the skeletonized image.
% If we do this for each element
indx_D_ordenats = [];
for n_D = 1:length(newDsort)
    indx_D_ordenats = [indx_D_ordenats, find(D == newDsort(n_D))];
end

% These are theoretically the ordered indices of each element of the BWskel
% indx_D_ordenats

% Okay, what do we have? We have the lengthened BWskel, and its bwdist. Similarly, we have the indices of each point in BWskel ordered.
% This way, we can obtain the bwdist value for each BWskel point, because we get the point from the ordered index, that is, point 1, 2, 3, 4, etc. of the skeletonization,
% and in the bwdist image we get the value, which corresponds to the distance to the binary object boundary.
% BW_bwdist(indx_D_ordenats)

valors_lineals_bwdist = BW_bwdist(indx_D_ordenats);

% If we graphic it:
% plot(BW_bwdist(indx_D_ordenats))


% FINAL OF THE FUNCTION

end