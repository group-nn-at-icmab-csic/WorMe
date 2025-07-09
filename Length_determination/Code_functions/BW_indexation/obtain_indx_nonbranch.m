function [indx_new_branch_total] = obtain_indx_nonbranch(BW_skel_image)

% Given a skeletonized image, returns the indices of the pixels
% surrounding the branchpoints where there is ambiguity in their directionality,
% that is, if the branchpoint is removed from these, the pixels trace a line. 
% This function is used to index these points and operate on them.
%
% Variables
% Input
% BW_skel_image : skeletonized binary image.
%
% Output
% indx_new_branch_total : list with the indices of the branchpoints that
% present ambiguity.
%
% Example of using the function
% [indx_new_branch_total] = obtain_indx_nonbranch(BW_skel_image) 
% Elapsed time is 0.002569 seconds.
% 
% BW_false_showindx = false(size(BW_skel_image)); BW_false_showindx(indx_new_branch_total) = true;
% imshow(imoverlay(BW_skel_image, BW_false_showindx, "r"))
%
% See also
% matriu_nova


% START FUNCTION

% Branchpoints OF THE IMAGE
BW_branchpoints =  bwmorph(BW_skel_image,'branchpoints');
branchpoints_img = find(BW_branchpoints);
[x_branch, y_branch] = ind2sub(size(BW_skel_image), branchpoints_img);


% Loop start: For every branchpoint, find the indices of the main image
% that are connected.
indx_new_branch_total = [];
n_three_nonconnpx = 0;

% For every branchpoint of the image, determined by x,y:
for cada_x = 1:length(x_branch)
    
    % Define x,y of the branchpoint
    x_branch_point = x_branch(cada_x);
    y_branch_point = y_branch(cada_x);
    
    % Obtain the surrounding matrix to the specific pixel of the branchpoint
    [matriu_nova_v, ~, ~, ~, punt_centr] = matrix_new(BW_skel_image, 1, x_branch_point, y_branch_point);
    
    % % With central point
    % matriu_nova_v
    % 
    % % Without central point
    % matrui_nova_2
    % 
    % BW_new_branch_lit = BW_skel_image(mat_sortida(1):mat_sortida(2), mat_sortida(3):mat_sortida(4));
    % BW_new_branch_lit_point = false(size(BW_new_branch_lit)); BW_new_branch_lit_point(punt_centr, punt_centr) = true;
    % figure; imshow(imoverlay(BW_new_branch_lit, BW_new_branch_lit_point, "r"), 'InitialMagnification','fit');
    % 
    % nm = 10;
    % BW_new_branch = BW_skel_image(mat_sortida(1)-nm:mat_sortida(2)+nm, mat_sortida(3)-nm:mat_sortida(4)+nm);
    % BW_new_branch_point = false(size(BW_new_branch)); BW_new_branch_point(punt_centr+nm, punt_centr+nm) = true;    
    % figure; imshow(imoverlay(BW_new_branch, BW_new_branch_point, "r"), 'InitialMagnification','fit');

    % Without branchpoint
    BW_new_branch_lit_new = matriu_nova_v;
    BW_new_branch_lit_new(2, 2) = false;
    % imshow(BW_new_branch_lit_new, 'InitialMagnification', 'fit')
    
    % We see the amount of objects
    struct_bwcomp = bwconncomp(BW_new_branch_lit_new, 8);
    num_objectes = struct_bwcomp.NumObjects;
    
    % If the number of objects is equal to 3, they are not taken,
    % they will be separated appropriately.
    if num_objectes == 3
        n_three_nonconnpx = n_three_nonconnpx +1;

        % Graph
        % [BW_retallada_skel, ~, ~, ~, ~] = matrix_new(BW_skel_image, 5, x_branch_point, y_branch_point);
        % BW_retallada_skel_indx = false(size(BW_retallada_skel)); BW_retallada_skel_indx(6,6) = true;
        % figure; imshow(imoverlay(BW_retallada_skel, BW_retallada_skel_indx, "r"), 'InitialMagnification','fit')
        %BW_label_matrix = labelmatrix(bwconncomp(BW_new_branch_lit_new, 8));
        %figure; imshow(BW_label_matrix, [], 'InitialMagnification', 'fit')        
       continue
    end
    
    % BW_label_matrix = labelmatrix(bwconncomp(BW_new_branch_lit_new, 8));
    % imshow(BW_label_matrix, [], 'InitialMagnification', 'fit')

    % _We obtain the components that are together in the matrix_
    struct_bwcomp = bwconncomp(BW_new_branch_lit_new, 8);
    pixel_list = struct_bwcomp.PixelIdxList;
    % length(pixel_list{1})
    % length(pixel_list{2})

    % Take the cell with more numbers:
    indx_max_val = 0;
    for c_conn = 1:length(pixel_list)
        if numel(pixel_list{c_conn}) > indx_max_val
            indx_max_val = numel(pixel_list{c_conn});
            indx_max = c_conn;
        end
    end
    index_valors = pixel_list{indx_max};
    % Now we have the values ​​in the indexed image.
    % We need to separate them, and pass them to the original image...
    % BW_false_new = false(size(BW_new_branch_lit_new));
    % BW_false_new(index_valors) = true;
    %imshow(imoverlay(BW_new_branch_lit_new, BW_false_new, "r"), 'InitialMagnification', 'fit')

    
    % _Take the indices of the points_
    [x_indx, y_indx] = ind2sub(size(BW_new_branch_lit_new), index_valors);
    
    x_indx_new = x_indx - punt_centr(1);
    y_indx_new = y_indx - punt_centr(2);
    
    x_indx_new_bo = x_branch_point + x_indx_new;
    y_indx_new_bo = y_branch_point + y_indx_new; 
    
    % Pass to index:
    indx_new_branch = sub2ind(size(BW_skel_image), x_indx_new_bo, y_indx_new_bo);

    indx_new_branch_total = [indx_new_branch_total; indx_new_branch];
    
    % _Graph_
    % BW_zeros_BWskel = false(size(BW_skel_image)); BW_zeros_BWskel(indx_new_branch) = true;
    %imshow(BW_zeros_BWskel, 'InitialMagnification','fit')
    % Si hol volem graficar millor
    % [BW_retallada_skel, ~, ~, ~, ~] = matrix_new(BW_skel_image, 5, x_branch_point, y_branch_point);
    % [BW_retallada_skel_indx, ~, ~, ~, ~] = matrix_new(BW_zeros_BWskel, 5, x_branch_point, y_branch_point);
    % BW_imoverlay = imoverlay(BW_retallada_skel, BW_retallada_skel_indx, "r");
    % BW_imoverlay(6,6,:) = [0, 255, 0];
    % figure; imshow(BW_imoverlay, 'InitialMagnification','fit')
    
end

% % Check
% length(indx_new_branch_total)
% n_three_nonconnpx


end

% END FUNCTION