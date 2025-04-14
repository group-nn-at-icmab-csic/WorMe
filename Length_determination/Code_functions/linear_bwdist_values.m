function [valors_lineals_bwdist, BW_skel_large] = linear_bwdist_values(BW_filt_crop)

% Donat un objecte binari, aquest s'esqueletonitza fins a sols una branca,
% i es retornen els valors ordenats d'aquesta branca refrents al bwdist, es
% a dir, a la distancia d'aquests punts amb el perímetre més proper.
%
% Upgrade millorat: width_bwskeldist_values
% 
% See also 
% width_bwskeldist_values
 
% INICI FUNCIO

% Esqueletonitzem l'objecte
BW_skel = bwskel(BW_filt_crop);

% figure; montage({imageArray_crop, BW_filt_crop, imoverlay(BW_filt_crop, BW_skel, "r")})

% Retallem l'objecte
% imshow(BW_skel)

% Si fem el unica sequelet més llarg
[BW_skel_large] = large_skel_iter(BW_skel);
% imshow(imoverlay(BW_filt_crop, BW_skel_large, "r"))

% Mirem el bwdist
BW_bwdist = bwdist(~BW_filt_crop);
% imshow(BW_bwdist, [])


% Si obtenim els valors en les posicions
% BW_bwdist(BW_skel_large)
indx_BWskel = find(BW_skel_large);

% Si obtenim el bwdist de la imatge esqueletonitzada unica
% imshow(~bwdist(BW_skel_large), [])

% Tots els valors són 1.


% Si fem bwdistgeodesic

It = BW_skel_large;
B =  bwmorph(It,'endpoints');
indx_endpoints = find(B);

D = bwdistgeodesic(It,indx_endpoints(1),'quasi');
% imshow(D, [])
% unique(D(:))

% Per cada punt tenim un valor.
% Ara no tenim els index ordenats "a boleo", sino que tenim per cada regió del bwskel un valor. Això ens permetrà relacionarho amb el valor de bwdist per tal de fer un llistat de valors continus que serà relatiu a l'amplada.

% numel(unique(D))
% numel(sort(D))
% size(D)

% Però ara tenim sols els elements que no son NaN
newD = D(~isnan(D));
% numel(unique(newD))
% numel(sort(newD))
% size(newD)

% Veiem que cada element de la llista té un valor


% plot(newD)
% Veiem que és irregular. Això és perquè cada valor no és lineal, sino que es definit per la posicio en l'eix y, de manera que algunes posicions passen per davant d'altres.

% Si ho ordenem:
% plot(sort(newD))

% Ho posem a variable
newDsort = sort(newD);

% El que hem de relacionar es aquest valor amb el de la imatge esqueletonitzada.
% (es chapuza, pero de moment es el que tiraria...)
% find(D == newDsort(1))

% Aquest és el punt 1 de la imatge esqueletonitzada.
% Si fem aixo per a cada element
indx_D_ordenats = [];
for n_D = 1:length(newDsort)
    indx_D_ordenats = [indx_D_ordenats, find(D == newDsort(n_D))];
end

% Aquests, teoricament, són els index ordenats de cada element del BWskel
% indx_D_ordenats

% Ok, que tenim? tenim la BWskel llargada, i el bwdist d'aquesta. De la mateixa manera, tenim de forma ordenada els index de cada punt de BWskel.
% D'aquesta manera podem obtenir el valor de bwdist per cada valor de BWskel, perque obtenim el punt del index ordenat, es a dir, el punt 1, 2, 3, 4, etc. de l'esqueletonització, i aquest en la imatge de bwdist obtenim el valor, que serà relatiu a la distancia amb l'objecte binaritzat.
% BW_bwdist(indx_D_ordenats)

valors_lineals_bwdist = BW_bwdist(indx_D_ordenats);

% Si ho grafiquem:
% plot(BW_bwdist(indx_D_ordenats))


% FINAL FUNCIO

end