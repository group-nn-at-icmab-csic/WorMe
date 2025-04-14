function [BW_single, endpoint_interest, xy_points_region] = operate_not_in_img_region_beta(BW_object, multip_value, imopen_strel_val)

% Variables
% BW_object : imatge principal, sense moficiacións afegides
% BW_object_sk: esqueletonització d'aquesta
% 
% BW_single: imatge a modificar
% BW_skel_new : esqueletonització d'aquesta 
%
%
% See also:
%

% INICI FUNCIÓ

%imshow(BW_object)

% Esqueletonització
% BW_object_sk = bwskel(BW_object);


% Imatge per processar (imopen etc.)
BW_single = BW_object;

% Processament en la imatge
BW_single = imopen(BW_single, strel("disk", imopen_strel_val));
%imshow(BW_single)

% Esqueletonització
BW_skel_new = bwskel(BW_single);
%imshow(imoverlay(BW_single, BW_skel_new, "r"))


% _Obtenció del punt en qüestió_

% bwdist per a obtenir imatge de distancies
BW_single_dist = bwdist(~BW_single);
%imshow(BW_single_dist, [])

% Obtenim els endpoints, i els valors d'aquests. Agafem el valor mínim.
endopints_BWskel = find(bwmorph(BW_skel_new,'endpoints'));

valors_endopints = BW_single_dist(endopints_BWskel);

[valor_min, indx_max] = min(valors_endopints); % Determinem el punt que te major valor
    % valor_min: Valor del bwdist. Ens servirà per a fer la suma al pixel de endpoint_interest

% Obtenim l'endpoint d'interès, a partir de l'index del endpoint amb menor valor.
endpoint_interest = endopints_BWskel(indx_max);

[x_enpoint, y_endpoint] = ind2sub(size(BW_single), endpoint_interest);
% imshow(imoverlay(BW_single, BW_skel_new, "r" ))
% hold on;
% % plot(y_c, x_r, 'r-', 'LineWidth', 2);
% plot(y_endpoint, x_enpoint, 'b.','markersize',14)
% hold off

% _Obtenim la regió d'interès, a partir del píxel d'interès_
valor_min_ext = double(round(valor_min)*multip_value); % ççç fer proporcional al percentatge de la imatge.

x_1_point = x_enpoint - valor_min_ext;
x_2_point = x_enpoint + valor_min_ext;
y_1_point = y_endpoint - valor_min_ext;
y_2_point = y_endpoint + valor_min_ext;
xy_points_region = [x_1_point, y_1_point, x_2_point, y_2_point];
% 13   143    31   161

% Re-definicio dels punts per a la seva correccio
xy_points_region_cor = xy_points_region;
xy_points_region_cor(3) = xy_points_region(3) - xy_points_region(1);
xy_points_region_cor(4) = xy_points_region(4) - xy_points_region(2);

% __Comprovacio regions__
[xy_points_region] = comprovacio_size_posicio(xy_points_region_cor, size(BW_single));

xy_points_region(3) = xy_points_region(1) + xy_points_region(3);
xy_points_region(4) = xy_points_region(2) + xy_points_region(4);

% imshow(BW_object)
% hold on
% rectangle('Position', [y_1_point, x_1_point, y_2_point - y_1_point, x_2_point - x_1_point], "EdgeColor","red")
% hold off

%Graficació comparativa
% BW_object_regio = BW_object(x_1_point: x_2_point, y_1_point : y_2_point);
% imshow(BW_object_regio)

% BW_single_old = BW_single;
% BW_single_old_regio = BW_single_old(x_1_point: x_2_point, y_1_point : y_2_point);
% imshowpair(BW_object_regio, BW_single_old_regio)

[x_size, y_size] = size(BW_single);
x_1_point = xy_points_region(1); y_1_point = xy_points_region(2); x_2_point = xy_points_region(3); y_2_point = xy_points_region(4);

% Correcció possibles sortides de la imatge:
% x_1_point % 69
% x_2_point % 109
% y_1_point % 13
% y_2_point % 53
if x_1_point < 0
    x_1_point = 0;
end
if y_1_point < 0
    y_1_point = 0;
end
if x_2_point > x_size
    x_2_point = x_size;
end
if y_2_point > y_size
    y_2_point = y_size;
end
xy_points_region = [x_1_point, y_1_point, x_2_point, y_2_point];


BW_single(x_1_point: x_2_point, y_1_point : y_2_point) = BW_object(x_1_point: x_2_point, y_1_point : y_2_point);


% Si no hi hagues aplicat ninguna regió:
% imshowpair(BW_object, BW_single_old)

% Imatge amb l'aplicació de la funció però no en la regió
% imshowpair(BW_object, BW_single)


% 
% % Esqueletonitzar (per a comprovar)
% BW_skel_BW_single_new = bwskel(BW_single);
% imshow(imoverlay(BW_single, BW_skel_BW_single_new, "r"))
% 
% % Esqueletonització de la imatge imopen antiga
% BW_skel_BW_single_old_new = bwskel(BW_single_old);
% imshow(imoverlay(BW_single_old, BW_skel_BW_single_old_new, "r"))
% 
% % longestConstrainedPath_Josep
% [BW_skel_nou_3, thinnedImg] = longestConstrainedPath_Josep(BW_single, "thinOpt", "thin");
% imshow(imoverlay(BW_object, BW_skel_nou_3, "r"))

% FINAL FUNCIÓ


end

