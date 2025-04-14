function [BW_skel_join] = esquel_multiple_BWobjects(BW_final)

% Donada una imatge binària amb diferents objectes, es fa
% l'esqueletonització de tots aquests i es retorna una imatge amb tots.
%
%
% See also
% esqueletonitzacio_josep_optim
% extendre_img_regions
% retallar_BWimatge_BB_2

% INICI FUNCIO


% __Agafem cada objecte binaria de la imatge__
[BW_label, num] = bwlabel(BW_final);

% Fem imatge de referència
BW_ref = false(size(BW_final));

% Fem imatge on sumarem els esquelets
BW_skel_join = false(size(BW_final));

% Per cada objecte de la imatge binaria:
for n_val = 1:num
    
    % Agafem un objecte
    BW_object = BW_label == n_val;
    %figure; imshow(BW_object)

    % Retallem objecte
    [BW_filt_crop, ~, proporcio_img] = retallar_BWimatge_BB_2(BW_object, 5);

    % Esqueletonitzem aquest:
    [BW_skel_unic, ~] = esqueletonitzacio_josep_optim(BW_filt_crop, 1, true, true);

    BW_img_final_sized = extendre_img_regions(BW_ref, proporcio_img, BW_skel_unic);

    BW_skel_join(find(BW_img_final_sized)) = true; % find: Elapsed time is 0.000972 seconds.
end


% FINAL FUNCIO




end