function [BW_skel, sfMaskBurn_new] = esqueletonitzacio_rapida_josep(BW_img, img_example)


% Skeletonization of an image to return the display of this
% with the original image.
%
%
% Variables:
% BW_img  : Binary image.
%
%
%

BW_skel = bwskel(BW_img);

sfMaskBurn = imoverlay(img_example, BW_img, "k");
sfMaskBurn_new = imoverlay(sfMaskBurn, BW_skel, "r");  

end