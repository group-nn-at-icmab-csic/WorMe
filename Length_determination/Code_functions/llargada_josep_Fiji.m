function [Area_Josep] = llargada_josep_Fiji(BW_skel, cada_nx)

% Donada una imatge esqueletonitzada, retorna la llargada d'aquesta,
% aplicant la correcció de les dades per l'error manual.
%
% L'error manual esdevé de entre la distancia que hi ha entre cada pixel, i
% de la distància que hi ha cada X pixels, el que ocórre quan s'agafa la
% mesura de forma manual (no s'agafa cada pixel sino en total potser son 10
% punts).


% INICI FUNCIÓ

% Obtenim els index ordenats>
[~, indx_orders] = width_bwskeldist_values(BW_skel, BW_skel);

% Obtenim la distancia de la forma que proposavem:
[x_r, y_c] = ind2sub(size(BW_skel), indx_orders);

punts_xy = [x_r, y_c];

% Correcció cada 10 pixels:
% Agafem els punts de cada 35 pixels
pos_punts = 1:cada_nx:length(punts_xy);
% Afegim el final:
pos_punts = [pos_punts, length(punts_xy)];

if length(punts_xy(:,1)) > 1
    punts_xy_nou = punts_xy(pos_punts,:);
    
    % hold on;
    % plot(punts_xy_nou(:, 2), punts_xy_nou(:, 1), 'b.','markersize',6)
    % hold off
    
    % _Obtencio dels punts_
    sum_punts = 0;
    for cada_punt = 1:height(punts_xy_nou) -1
        puntdist = [punts_xy_nou(cada_punt, :); punts_xy_nou(cada_punt +1, :)];
        d_punts = pdist(puntdist,'euclidean');
        sum_punts = sum_punts + d_punts;
    end
    
    Area_Josep = sum_punts;
else
    Area_Josep = 1;
end

% FINAL FUNCIÓ

end