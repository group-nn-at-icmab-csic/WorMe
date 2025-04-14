function [Area_Josep] = llargada_josep(BW_skel)

% Donada una imatge esqueletonitzada, retorna la llargada d'aquesta.


% Agrandim la línia d'esqueletonització, per a una millor graficació.
% La opció 'diag' el que fa és unir aquells pixels que tenen una separació
% diagonal entre sí.
%      0  1  0           0  1  0 
%      1  0  0  becomes  1  1  0 
%      0  0  0           0  0  0

BW_skel_diag = bwmorph(BW_skel, 'diag');

%BW_final_skel = imoverlay(BW_final, BW_skel_diag, 'r');
%BW_final_skel = BW_final_skel.CData;
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

Area_diag = (Area_skel_diag - Area_skel)/2;
Area_Josep = Area_skel - Area_diag + Area_diag * sqrt(2);



% % Probes
% % Proba imatge amb 1 pixel
% BW_prob = false([10, 10]); BW_prob(3,3) = true;
% [Area_Josep] = llargada_josep(BW_prob)


end