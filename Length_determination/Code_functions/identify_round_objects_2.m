function [metric_conjunts, imatge_arxi_ciru] = identify_round_objects_2(imatge_circle, threshold_circle)
% Like identify_round_objects, but without adding text to the image,
% and without subsequently opening it in the MATLAB GUI (and its associated performance load).

% Identifies based on 1 the object or objects in a binary image.
% The idea is to use it for a single binary image.

% Variables:
%   Input
%               'imatge_circle' : binary image to analyze
%               'threshold_circle' : threshold based on 1 to filter
%               the images. It will simply specify graphically which
%               images are above this threshold.
%   Output
%               'metric_conjnuts' : value or values relative to 1

% START FUNCTION



if ~exist('threshold_circle','var')
    threshold_circle = 0;
end

% The binary image is separated between those objects that do not have holes
[B_Bvar,~] = bwboundaries(imatge_circle,'noholes');


%imshow(imatge_circle);
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
        %text(boundary_var(1,2)-75,boundary_var(1,1)+13,metric_string,'Color','y',...    
        %'FontSize',14,'FontWeight','bold');
    end      

end  
%title(['Metrics closer to 1 indicate that ', 'the object is approximately round']);



% Export, read and delete the temporary image (it can't be done any other way)
%exportgraphics(gca, 'tempraryFile_image_round_identif.png');
%imatge_arxi_ciru = imread("tempraryFile_image_round_identif.png");
%delete tempraryFile_image_round_identif.png

imatge_arxi_ciru = put_txt_to_img(imatge_circle, "Circularity: ", string(round(metric_conjunts, 2)), "auto");

% imshow(imatge_arxi_ciru)

% END FUNCTION

