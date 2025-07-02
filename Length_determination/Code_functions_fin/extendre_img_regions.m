function [BW_img_final] = extendre_img_regions(BW_img_ini, regions_xywh, BW_img_ajunt)

% Given an original image, and an image to be joined within it, in certain positions, joins the regional image with the general image.
%
% (CAT)
% Donada una imatge original, i una imatge a juntar dins d'aquesta, en unes unes posicions
% determinades, ajunta la imatge regional amb la imatge general.
%
% Temps de processament
% Elapsed time is 0.004980 seconds.
%
%
%
% _Variables_
% input:
% BW_img_ini   : imatge binaria original
% regions_xywh : regions de juntar
% BW_img_ajunt : imatge binaria a juntar
%
%
%
%
% Exemple retallat i re-escalat de la imatge retallada:
% imshow(BW_final_object)
% [imageArray_crop, BW_filt_crop, prop_BB, proporcio_img] = retallar_BWRGBimatge_BB_nou(imageArray, BW_final_object, 5);
% imshow(BW_filt_crop)
% BW_img_final_sized = extendre_img_regions(BW_final_object, proporcio_img, BW_filt_crop);
% imshow(BW_img_final_sized)
% unique(BW_img_final_sized == BW_final_object)
%
%
%
% Exemple 2:
% I_rice = imread("rice.png"); imshow(I_rice)
% BW_rice = imbinarize(I_rice); imshow(BW_rice)
% BW_rice_singular = bwpropfilt(BW_rice, "Area", 1, "largest");
% imshow(BW_rice_singular)
% 
% [BW_rice_singular_cut, proporcio_img_rice] = retallar_BWimatge_BB(BW_rice_singular, 5);
% figure; imshow(BW_rice_singular_cut)
% 
% % Sum it to an original-like image
% [BW_rice_singular_other] = extendre_img_regions(false(size(I_rice)), proporcio_img_rice, BW_rice_singular_cut);
% imshow(BW_rice_singular_other)
%
%
% See also
% retallar_BWRGBimatge_BB
% retallar_BWimatge_BB
% retallar_BWRGBimatge_BB_nou


% START FUNCTION

% Definim la dimensió de la imatge:
[~, ~, dimensio] = size(BW_img_ini);

if dimensio == 1
    % En imatges binàries o grisos:
    BW_img_ini(regions_xywh(2) : (regions_xywh(2) + regions_xywh(4)) , regions_xywh(1) : (regions_xywh(1) + regions_xywh(3)) ) = BW_img_ajunt;
    BW_img_final = BW_img_ini;
elseif dimensio == 3
    % En imatges RGB
    BW_img_ini(regions_xywh(2) : (regions_xywh(2) + regions_xywh(4)) , regions_xywh(1) : (regions_xywh(1) + regions_xywh(3)), : ) = BW_img_ajunt;
    BW_img_final = BW_img_ini;
else
    msgbox("No dimension error in f' extendre_img_regions")
end

% END FUNCTION


end