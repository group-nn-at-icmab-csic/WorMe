function [BW_final_selectedA] = select_BWobject_majorArea(BW_final_opened)

% Donat una imatge binaria amb mútiples objectes binaris, es retorna la
% imatge binaria amb el objecte binari major.

bwlabel_BW = bwlabel(BW_final_opened);
regions_bw_bwlabel = unique(bwlabel_BW(:));
%imshow(bwlabel_BW , [])

n_major_area = 0; % POsicio del element de la estructura amb major area
major_Area = 0; % Major area guardada per a filtre

for n_regionpA = 1:max(regions_bw_bwlabel)
    %n_regionpA
    BW_object_bwlabel = bwlabel_BW == n_regionpA;
    sum_BW_object_bwlabel = sum(BW_object_bwlabel(:));

    if sum_BW_object_bwlabel > major_Area
        major_Area = sum_BW_object_bwlabel;
        n_major_area = n_regionpA;
    end
end

BW_final_selectedA = (bwlabel_BW == n_major_area);
%imshow(BW_final_selectedA)


end