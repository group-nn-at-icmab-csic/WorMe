function [llist_BW_identif, BW_bwselect_igual_punts, imatge_montatge_sortida] = compara_BW_objecte_coincident(BW_conjuntes_comparar, BW_aillar)

% Funcio sobre comparar una imatge binària amb una carpeta d'imatges, per a
% obtenir la imatge coincident binàriament. Llavors s'obté el nom d'aquesta
% imatge. (aquest es l'objectiu final).
% S'empra la f'identifica_pump_anterior_nou'. 
%
% Condicions: ambdós imatges han d'estar binaritzades.
%
% Variables
% BW_aillar              :  Imatge binària d'objecte singular, el qual es vol aïllar.
% BW_conjuntes_comparar  :  Imatge binària amb varis objectes binaris. A comparar amb la BW_aillar.
%
% See also
% identifica_pump_anterior_nou


% INICI FUNCIO

% Esqueletonitzem la nostra imatge d'entrada (estalviar problemes)
BW_aillar_skel = bwskel(BW_aillar);
%imshow(BW_aillar_skel)


% Controls prèvis
% Si alguna de les dos imatges no és binària
if length(unique(BW_aillar(:)))>2 || length(unique(BW_conjuntes_comparar(:)))>2
    f = msgbox('Non binary image', 'Error','error');
end

% Veiem el nombre d'elements de la BW de varis objectes.
[~, nombre_elements] = bwlabel(BW_conjuntes_comparar);

% Control que hi hagi elements
if nombre_elements == 0
    f = msgbox("No hi ha elements binaris", 'Error','error');
end


% Identifica pump anterior
[llist_BW_identif, BW_bwselect_igual_punts, imatge_montatge_sortida] = identifica_pump_anterior_nou(BW_conjuntes_comparar, BW_aillar_skel, "", false, "");


% Notes: si no hi ha imatge coincident, la v'llist_BW_identif' és vuida (empty).
% Això servirà per a emprar aquesta opció per a filtrar les imatges.
% % Exemple si la imatge és zeros
% BW_zero = zeros(size(BW_aillar));
% [llist_BW_identif, BW_bwselect_igual_punts, imatge_montatge_sortida] = identifica_pump_anterior_nou(BW_conjuntes_comparar, BW_zero, "", false, "");


% Control més d'una imatge detectada.
if length(llist_BW_identif) > 1
    f = msgbox("More than a image", 'Error','error');
end

% FINAL FUNCIÓ

end