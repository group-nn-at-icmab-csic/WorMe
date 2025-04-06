function [imageArray_cropped, BW_ini_regio_cropped, BB_values, proporcio_img_new] = retallar_BWRGBimatge_BB_nou(imageArray, BW_ini_regio, percentatge_img_origin)

% Given an image where there is only one binary object, a bounding box is made of it and the original image of it is obtained.
% Optimized the cutof binary object in the 'retallar_BWimatge_BB_2' function.
%
% (CAT)
% Donada una imatge on sols hi ha un objecte binari, es fa un bounding box
% d'aquesta i s'obté la imatge original d'aquesta. 
% OPTIMITZABLE si es treuen els retorns de les imatges.
%
% Variables 
% imageArray  : RGB image
%
% BW_ini_regio : Binary image with just the binary object.
%
% percentatge_img_origin :  
%                           percentage by which the bounding box of the binary object 
%                           will be enlarged. It must be greater if you want to 
%                           obtain regions external to the initial bounding box 
%                           (eg: the queue is not selected). ex: 5
%
%                           (CAT)
%                           percentatge en que s'agrandarà el bounding box
%                           de l'objecte binari. Necessari que sigui major si es volen obtenir
%                           regións externes al bounding box inicial (ex: no es selecciona la cua).
%                           ex: 5
% 
% Output
% imageArray_cropped : cutter original image
% BW_ini_regio_cropped : cutted binary image
% BB_values : BB values
% proporcio_img_new : proportion values
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
%
% See also
% retallar_BWRGBimatge_BB
% retallar_BWRGBimatge_BB_nou
% extendre_img_regions
% correccio_sortida_dimensios
% retallar_BB_BWimg

% INICI FUNCIÓ 

prop_regions_BW = regionprops(BW_ini_regio,'BoundingBox');  %<--- rellevant
[valor_percentual_imatge] = percentatge_imatge(BW_ini_regio, percentatge_img_origin);

BB_values = prop_regions_BW.BoundingBox;

proporcio_img = round(prop_regions_BW.BoundingBox + valor_percentual_imatge .* [-1 -1 2 2]);

% Mirem si el valor és zero. Si ho és, el cambiem a 1.
% Si hi ha un zero:
if sum(ismember(proporcio_img, 0)) > 0
    % Redefinim el valor igual a 1:
    proporcio_img(ismember(proporcio_img, 0)) = 1;
end

% Proporcio antiga inicial
%[BW_ini_regio_cropped] = imcrop(BW_ini_regio, proporcio_img);        %Es retalla la imatge basant-se amb el BoundingBox.
%imshow(BW_ini_regio_cropped)
%size(BW_ini_regio_cropped)

% _Correcció possible sortida de les mesures_
[proporcio_img_new] = correccio_sortida_dimensios(proporcio_img, size(BW_ini_regio)); %ex: 1080        1920


[BW_ini_regio_cropped] = imcrop(BW_ini_regio, proporcio_img_new);        %Es retalla la imatge basant-se amb el BoundingBox.
% imshow(BW_ini_regio_cropped)
% size(BW_ini_regio_cropped)

imageArray_cropped = imcrop(imageArray, proporcio_img_new);
%imshow(imageArray_cropped)

% FINAL FUNCIÓ

end
