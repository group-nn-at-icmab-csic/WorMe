function [BW_amplada_crop] = crop_regioskel_imatge(BW_amplada, imatge_zeros)

% INICI SCRIPT

% Donada una regió de la imatge binària inicial esqueletonitzada, es
% retorna la imatge retallada per tal regió, amb l'objectiu de, a
% posteriori, obtenir l'amplada d'aquesta regió de la imatge.

% Variables:
% imatge_zeros - imatge esqueletonitzada
% BW_amplada - imatge binaria inicial, a ser retallada

punts_ini_fini_im = bwmorph(imatge_zeros, 'endpoints');

[row_find, col_find] = find(punts_ini_fini_im);

BW_amplada_crop = BW_amplada(row_find(1):row_find(2), col_find(1):col_find(2));
imshow(BW_amplada_crop)

% FINAL SCRIPT