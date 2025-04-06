function [dist_max ,endppoints_max] = dist_max_endpoints_new(BW_skel_image)

% Donada una imatge esqueletonitzada, dona el valor de la llargada máxima d'aquesta, així com els punts.
%
% Upgrade de dist_max_endpoints()
%
% Funcionament:
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
% Temps d'execució
% Elapsed time is 0.012395 seconds
%
% See also
% dist_max_endpoints


% INICI FUNCIO

end_points = find(bwmorph(BW_skel_image,'endpoints')); % Igual pero en valors indexats
[endp_i,endp_j] = find(bwmorph(BW_skel_image,'endpoints'));

% % Comprovació que la imatge binaria sigui esquelet:
% I_BW_bwperim = bwperim(BW_skel_image);
% if sum(I_BW_bwperim(:)) ~= sum(BW_skel_image(:))
%     msgbox("It is not binary image", "Error", "error")
% end

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
            index_endpoint_max_1 = endpoint_n;
            index_endpoint_max_2 = sub2ind(size(BW_skel_image), endp_i(n),endp_j(n));
        end
    end
end

% Grafiquem
% figure
% imshow(D_endp, []); hold on
% [rb1,cb1] = ind2sub(size(BW_skel_image),index_endpoint_max_1);
% [rb2,cb2] = ind2sub(size(BW_skel_image),index_endpoint_max_2);
% plot(cb1,rb1,'b.','markersize',14); drawnow;
% plot(cb2,rb2,'b.','markersize',14); drawnow;
% hold off


endppoints_max = [index_endpoint_max_1 index_endpoint_max_2];


end

% FINAL FUNCIÓ