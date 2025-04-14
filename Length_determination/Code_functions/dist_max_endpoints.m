function [dist_max, endopint_n_fin] = dist_max_endpoints(BW_skel_image)

% Donats els valors indexats dels endpoints d'una imatge
% esqueletonitzada, el que es fa, per a cada endpoint, fer un bwdistgeodesic, el qual
% quantifica la distancia que hi ha entre aquest endpoint vers els
% altres punts. Per a comprovar la distancia entre tots els punts,
% aquest procediment es fa al llarg de tots els endpoints, de manera
% que s'obté el més gran.
%
% Input
% BW_skel_image : Imatge esqueletonitzada
%
% Output
% dist_max       : distància major.
% endopint_n_fin : endpoint del punt on la llargada és major.
%
%
%
% See also
% dist_max_endpoints_new


% INICI FUNCIO

%branques_total = find(bwmorph(BW_llistat_imatges_skel,'branchpoints'));

end_points = find(bwmorph(BW_skel_image,'endpoints')); % Igual pero en valors indexats
[endp_i,endp_j] = find(bwmorph(BW_skel_image,'endpoints'));

% Comprovació que la imatge binaria sigui esquelet:
I_BW_bwperim = bwperim(BW_skel_image);
if sum(I_BW_bwperim(:)) ~= sum(BW_skel_image(:))
    msgbox("It is not binary image", "Error", "error")
end

% Inici
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