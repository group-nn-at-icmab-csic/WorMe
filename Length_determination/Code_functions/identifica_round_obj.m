function [circul_filtrats, indx_objects, BB_objects] = identifica_round_obj(imatge_circle, threshold_circle)

% Donada una imatge binària amb diversos objectes, d'aquells objectes que tinguin un major valor
% de circularitat (threshold_circle), obté la circularitat d'aquests, els index i els BB.

% See also
% identify_round_objects

% INICI FUNCIO


% Es separa la imatge binària entre aquells objectes que no tenen forats
[B_Bvar,~] = bwboundaries(imatge_circle,'noholes');


% imshow(imatge_circle);

stats = regionprops(imatge_circle,'Area','Centroid', 'BoundingBox', 'PixelIdxList');


% _Obtenció circularitat_
metric_conjunts = [];
for k_k_kvar = 1:length(B_Bvar)    % obtain (X,Y) boundary coordinates corresponding to label 'k'   
    boundary_var = B_Bvar{k_k_kvar};    % compute a simple estimate of the object's perimeter   
    delta_sq = diff(boundary_var).^2;       
    perimeter_var_cir = sum(sqrt(sum(delta_sq,2)));      % obtain the area calculation corresponding to label 'k'   
    area_varc = stats(k_k_kvar).Area;      % compute the roundness metric   
    metric_var = 4*pi*area_varc/perimeter_var_cir^2;      % display the results
    metric_conjunts = [metric_conjunts, metric_var];
end

% Obtenim els valors superiors a la circularitat:
indx_cirucl = metric_conjunts > threshold_circle;

% Valros circularitat filtats
circul_filtrats = metric_conjunts(indx_cirucl);

% Filtrem els stats
% stats 
stats_filtred = stats(indx_cirucl);


% Ho passem a una cell
stats_filtred_cell = struct2cell(stats_filtred);

% Obtenim valors
indx_objects = stats_filtred_cell(4, :);
BB_objects = stats_filtred_cell(3, :);



% FINAL FUNCIÓ


end