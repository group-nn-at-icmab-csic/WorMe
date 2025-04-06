function [indx_new_branch_total] = obtain_indx_nonbranch(BW_skel_image)

% Donada una imatge esqueletonitzada, es retorna els index d'aquells pixels
% circundants als branchpoints on hi ha una ambiguitat en la
% direccionalitat del branchpoint, és a dir, si s'elimina el branchpoint
% d'aquests els pixels tracen una línia.
% Aquesta funció serveix per a indexar aquests punts i operar amb ells.
%
%
% Variables
% Input
% BW_skel_image : imatge binària esqueletonitzada.
%
% Output
% indx_new_branch_total : llsita amb els index dels branchpoints qque
% presenten ambigüitat.
%
%
%
% Exemple utilització funció
% [indx_new_branch_total] = obtain_indx_nonbranch(BW_skel_image) % Elapsed time is 0.002569 seconds.
% 
% BW_false_showindx = false(size(BW_skel_image)); BW_false_showindx(indx_new_branch_total) = true;
% imshow(imoverlay(BW_skel_image, BW_false_showindx, "r"))
%
%
%
%
% See also
% matriu_nova


% INICI FUNCIÓ

% Branchpoints de la imatge
BW_branchpoints =  bwmorph(BW_skel_image,'branchpoints');
branchpoints_img = find(BW_branchpoints);
[x_branch, y_branch] = ind2sub(size(BW_skel_image), branchpoints_img);


% Inici del loop: Per a cada branchpoint, s'obtenen els index de la imatge
% principal d'aquells que estan connectats.
indx_new_branch_total = [];
n_three_nonconnpx = 0;

% Per cada branchpoint de la imatge, determinat en x,y:
for cada_x = 1:length(x_branch)
    
    % Definim x,y del branchpoint
    x_branch_point = x_branch(cada_x);
    y_branch_point = y_branch(cada_x);
    
    % Obtenim la matriu circumdant al píxel en concret corresponent al branchpoint
    [matriu_nova_v, ~, ~, ~, punt_centr] = matriu_nova(BW_skel_image, 1, x_branch_point, y_branch_point);
    
    % % Amb punt central
    % matriu_nova_v
    % 
    % % Sense punt central
    % matrui_nova_2
    % 
    % BW_new_branch_lit = BW_skel_image(mat_sortida(1):mat_sortida(2), mat_sortida(3):mat_sortida(4));
    % BW_new_branch_lit_point = false(size(BW_new_branch_lit)); BW_new_branch_lit_point(punt_centr, punt_centr) = true;
    % figure; imshow(imoverlay(BW_new_branch_lit, BW_new_branch_lit_point, "r"), 'InitialMagnification','fit');
    % 
    % nm = 10;
    % BW_new_branch = BW_skel_image(mat_sortida(1)-nm:mat_sortida(2)+nm, mat_sortida(3)-nm:mat_sortida(4)+nm);
    % BW_new_branch_point = false(size(BW_new_branch)); BW_new_branch_point(punt_centr+nm, punt_centr+nm) = true;    
    % figure; imshow(imoverlay(BW_new_branch, BW_new_branch_point, "r"), 'InitialMagnification','fit');

    % Sense branchpoint
    BW_new_branch_lit_new = matriu_nova_v;
    BW_new_branch_lit_new(2, 2) = false;
    % imshow(BW_new_branch_lit_new, 'InitialMagnification', 'fit')
    
    % Veiem el nombre d'objectes
    struct_bwcomp = bwconncomp(BW_new_branch_lit_new, 8);
    num_objectes = struct_bwcomp.NumObjects;
    
    % Si el nombre d'objectes és igual a 3, no s'agafen, aquests seràn separats de manera adecuada.
    if num_objectes == 3
        n_three_nonconnpx = n_three_nonconnpx +1;

        % Grafiquem
        % [BW_retallada_skel, ~, ~, ~, ~] = matriu_nova(BW_skel_image, 5, x_branch_point, y_branch_point);
        % BW_retallada_skel_indx = false(size(BW_retallada_skel)); BW_retallada_skel_indx(6,6) = true;
        % figure; imshow(imoverlay(BW_retallada_skel, BW_retallada_skel_indx, "r"), 'InitialMagnification','fit')
        %BW_label_matrix = labelmatrix(bwconncomp(BW_new_branch_lit_new, 8));
        %figure; imshow(BW_label_matrix, [], 'InitialMagnification', 'fit')        
       continue
    end
    
    % BW_label_matrix = labelmatrix(bwconncomp(BW_new_branch_lit_new, 8));
    % imshow(BW_label_matrix, [], 'InitialMagnification', 'fit')


    % _Obtenim els components que són junts de la matriu_
    struct_bwcomp = bwconncomp(BW_new_branch_lit_new, 8);
    pixel_list = struct_bwcomp.PixelIdxList;
    % length(pixel_list{1})
    % length(pixel_list{2})

    % Agafem la cell que té més numeros:
    indx_max_val = 0;
    for c_conn = 1:length(pixel_list)
        if numel(pixel_list{c_conn}) > indx_max_val
            indx_max_val = numel(pixel_list{c_conn});
            indx_max = c_conn;
        end
    end
    index_valors = pixel_list{indx_max};
    % Ara tenim els valors en la imatge indexada.
    % hem de separar-los, i passar-los a la imatge original...
    % BW_false_new = false(size(BW_new_branch_lit_new));
    % BW_false_new(index_valors) = true;
    %imshow(imoverlay(BW_new_branch_lit_new, BW_false_new, "r"), 'InitialMagnification', 'fit')

    
    % _Agafem index dels punts_
    [x_indx, y_indx] = ind2sub(size(BW_new_branch_lit_new), index_valors);
    
    x_indx_new = x_indx - punt_centr(1);
    y_indx_new = y_indx - punt_centr(2);
    
    x_indx_new_bo = x_branch_point + x_indx_new;
    y_indx_new_bo = y_branch_point + y_indx_new; 
    
    % Si els passem a índex:
    indx_new_branch = sub2ind(size(BW_skel_image), x_indx_new_bo, y_indx_new_bo);

    indx_new_branch_total = [indx_new_branch_total; indx_new_branch];
    
    % _Grafiquem_
    % BW_zeros_BWskel = false(size(BW_skel_image)); BW_zeros_BWskel(indx_new_branch) = true;
    %imshow(BW_zeros_BWskel, 'InitialMagnification','fit')
    % Si hol volem graficar millor
    % [BW_retallada_skel, ~, ~, ~, ~] = matriu_nova(BW_skel_image, 5, x_branch_point, y_branch_point);
    % [BW_retallada_skel_indx, ~, ~, ~, ~] = matriu_nova(BW_zeros_BWskel, 5, x_branch_point, y_branch_point);
    % BW_imoverlay = imoverlay(BW_retallada_skel, BW_retallada_skel_indx, "r");
    % BW_imoverlay(6,6,:) = [0, 255, 0];
    % figure; imshow(BW_imoverlay, 'InitialMagnification','fit')
    
end

% % Comprovació
% length(indx_new_branch_total)
% n_three_nonconnpx


end

% FINAL FUNCIÓ