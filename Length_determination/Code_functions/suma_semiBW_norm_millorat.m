function imageArray_fintot = suma_semiBW_norm_millorat(imageArray, BW_semi)

% Donada una imatge en 3D normal  (imageArray), i una altre en 3D tipu binària (BW_semi), és a dir, on gran part dels seus
% valors tenen valors 0, però altres tenen valor entre 0 i 255, es
% superposa la imatge binària a la imatge en 3D.
%
% _Variables_
%
% imageArray  : Imatge RGB en 3D
% BW_semi     : Imatge RBG en 3D, amb molts espais amb 0's.
%
% % Variables exemple
% BW_semi = new_object_colored;
% imshow(BW_semi)
% imshow(imageArray)
%
%
% COMBINACIÓ IMATGES
% El que fem és combinar la imatge principal v'imageArray' amb la imatge
% semibinària v'zeros_imatge', la qual té tres matrius i va de 0 a 255.
% Per a fer-ho, hem de passar la imatge principal a 'double',
% posar a zeros els llocs on coincideixen amb la imatge binària, i llavors
% sumar la imatge semibinaria, per a cada dimensió de la matriu,
% de manera que simplement es restin els llocs de la imatge binària i se li
% sumin els de la mateixa imatge binaria pero amb color.
%
%
% % See also
% BW_objects_to_color
% suma_semiBW_norm

% INICI FUNCIÓ

if size(BW_semi) ~= size(imageArray)
    msgbox('Images different size', 'Error','error');
    error("Error in f'suma_semiBW_norm_millorat': Images different size")
end


% Definim la imatge binària.
BW_proba_temp = BW_semi(:,:,1);
BW_proba = imbinarize(BW_proba_temp); 
% Fem imbinarize i no 'im>0' perquè al ser la imatge exportada possiblement d'un '.jpg', aquesta
% pot donar píxels que tinguin valors de 1,2,3, fet que distorsionaria la
% filtració. %BW_proba = BW_proba_temp > 0;
% unique(BW_proba)
% imshow(BW_proba)


% Passem a double (per a poder operar matemàticament, si està a uint8 no es
% pot)
imageArray = double(imageArray);


imageArray_1 = imageArray(:,:,1);
imageArray_1(BW_proba) = 0;
%imshow(imageArray_1)
%imageArray_1 = logical(imageArray_1);
imageArray_1_fin = imageArray_1 + double(BW_semi(:, :, 1));

imageArray_2 = imageArray(:,:,2);
imageArray_2(BW_proba) = 0;
imageArray_2_fin = imageArray_2 + double(BW_semi(:, :, 2));

imageArray_3 = imageArray(:,:,3);
imageArray_3(BW_proba) = 0;
imageArray_3_fin = imageArray_3 + double(BW_semi(:, :, 3));

% Juntem les tres matrius
imageArray_fintot = cat(3, imageArray_1_fin, imageArray_2_fin, imageArray_3_fin);

% Tornem a passara uint8.
imageArray_fintot = uint8(imageArray_fintot);
%imshow(imageArray_fintot)

% FINAL FUNCIÓ

end