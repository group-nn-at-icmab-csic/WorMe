function [Area_Josep] = determinar_area_josep_bw(BW_skel)

% Es retorna l'àrea d'una línea, o conjunt.
% La imatge binària no pot tenir volum, doncs s'analitza l'area de la línea. 

% %Variables exemple
% BW_skel = bwskel(imatge_primera_retallada);
% imshow(BW_skel, 'InitialMagnification','fit')

% Agrandim la línia d'esqueletonització, per a una millor graficació.
% La opció 'diag' el que fa és unir aquells pixels que tenen una separació
% diagonal entre sí.
%      0  1  0           0  1  0 
%      1  0  0  becomes  1  1  0 
%      0  0  0           0  0  0

BW_skel_diag = bwmorph(BW_skel, 'diag');
% imshow(BW_skel_diag, 'InitialMagnification','fit')

% BW_skel_diag_show = BW_skel - BW_skel_diag;
% BW_final_skel = imoverlay(BW_skel, BW_skel_diag_show, 'r');
% imshow(BW_final_skel, 'InitialMagnification','fit')
% Recordem, que aquesta imatge és per a graficar, no és vàlida per a ser
% emprada per a anàlisis.


%Area de la imatge esqueletonitzada
Area_skel = sum(BW_skel(:));

%Area de la imatge esqueletonitzada, i modificada angles pixels
Area_skel_diag = sum(BW_skel_diag(:));

%Area de la imatge esqueletonitzada, segons teoria Josep
% 1. de l'esqueletonització inicial, es resten el valor dels pixels singulars diagonals, i es suma aquell mateix valor multiplicat per arrel cuadrada de 2,
% lo qual pertany a la distancia diagonal de dos rectes de distancia 1.
% 2. cada un dels dos pixels de 'diag' que s'atribueixen a cada pixel diagonal.

Area_diag = (Area_skel_diag - Area_skel)/2; % piels diagonals. Es divideix per 2 perque per a cada cantonada es generen dos pixels. Això ocórre, pero, sol en imatges de píxels linears, esqueletonitzades.
Area_Josep = Area_skel - Area_diag + Area_diag * sqrt(2);


end