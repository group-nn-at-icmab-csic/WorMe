function [dist_max, endopint_n_fin] = dist_max_endpoints(BW_skel_image)

% Given the indexed values ​​of the endpoints of a skeletonized image, what is done, for each endpoint, is to make a bwdistgeodesic, which
% quantifies the distance between this endpoint to the
% other points. To check the distance between all the points,
% this procedure is done along all the endpoints, so
% that the largest is obtained.
%
% Input
% BW_skel_image : Skeletonized image
%
% Output
% dist_max       : major distance.
% endopint_n_fin : endpoint of the point where the length is higher.
%
%
%
% See also
% dist_max_endpoints_new


% FUNCTION START

%branques_total = find(bwmorph(BW_llistat_imatges_skel,'branchpoints'));

end_points = find(bwmorph(BW_skel_image,'endpoints')); % Igual pero en valors indexats
[endp_i,endp_j] = find(bwmorph(BW_skel_image,'endpoints'));

% Checking that the binary image is a skeleton:
I_BW_bwperim = bwperim(BW_skel_image);
if sum(I_BW_bwperim(:)) ~= sum(BW_skel_image(:))
    msgbox("It is not binary image", "Error", "error")
end

% sTART
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
            endopint_n_fin = endpoint_n;
        end
    end
end


end