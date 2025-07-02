function [BW_amplada_crop] = crop_regioskel_imatge(BW_amplada, imatge_zeros)

% START OF SCRIPT

% Given a region of the initial skeletonized binary image, the image cropped by said region is
% returned, with the aim of, at
% a posteriori, obtaining the width of this region of the image.

% Variables:
% image_zeros - skeletonized image
% BW_amplada- initial binary image, to be cropped

punts_ini_fini_im = bwmorph(imatge_zeros, 'endpoints');

[row_find, col_find] = find(punts_ini_fini_im);

BW_amplada_crop = BW_amplada(row_find(1):row_find(2), col_find(1):col_find(2));
imshow(BW_amplada_crop)

% FINAL SCRIPT