function [valors_lineals_bwdist] = linear_bwdist_values_new(BW_filt_crop, BW_skel)

% Donada una imatge binaria i el seu esquelet, es retorna els valors
% lineals (ordenats) de l'amplada respecte el perímetre més proper (funcio
% bwdist) de cada punt de l'esquelet.
% Upgrade millorat: width_bwskeldist_values
% 
% See also 
% width_bwskeldist_values

% INICI FUNCIÓ

% Mirem el bwdist
BW_bwdist = bwdist(~BW_filt_crop);
% imshow(BW_bwdist, [])



% Si fem bwdistgeodesic

B =  bwmorph(BW_skel,'endpoints');
indx_endpoints = find(B);

D = bwdistgeodesic(BW_skel,indx_endpoints(1),'quasi');

% Però ara tenim sols els elements que no son NaN
newD = D(~isnan(D));

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
tic
% Tarda molt
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



% FINAL FUNCIÓ


end