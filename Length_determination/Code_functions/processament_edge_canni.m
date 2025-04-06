function [BW_restat_final] = processament_edge_canni(imgray_imatge_input)

% Donada una imatge es fa el procesat d'aquseta basant-se amb la suma dels
% edge() de diferents tipologies (approxcanny i canny).

% function processament_edge_canni(imgray_imatge_input)
BW_edge_approxcanny = edge(imadjust(im2gray(imgray_imatge_input)), "approxcanny");

% Fem bwareaopen fins a obtenir sols un objecte major

for cada_valor = (0.5:2:40)
    BW_proba = bwareaopen_percentatge(BW_edge_approxcanny, cada_valor);
    if unique(BW_proba) == 0
        cada_valor_final = cada_valor_anterior;
        break
    end
    figure
    cada_valor_anterior = cada_valor;
end
BW_proba_bwareaop = bwareaopen_percentatge(BW_edge_approxcanny, cada_valor_final);

% imclose de 1 
SE = strel("disk", 1);
BW_im_close = imclose(BW_proba_bwareaop, SE);


%imfill
BW_im_close = imfill(BW_im_close, "holes");

% imOpen de 1
BW_im_close = imopen(BW_im_close, strel("disk", 1));

% Open de 2
BW_im_open_2 = imopen(BW_im_close, strel("disk", 2));


% __Restat de les màscares__
% edge Canny
BW_img_edge_crop_adjust = edge(imadjust(im2gray(imgray_imatge_input)), "Canny");

% resta
BW_restat = BW_im_open_2-BW_img_edge_crop_adjust;
BW_restat = BW_restat > 0;

BW_restat_modif = imfill(BW_restat, "holes");

BW_restat_modif = bwpropfilt(BW_restat_modif, "Area", 1, "largest");

BW_restat_modif = imclose(BW_restat_modif, strel("disk", 1));

BW_restat_final = BW_restat_modif;

end
