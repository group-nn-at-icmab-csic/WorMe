function [metric_conjunts, imatge_arxi_ciru] = identify_round_objects(imatge_circle, threshold_circle)

% Identifica en base a 1 l'objecte o objectes d'una imatge binària.
% La idea es fer servir per a imatge binaria singular

% Variables:
%   Input
%               'imatge_circle' : imatge binària a analitzar
%               'threshold_circle' : llindar en base a 1 sobre el que es
%               volen filtrar les imatges. Simplement espeficicarà de
%               manera gràfica quines imatges són per sobre d'aquest
%               llindar.
%   Output
%               'metric_conjnuts' :  valor o valors respecte 1 

% INICI FUNCIÓ


if ~exist('threshold_circle','var')
    threshold_circle = 0;
end

% Es separa la imatge binària entre aquells objectes que no tenen forats
[B_Bvar,~] = bwboundaries(imatge_circle,'noholes');


imshow(imatge_circle);
metric_conjunts = [];
stats = regionprops(imatge_circle,'Area','Centroid');  % loop over the boundaries 
for k_k_kvar = 1:length(B_Bvar)    % obtain (X,Y) boundary coordinates corresponding to label 'k'   
    boundary_var = B_Bvar{k_k_kvar};    % compute a simple estimate of the object's perimeter   
    delta_sq = diff(boundary_var).^2;       
    perimeter_var_cir = sum(sqrt(sum(delta_sq,2)));      % obtain the area calculation corresponding to label 'k'   
    area_varc = stats(k_k_kvar).Area;      % compute the roundness metric   
    metric_var = 4*pi*area_varc/perimeter_var_cir^2;      % display the results
    metric_conjunts = [metric_conjunts, metric_var];
    metric_string = sprintf('%2.2f',metric_var);    % mark objects above the threshold with a black circle   
    if metric_var > threshold_circle 
%         centroid = stats(k).Centroid;     
%         plot(centroid(1),centroid(2),'ko');   
        text(boundary_var(1,2)-75,boundary_var(1,1)+13,metric_string,'Color','y',...    
        'FontSize',14,'FontWeight','bold');
    end      

end  
title(['Metrics closer to 1 indicate that ',...      
'the object is approximately round']);


% Exportem, llegim i eliminem la imatge temporal (no ho se fer d'una altre manera)
exportgraphics(gca, 'tempraryFile_image_round_identif.png');
imatge_arxi_ciru = imread("tempraryFile_image_round_identif.png");
delete tempraryFile_image_round_identif.png

% imshow(imatge_arxi_ciru)

% FINAL FUNCIÓ