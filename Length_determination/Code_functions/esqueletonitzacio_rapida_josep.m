function [BW_skel, sfMaskBurn_new] = esqueletonitzacio_rapida_josep(BW_img, img_example)


% Esqueletonització d'una imatge per a retornar la visualització d'aquesta
% amb la imatge original.
%
%
% Variables:
% BW_img  : imatge binaria.
%
%
%

BW_skel = bwskel(BW_img);

sfMaskBurn = imoverlay(img_example, BW_img, "k");
sfMaskBurn_new = imoverlay(sfMaskBurn, BW_skel, "r");  

end