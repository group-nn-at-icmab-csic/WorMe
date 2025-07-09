function [circul_filtrats, indx_objects, BB_objects] = identify_round_obj(imatge_circle, threshold_circle)

% Given a binary image with several objects, from those objects that have a higher circularity value
% (threshold_circle), obtain the circularity of these, the indexes and the BBs.

% See also
% identify_round_objects

% START FUNCTION


% The binary image is separated between those objects that do not have holes
[B_Bvar,~] = bwboundaries(imatge_circle,'noholes');


% imshow(imatge_circle);

stats = regionprops(imatge_circle,'Area','Centroid', 'BoundingBox', 'PixelIdxList');


% _Circularity obtention_
metric_conjunts = [];
for k_k_kvar = 1:length(B_Bvar)    % obtain (X,Y) boundary coordinates corresponding to label 'k'   
    boundary_var = B_Bvar{k_k_kvar};    % compute a simple estimate of the object's perimeter   
    delta_sq = diff(boundary_var).^2;       
    perimeter_var_cir = sum(sqrt(sum(delta_sq,2)));      % obtain the area calculation corresponding to label 'k'   
    area_varc = stats(k_k_kvar).Area;      % compute the roundness metric   
    metric_var = 4*pi*area_varc/perimeter_var_cir^2;      % display the results
    metric_conjunts = [metric_conjunts, metric_var];
end

% Obtain the major circularity levels:
indx_cirucl = metric_conjunts > threshold_circle;

% Filtered circularity levels
circul_filtrats = metric_conjunts(indx_cirucl);

% Filter the stats
% stats 
stats_filtred = stats(indx_cirucl);


% To a cell
stats_filtred_cell = struct2cell(stats_filtred);

% We obtain the values
indx_objects = stats_filtred_cell(4, :);
BB_objects = stats_filtred_cell(3, :);



% FINAL OF THE FUNCTION


end