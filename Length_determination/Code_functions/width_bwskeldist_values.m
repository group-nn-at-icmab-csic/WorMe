function [bwdist_elem_order, indx_orders] = width_bwskeldist_values(BW_filt_crop, BW_skel)

% Donada una imatge binària i la seva esqueletonització, es retornen els
% valors de l'amplada, segons bwdist, de cada punt de la esqueletontizació,
% de forma ordenada.
%
% Variables:
% input:
%   BW_filt_crop : Objecte binari
%   BW_skel : objecte esqueletonitzat
% output:
%   bwdist_elem_order: valor de l'amplada de cada element.
%
% Temps processament: Elapsed time: 0.0054757 seconds in 50 iterations.
%
% Veure: 2022_09_14_Proba_amplada_valors_bwskel_en_bwdist per a millor
% explicació.
%
%
% Upgrade de: linear_bwdist_values i linear_bwdist_values_new

% INICI FUNCIÓ


% Mirem el bwdist
BW_bwdist = bwdist(~BW_filt_crop);
% imshow(BW_bwdist, [])


% Si fem bwdistgeodesic
B =  bwmorph(BW_skel,'endpoints');
indx_endpoints = find(B);

if ~isempty(indx_endpoints)
    D = bwdistgeodesic(BW_skel, indx_endpoints(1),'quasi');
    
    % Però ara tenim sols els elements que no son NaN
    newD = D(~isnan(D));
    newD_indx = find(~isnan(D));
    % upgrade: Cada valor té un index. Ambdós són desordenats.
    
    % Veiem que és irregular. Això és perquè cada valor no és lineal, sino que es definit per la posicio en l'eix y, de manera que algunes posicions passen per davant d'altres.
    
    % Si ho ordenem:
    % plot(sort(newD))
    
    % Ho posem a variable
    [~, sortIndx] = sort(newD);
    
    % plot(newD)
    % plot(sortIndx)
    % upgrad: Cada valor té una numeració numèrica: 1, 2, 3, 4...
    
    % Elements de newD_indx (index de cada valor) ordenats, es a dir, de cada
    % element ordenat (relatiu a la consecutiva de l'esquelet, per la
    % consecutiva del bwgesdist) el seu index, de forma ordenada.
    indx_orders = newD_indx(sortIndx);
    
    bwdist_elem_order = BW_bwdist(indx_orders);
    
    % plot(bwdist_elem_order)
else
    bwdist_elem_order = 0;
    indx_orders = 0;

end


% FINAL FUNCIÓ


end