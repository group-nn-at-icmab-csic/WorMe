function [BW_ini_regio_cropped, BB_values, proporcio_img_new] = retallar_BWimatge_BB_2(BW_ini_regio, percentatge_img_origin)

% Given a binary image with just an object, bounding box is generated and
% is obtained the main cropped region, and their data (proportions,
% coordinates).
% This function is very useful for optimize process.
%
%
% Donada una imatge on sols hi ha un objecte binari, es fa un bounding box
% d'aquesta i s'obté la imatge original d'aquesta.
%
% UPGRADE de retallar_BWRGBimatge_BB_nou: s'han tret els RGB.
%
% Variables 
% BW_ini_regio : imatge binaria amb sols l'objecte binari
%
% percentatge_img_origin :  percentatge en que s'agrandarà el bounding box
%                           de l'objecte binari. Necessari que sigui major si es volen obtenir
%                           regións externes al bounding box inicial (ex: no es selecciona la cua).
%                           ex: 5
% 
% Output
% BW_ini_regio_cropped : imatge binària retallada
%
%
%
% Exemple retallat i re-escalat de la imatge retallada:
% imshow(BW_final_object)
% [imageArray_crop, BW_filt_crop, prop_BB, proporcio_img] = retallar_BWRGBimatge_BB_nou(imageArray, BW_final_object, 5);
% imshow(BW_filt_crop)
% 
% BW_img_final_sized = extendre_img_regions(BW_final_object, proporcio_img, BW_filt_crop);
% imshow(BW_img_final_sized)
% 
% unique(BW_img_final_sized == BW_final_object)
%
%
% % % _Exemple 2_
% imshow(BW_final)
% [BW_ini_regio_cropped, BB_values, proporcio_img_new] = retallar_BWimatge_BB_2(BW_final, 4);
% imshow(BW_ini_regio_cropped)
% 
% % Obtenim els index
% [indx_BW_scal] = escalar_indx(find(BW_ini_regio_cropped), size(BW_final), size(BW_ini_regio_cropped), proporcio_img_new);
% 
% % Comparacio index:
% unique(find(BW_final) == indx_BW_scal)
% 
% % Comparació visual:
% BW_scaled = false(size(BW_final));
% BW_scaled(indx_BW_scal) = true;
% imshowpair(BW_scaled, BW_final)
%
%
%
%
%
% See also
% retallar_BWRGBimatge_BB
% retallar_BWRGBimatge_BB_nou
% extendre_img_regions
% correccio_sortida_dimensios

% START FUNCTION 

prop_regions_BW = regionprops(BW_ini_regio,'BoundingBox');  %<--- rellevant
[valor_percentual_imatge] = percentatge_imatge(BW_ini_regio, percentatge_img_origin);

BB_values = prop_regions_BW.BoundingBox;

proporcio_img = round(prop_regions_BW.BoundingBox + valor_percentual_imatge .* [-1 -1 2 2]);

% Proporcio antiga inicial
%[BW_ini_regio_cropped] = imcrop(BW_ini_regio, proporcio_img);        %Es retalla la imatge basant-se amb el BoundingBox.
%imshow(BW_ini_regio_cropped)
%size(BW_ini_regio_cropped)

% _Correcció possible sortida de les mesures_
[proporcio_img_new] = correccio_sortida_dimensios(proporcio_img, size(BW_ini_regio)); %ex: 1080        1920


[BW_ini_regio_cropped] = imcrop(BW_ini_regio, proporcio_img_new);        %Es retalla la imatge basant-se amb el BoundingBox.
% imshow(BW_ini_regio_cropped)
% size(BW_ini_regio_cropped)


% END FUNCTION

end
