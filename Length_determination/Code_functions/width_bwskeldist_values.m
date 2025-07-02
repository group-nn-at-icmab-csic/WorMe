function [bwdist_elem_order, indx_orders] = width_bwskeldist_values(BW_filt_crop, BW_skel)

% Given a binary image and its skeletonization, the width values at each
% skeletonization point, according to bwdist, are returned in order.
%
% Variables:
% input:
%   BW_filt_crop : Binary object
%   BW_skel : Skeletonized object
% output:
%   bwdist_elem_order: Value of the width of every element
%
% Processing time: Elapsed time: 0.0054757 seconds in 50 iterations.
%
% See: 2022_09_14_Proba_amplada_valors_bwskel_en_bwdist for better explanation
%
%
% Upgrade from: linear_bwdist_values i linear_bwdist_values_new

% START FUNCTION


% Look at the bwdist
BW_bwdist = bwdist(~BW_filt_crop);
% imshow(BW_bwdist, [])


% If we do bwdistgeodesic
B =  bwmorph(BW_skel,'endpoints');
indx_endpoints = find(B);

if ~isempty(indx_endpoints)
    D = bwdistgeodesic(BW_skel, indx_endpoints(1),'quasi');
    
    % But now we only have the elements that are not NaN
    newD = D(~isnan(D));
    newD_indx = find(~isnan(D));
    % upgrade: Every value has an index. Both are not in order.

    % We see that it is irregular. This is because each value is not linear, but is defined 
    % by the position on the y-axis, so some positions come before others.    
    
    % If we sort it:
    % plot(sort(newD))
    
    % Put it in a variable
    [~, sortIndx] = sort(newD);
    
    % plot(newD)
    % plot(sortIndx)
    % upgrade: Every value is enumerated: 1, 2, 3, 4...
    
    % Sort elements from newD_indx (index of every value). From every
    % sorted element (relative to the consecutive of the skeleton by the
    % consecutive of bwgesdist), its index, sorted.
    indx_orders = newD_indx(sortIndx);
    
    bwdist_elem_order = BW_bwdist(indx_orders);
    
    % plot(bwdist_elem_order)
else
    bwdist_elem_order = 0;
    indx_orders = 0;

end


% END FUNCTION


end