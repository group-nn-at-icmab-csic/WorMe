function [dist_max ,endppoints_max] = dist_max_endpoints_new(BW_skel_image)

% Given a skeletonized image, it gives the value of the maximum length of it, as well as the points.
%
% Upgrade of dist_max_endpoints()
%
% Operation:
% Given the indexed values ​​of the endpoints of a skeletonized image, what is done, for each endpoint, is to make a bwdistgeodesic, which
% quantifies the distance between this endpoint to the
% other points. To check the distance between all points,
% this procedure is done along all endpoints, so
% that the largest is obtained.
%
% Input
% BW_skel_image : Skeletonized image
%
% Output
% dist_max       : major distance.
% endopint_n_fin : endpoint wher ethe length is the most.
%
% Execution time:
% Elapsed time is 0.012395 seconds
%
% See also
% dist_max_endpoints


% START FUNCTION

end_points = find(bwmorph(BW_skel_image,'endpoints')); % Same but indexed values
[endp_i,endp_j] = find(bwmorph(BW_skel_image,'endpoints'));

% % Checking that the binary image is a skeleton:
% I_BW_bwperim = bwperim(BW_skel_image);
% if sum(I_BW_bwperim(:)) ~= sum(BW_skel_image(:))
%     msgbox("It is not binary image", "Error", "error")
% end

% Begin
dist_max = 0;

if length(end_points) == 1; dist_max = 1; end

for endpoint_nume = 1:length(end_points)
    endpoint_n = end_points(endpoint_nume);
    %disp(strcat("endpoint: ", string(endpoint_n)))
    D_endp = bwdistgeodesic(BW_skel_image, endpoint_n,'quasi');
    %figure
    %imshow(D_endp, []);
    %[rb,cb] = ind2sub(size(BW_llistat_imatges_skel),endpoint_n);hold on; plot(cb,rb,'b.','markersize',14); drawnow    
    for n = 1:numel(endp_i)
        dist_endp = D_endp(endp_i(n),endp_j(n));
        if dist_endp > dist_max
            dist_max = dist_endp;
            index_endpoint_max_1 = endpoint_n;
            index_endpoint_max_2 = sub2ind(size(BW_skel_image), endp_i(n),endp_j(n));
        end
    end
end

% Graph
% figure
% imshow(D_endp, []); hold on
% [rb1,cb1] = ind2sub(size(BW_skel_image),index_endpoint_max_1);
% [rb2,cb2] = ind2sub(size(BW_skel_image),index_endpoint_max_2);
% plot(cb1,rb1,'b.','markersize',14); drawnow;
% plot(cb2,rb2,'b.','markersize',14); drawnow;
% hold off


endppoints_max = [index_endpoint_max_1 index_endpoint_max_2];


end

% END FUNCTION