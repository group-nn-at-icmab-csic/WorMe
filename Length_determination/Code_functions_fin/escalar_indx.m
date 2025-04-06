function [indx_BW_scal] = escalar_indx(indx_BWcrop, size_BW, size_BWcrop, proporcio_img)

% Given a cropped binary image, this function returns the indices of the image in the scaled image.
%
% Variables
% indx_BWcrop - Indices of the object(s) in the cropped binary image
% size_BW - Dimensions of the binary image
% size_BWcrop - Dimensions of the cropped binary image
% proporcio_img - Proportion measurements of the crop (obtained from the function retallar_BWRGBimatge_BB)
%
%
% _Spanish_
% Dada una imagen binaria recortada, se devuelven los índices de esta imagen en la imagen escalada.
%
% Variables
% indx_BWcrop - Índices del objeto(s) en la imagen binaria recortada
% size_BW - Dimensiones de la imagen binaria
% size_BWcrop - Dimensiones de la imagen binaria recortada
% proporcio_img - Mediciones de proporción del recorte (obtenidas de la función retallar_BWRGBimatge_BB)
%
%
% _Catalan language_
% Donada una imatge binaria retallada, es retornen els index d'aquesta en
% la imatge escalada.
%
% Variables
% indx_BWcrop   - Index de l'objecte/s de la imatge binaritzada retallada
% size_BW       - dimensions de la imatge binaria
% size_BWcrop   - dimensions de la imatge binaria retallada
% proporcio_img - mesures de proporció del retall (Obtingudes de la funció retallar_BWRGBimatge_BB)
%
%
%
% Temps de processament: 0.0018s (50 loops, 8Gb Ram)
%
% Exemple d'aplicació:
% montage({BW_filt, BW_filt_crop, imageArray, imageArray_crop_new})
% % Funció escalar índex (f'escalar_indx)
% [indx_BW_scal] = escalar_indx(indx_BWobj, size(BW_filt), size(BW_filt_crop), proporcio_img);
% % Funció printar la regió
% [imageArray_new] = pintar_BWindx_RGB(imageArray, imageArray_crop_new, indx_BWobj, indx_BWobj_escalat);
% imshow(imageArray_new)
%
%
%
% % _Exemple 2_
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
% See also
% retallar_BWRGBimatge_BB
% pintar_BWindx_RGB_new

% INICI FUNCIÓ

% Passem a x,y de la imatge retallada
[x_BWobj, y_BWobj] = ind2sub(size_BWcrop, indx_BWcrop);

% Escalem els valors
x_BWobj_nou = x_BWobj + proporcio_img(2) -1; %Restem 1 per correcció de la suma.
y_BWobj_nou = y_BWobj + proporcio_img(1) -1; %Restem 1 per correcció de la suma.

% Ara ho passem a index:
indx_BW_scal = sub2ind(size_BW, x_BWobj_nou, y_BWobj_nou);

% FINAL FUNCIÓ

end