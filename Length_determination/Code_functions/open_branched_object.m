function [BW_final_opened_biggerbw] = open_branched_object(binary_image_analysie)

% Donada una imatge binària, fa una obertura (f'imopen) a partir del ratio
% de la mateixa imatge sobre la superfície d'aquesta i la seva area.
% Posteriorment obté l'objecte binari més gran si n'hi ha més d'un.

% % Variable exemple
% binary_image_analysie = llistat_imatges{1};

% Pixels bw
pixels_imbw = sum(binary_image_analysie(:));

% Pixeles imatge 
[x_ss, y_ss, ~] = size(binary_image_analysie);

% cuadrats
pixels_cuadrats = x_ss .* y_ss;

% lineals
pixels_lineals_tot = sqrt(x_ss .* y_ss);


% Ratio pixels lineals : pixels bw
ratio_unitot = pixels_lineals_tot / pixels_imbw;


bw_surface = bwmorph(binary_image_analysie,'remove'); 
%imshow(bw_surface)

% Ratio sobre la inversa del total 

% Area superfície
Area_binary_image_analysie_skel = round(determinar_area_josep_bw(bw_surface));

% Veiem que no és el mateix que si sols apliquem la suma dels pixels:
% sum(bw_surface(:))

% Ratio pixels bw : pixels superfície
ratio_areabw_superfbw = pixels_imbw / Area_binary_image_analysie_skel;
sqrt_ratio_areabw_superfbw = sqrt(ratio_areabw_superfbw);

% Obertura de la imatge en funció del ratio definit
SE_value = ceil(sqrt_ratio_areabw_superfbw);
SE = strel("disk", SE_value);
BW_final_opened = imopen(binary_image_analysie, SE);
%imshow(BW_final_opened)

% Obtenim l'objeecte més gran
BW_final_opened_biggerbw = select_BWobject_majorArea(BW_final_opened);
%imshow(BW_final_opened_biggerbw)

% imshowpair(binary_image_analysie, BW_final_opened_biggerbw, "montage")


% EXEMPLE OBERTURA IMATGE AMB DIFERENTS SE
% imshow(BW_llistat_imatges)
% SE = strel("disk", 5);
% BW_final_opened_ini = imopen(BW_llistat_imatges, SE);
% imshow(BW_final_opened)
% sum(BW_final_opened_ini(:))
% 
% BW_final_opened = BW_final_opened_ini;
% 
% for cada_rul = 1:8
%     cada_rul
%     SE = strel("disk", cada_rul);
%     BW_final_opened = imopen(BW_final_opened, SE);
%     sum(BW_final_opened(:))
% end
% 
% imshow(BW_final_opened)
% sum(BW_final_opened(:))


end