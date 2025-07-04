function [BW_skel_final_unic] = large_skel(BW_skel_image)
% Given a skeletonized image, returns the skeletonized image
% with the greatest length.
%
% Variables
%
% Input:
% BW_skel_image : skeletonized image
%
% Output
% BW_skel_final_unic : resulting skeletonized image
%
%
% See also
% dist_max_endpoints_new

% START FUNCTION

% Internal variables
% endpoints_max : endpoints with the greatest distance.



% figure; imshow(BW_skel_image); hold on;
% [rb1,cb1] = ind2sub(size(BW_skel_image),endppoints_max(1));
% [rb2,cb2] = ind2sub(size(BW_skel_image),endppoints_max(2));
% plot(cb1,rb1,'b.','markersize',14); drawnow;
% plot(cb2,rb2,'b.','markersize',14); drawnow;
% hold off

% _Obtenim els branchpoints_
BW_branchpoints =  bwmorph(BW_skel_image,'branchpoints');
branchpoints = find(BW_branchpoints);

% imshow(BW_skel_image)
% graficar_rectangle(branchpoints, size(BW_skel_image), 4)

if ~isempty(branchpoints)

    
    % _Obtain the max lengtha_
    [dist_max ,endppoints_max] = dist_max_endpoints_new(BW_skel_image);

    % Let's make sure there is not more than one endpoint (this could happen if there are two equally long distances):
    if numel(endppoints_max) > 2
        error("Error in large_skel function: more than 2 endpoints.")
    elseif numel(endppoints_max) < 2
        error("Error in large_skel function: 1 or less endpoints.")        
    end
    
    % % Graph branchpoints
    % figure; imshow(BW_skel_image); hold on
    % [x_branch, y_branch] = ind2sub(size(BW_skel_image), branchpoints);
    % plot(y_branch, x_branch,'b.','markersize',14); drawnow;
    % hold off
    % imshow(imoverlay(BW_skel_image, BW_branchpoints, "r"))

    % We obtain the ambiguity branchpoints:
    [indx_new_branch_total] = obtain_indx_nonbranch(BW_skel_image);
    % Aquests es comportaràn individualment com un branchpoint
    
    % _We subtract the number of branchpoints_
    BW_skel_image_nonbranch = BW_skel_image;
    BW_skel_image_nonbranch(branchpoints) = false;
    BW_skel_image_nonbranch(indx_new_branch_total) = false;
    %figure; imshow(BW_skel_image_nonbranch)

    % % Graph
    % BW_skel_ambig = false(size(BW_skel_image_nonbranch));
    % BW_skel_ambig(indx_new_branch_total) = true;
    % figure; imshow(imoverlay(BW_skel_image_nonbranch, BW_skel_ambig, "r"))
    
    

    % _We take the image with the branches that touch the maximum endpoints obtained_
    [x_max, y_max] = ind2sub(size(BW_skel_image),endppoints_max);
    BW_skel_branch_justends = bwselect(BW_skel_image_nonbranch, y_max, x_max);
    %figure; imshow(BW_skel_branch_justends)


    % _We subtract those points from the branch image that touch these points_
    BW_skel_branch_notends = BW_skel_image_nonbranch & not(BW_skel_branch_justends); %Elapsed time is 0.000616 seconds.
    %figure; imshow(BW_skel_branch_notends)

    % _We obtain the branch indices_
    branches_nonend = bwconncomp(BW_skel_branch_notends, 8); %Elapsed time is 0.001837 seconds.
    branques_pixels = branches_nonend.PixelIdxList;
    % Let's join the ambiguous pixels
    for cada_inx_brnchamb = indx_new_branch_total'; branques_pixels{end+1} = cada_inx_brnchamb; end
    
    % Add the branchpoints
    for cada_inx_brnchamb_main = branchpoints'; branques_pixels{end+1} = cada_inx_brnchamb_main; end
    
    % _Loop principal de veure cada branca_

   % First of all we make an image of the tips of the branches with the branchpoints, which will be the base.
    %BW_skel_base = BW_skel_branch_justends; %Elapsed time is 0.000109 seconds.
    %BW_skel_base(branchpoints) = true;
    % imshow(BW_skel_base)

    % we will subtract each section from branch_pixels until we see that these
    % do not condition. Then, we will do the same until we see that there are no
    % branchpoints?
    branques_pixels_new = branques_pixels;
    BW_skel_image_new = BW_skel_image;
    
    branques_pixels_new_del = {};
    branques_pixels_new_sel = {};
    BW_skel_image_new_supr = BW_skel_image_new;
    for n_llist_brnqpx = 1:length(branques_pixels_new)
        % BW_skel_image_new_t = BW_skel_image_new;
        BW_skel_image_new_t = BW_skel_image_new_supr; % Upgrade 20/09/2022
        
        % Delete the branch
        BW_skel_image_new_t(branques_pixels_new{n_llist_brnqpx}) = false;
        
        % See if it affects
        if getfield(bwconncomp(BW_skel_image_new_t, 8), 'NumObjects') == 1
            % If it affects, we can remove the branch from the list
            branques_pixels_new_del{end+1} = branques_pixels_new{n_llist_brnqpx};
            BW_skel_image_new_supr(branques_pixels_new{n_llist_brnqpx}) = false;
            
            % % Graph
            % BW_false = false(size(BW_skel_image_new_supr));
            % BW_false(branques_pixels_new{n_llist_brnqpx}) = true;
            % figure; imshow(imoverlay(BW_skel_image_new_supr, BW_false, "r"))
            
        else
            branques_pixels_new_sel{end+1} = branques_pixels_new{n_llist_brnqpx};
        end
        % Ñññ 
    end
    %
    
    % We are going to remove the branchpoints out
    %figure; imshow(BW_skel_image_new_supr)
    
    % First we look at the number of branchpoints
    n_branchpoints_sup = length(find(bwmorph(BW_skel_image_new_supr,'branchpoints')));
    
    BW_skel_image_new_t_nonb = BW_skel_image_new_supr;
    
    % For each of the selected branches,
    % which if removed do not alter the connectivity (branques_pixels_new_sel):
    for n_llist_brnqpx = 1:length(branques_pixels_new_sel)
        BW_skel_image_new_t_branch = BW_skel_image_new_t_nonb; % Upgrade josep 11/09/2022 (fallava)
        % BW_skel_image_new_t_branch = BW_skel_image_new_supr;
        % Eliminem el branch
        BW_skel_image_new_t_branch(branques_pixels_new_sel{n_llist_brnqpx}) = false;
        
        % % Graficar
        % BW_skel_image_new_t_branch_branchp = false(size(BW_skel_image_new_t_branch));
        % BW_skel_image_new_t_branch_branchp(branques_pixels_new_sel{n_llist_brnqpx}) = true;
        % figure
        % imshow(imoverlay(BW_skel_image_new_t_branch, BW_skel_image_new_t_branch_branchp, "r"))
        % if numel(branques_pixels_new_sel{n_llist_brnqpx}) < 5
        %     graficar_rectangle(branques_pixels_new_sel{n_llist_brnqpx}, size(BW_skel_image_new_t_branch), 4)
        % end    
        
        
        n_branchpoints_sup_2 = length(find(bwmorph(BW_skel_image_new_t_branch,'branchpoints')));
        
        
    
        % If by removing it, the number of branchpoints is smaller,
        % it means we have removed the branchpoint:
        if n_branchpoints_sup_2 < n_branchpoints_sup
            % And it also does not alter the connectivity of the image

            % % Graficar            
            % imshow(BW_skel_image_new_t_branch)
            % indx_sqr = branques_pixels_new_sel{n_llist_brnqpx};  %ÑÑÑÑ
            % graficar_rectangle(indx_sqr, size(BW_skel_image_new_t_branch), 4)            
            % getfield(bwconncomp(BW_skel_image_new_t_branch, 8), 'NumObjects')
            
            
            % if getfield(bwconncomp(bwselect(BW_skel_image_new_t_branch, y_max, x_max), 8), 'NumObjects') == 1% Upgrade Josep (no calia)
            if getfield(bwconncomp(BW_skel_image_new_t_branch, 8), 'NumObjects') == 1 
                
                BW_skel_image_new_t_nonb(branques_pixels_new_sel{n_llist_brnqpx}) = false;
                BW_skel_image_new_t_nonb = bwselect(BW_skel_image_new_t_nonb, y_max, x_max);
                n_branchpoints_sup = n_branchpoints_sup -1;
            end
        end
        
    end
    
    
    % % Eliminats (graficació):
    % BW_skel_zeros = false(size(BW_skel_image_new_t_nonb));
    % indx_diferenc = find(BW_skel_image_new_t_nonb - BW_skel_image_new_supr);
    % BW_skel_zeros(indx_diferenc) = true;
    % figure; imshow(imoverlay(BW_skel_image_new_t_nonb, BW_skel_zeros, "r"))
    % graficar_rectangle(indx_diferenc, size(BW_skel_zeros), 4)

    
    %imshow(imoverlay( BW_skel_image_new_t_nonb, bwmorph(BW_skel_image_new_t_nonb,'branchpoints'), "r"))
    
    %imshow(imoverlay(BW_skel_image, BW_skel_image_new_t_nonb, "r"))
    
        
    
    
    
    BW_skel_final_unic = BW_skel_image_new_t_nonb;
    
else
    BW_skel_final_unic = BW_skel_image;
end

% FINAL OF THE FUNCTION

end
