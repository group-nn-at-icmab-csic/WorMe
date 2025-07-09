function [BW_skel_final_estes] = skel_elongate(BW_inicial, BW_skel, opc_ext, ext_val)

% Given a binary image and its skeleton, the skeleton is extended to the edge of the object.
%
% It is based on creating a line that has the least variation among the
% set of angles formed between the line and each specific point.
% In other words, it finds the line that is most similar to
% the last pixels of the skeleton line.
%
% Variables
%
% Input
% BW_initial: Initial binary image
%
% BW_skel: Initial skeletonized image
%
% ext_option: Determines the option for extending the skeletonized image
%           "fixed": Fixed; defines a fixed value as the number
%                   of pixels by which the matrix will be extended.
%           "prop": Proportional; defines a percentage value relative
%                   to the total length of the skeletonized image, by which the matrix will be extended.
%
% Output
% BW_final_extended_skel: Final skeletonized image after extension
%
% Internal Functions
% new_matrix: Creates a matrix based on a point in the image. This allows
% operating only in that region.
%
%
% Upgrade regarding extend_skel_extension:
% Option to specify the extension value of the skeletonization, beyond
% what is determined by the distance of the endpoints in bwdist.
% This means that the region (matrix) around the endpoint is expanded,
% including the skeletonized image within it. This allows determining
% the angle with the longest length of the skeletonized image and the
% largest perimeter. The parameters ext_option and ext_value are added.
%
%
% Processing time
% Elapsed time is 0.057187 seconds.
%
% See also
% matriu_nova
% extendre_skel_estes

%imshow(imoverlay(BW_inicial, BW_skel, "r"), 'InitialMagnification','fit')

% If the value is fixed:
if opc_ext == "fixed"
    % Define the extension variable of the matrix as a fixed, defined value.
    %disp("Valor extensió fixe")
    val_ext_mat = ext_val;
    
elseif opc_ext == "prop"
    % Define the extension variable of the matrix as a value proportional to the skeletonized object.
    %disp("Valor extensió proporcional")
    val_ext_mat = round(sum(BW_skel(:)) * ext_val/100);
end
    %ext_val


% _Obtain the endpoints_

% x,y
[x_endpoint, y_endpoint] = find(bwmorph(BW_skel, 'endpoints'));
% index
inx_endpoints = find(bwmorph(BW_skel,'endpoints'));

% Values of distance to the endpoints
BW_single_dist = bwdist(~BW_inicial);
%imshow(BW_single_dist, [])
valors_endopints = BW_single_dist(inx_endpoints);

% % Graph of the endpoints
% imshow(imoverlay(BW_inicial, BW_skel, "r" ))
% hold on;
% plot(y_endpoint, x_endpoint, 'b.','markersize',14)
% hold off

% _Obtain perimeter image_
[BW_perimeter] = perimet_BW(BW_inicial);

% Final skeletonized binary image:
BW_skel_final_estes = BW_skel;

% _For every endpoint_
for n_endpoint = 1:length(x_endpoint)
    
    % If the endpoint is touching the perimeter
    if BW_perimeter(x_endpoint(n_endpoint), y_endpoint(n_endpoint))
        % % Graph
        %imshow(BW_perimeter); hold on
        %plot(y_endpoint(1), x_endpoint(1), 'b.','markersize',14); hold off
        %BW_perimeter(x_endpoint(1), y_endpoint(1))
        %imshow(BW_skel); hold on
        %plot(y_endpoint(1), x_endpoint(1), 'b.','markersize',14); hold off
        %BW_skel(x_endpoint(1), y_endpoint(1))
        %imshow(imoverlay(BW_perimeter, BW_skel, "r"))
        continue
    end
    
    % _Obtain the matrices_
    
    % Add to this the value to extend (val_ext_mat)
    % Perimeter BW matrix
    [matriu_nova_perimetral, ~, ~, matsort_perimetral, punt_centr_perimetral] = matrix_new(BW_perimeter, round(double(valors_endopints(n_endpoint)))+1 +val_ext_mat, x_endpoint(n_endpoint), y_endpoint(n_endpoint));
    % figure; imshow(matriu_nova_perimetral, 'InitialMagnification','fit')
    
    % The same, with the skeletonized image
    [matriu_nova_skel, ~, ~, ~, ~] = matrix_new(BW_skel, round(double(valors_endopints(n_endpoint)))+1 +val_ext_mat, x_endpoint(n_endpoint), y_endpoint(n_endpoint));
    % figure; imshow(matriu_nova_skel, 'InitialMagnification','fit')
    
    %imshow(imoverlay(matriu_nova_perimetral, matriu_nova_skel, "r"))
    % Possible filter: bwconncomp(matriu_nova_perimetral|matriu_nova_perimetral, 4)
    
    % __Treatment with matrices__
    
    % _Obtain the points_
    [x_perim, y_perim] = find(matriu_nova_perimetral);
    % Do the same with the pixels of the skeletonized image.
    [x_skel, y_skel] = find(matriu_nova_skel);
    
    
    % _Determination of the angles_
    
    % List to save the angles (opcional)
    angles_llista_cell = {};
    
    % Save the standard deviation, to see which one is the smallest.
    std_lower = Inf;
    
    for n_pixel_perim = 1:length(y_perim)
        
        % Save the angles:
        angle_pix_mean_proba = [];
        
%         %Graph
%         matriu_nova_graficar = matriu_nova_skel|matriu_nova_perimetral;
%         figure
%         imshow(matriu_nova_graficar, 'InitialMagnification','fit')
%         hold on
        
        % Look at the skeletonization for every pixel:
        for n_pixel_skel = 1:length(x_skel)
            
            % Obtain the angle
            angle_pix = abs(atand((y_skel(n_pixel_skel) - y_perim(n_pixel_perim))/(x_skel(n_pixel_skel) - x_perim(n_pixel_perim))));
            
            % Add to the average of the angle:
            if isempty(angle_pix_mean_proba)
                angle_pix_mean_proba = angle_pix;
            else
                angle_pix_mean_proba(end+1) = angle_pix;
            end    
            
            % Graph
            %line([y_perim(n_pixel_perim), y_skel(n_pixel_skel)], [x_perim(n_pixel_perim), x_skel(n_pixel_skel)]);
            %text(y_skel(n_pixel_skel), x_skel(n_pixel_skel), string(round(angle_pix, 1)));
            
        end
        %hold off
        
        % Save in
        angles_llista_cell{end+1} = angle_pix_mean_proba; % ÇÇÇ potser no cal
        
        % %Show sd and mean
        %mean(angle_pix_mean_proba)
        %std(angle_pix_mean_proba)
    
        % if the st. deviation is smaller
        if std(angle_pix_mean_proba) < std_lower
            std_lower = std(angle_pix_mean_proba);
            
            % % Save the position (to graph later)
            %punt_minor = n_pixel_perim;
            
            % Save the point where the angle has a smaller sd
            punt_final_menorangl = [x_perim(n_pixel_perim), y_perim(n_pixel_perim)];
            %disp("THE MINIMAL")
        end
    end
    
    
    % __Graph the region__
        
%     % Graph at the same time
%     matriu_nova_graficar = matriu_nova_skel|matriu_nova_perimetral;
%     figure; imshow(matriu_nova_graficar, 'InitialMagnification','fit'); hold on
%     % Look at every pixel of the skeletonization:
%     for n_pixel_skel = 1:length(x_skel)
%         % Obtain the angle
%         angle_pix = abs(atand((y_skel(n_pixel_skel) - y_perim(punt_minor))/(x_skel(n_pixel_skel) - x_perim(punt_minor))));        
%         % Add to the average of the angle
%         if isempty(angle_pix_mean_proba); angle_pix_mean_proba = angle_pix;
%         else; angle_pix_mean_proba(end+1) = angle_pix; end            
%         % Graph
%         line([y_perim(punt_minor), y_skel(n_pixel_skel)], [x_perim(punt_minor), x_skel(n_pixel_skel)]);
%         text(y_skel(n_pixel_skel), x_skel(n_pixel_skel), string(round(angle_pix, 1)));
%     end; hold off
    
    
    
    % _Obtain in the image_
    % Make a zero image
    matriu_punts_fin = false(size(matriu_nova_perimetral));
    
    % Apply the points:
    matriu_punts_fin(punt_final_menorangl(1), punt_final_menorangl(2)) = true;
    matriu_punts_fin(punt_centr_perimetral(1), punt_centr_perimetral(2)) = true;
    
%     figure; imshow(matriu_punts_fin, 'InitialMagnification','fit')
    
    % From the two points, make a line
    matriu_punts_linia = bwconvhull(matriu_punts_fin);
%     figure; imshow(matriu_punts_linia, 'InitialMagnification','fit')
    
    % We could graph to the main
%     matriu_nova_graficar_fin = matriu_nova_graficar;
    
%     matriu_nova_graficar_fin = matriu_nova_graficar_fin|matriu_punts_linia;
%     figure; imshow(matriu_nova_graficar_fin, 'InitialMagnification','fit')
    
%     figure; imshow(imoverlay(matriu_nova_graficar_fin, matriu_punts_linia, "r"), 'InitialMagnification','fit')

    %now pass it to the main

    % Scale to the original image:
    % We have the points, which we will save as positions, and not as an image, 
    % in order to optimize the image. But how do we go from the small matrix (image), to the large one.
%     figure; imshow(matriu_punts_linia, 'InitialMagnification','fit')
    
    % Find the points
    [y_linia, x_linia] = find(matriu_punts_linia);

    % When we had the image, we had saved its coordinates when it was obtained:
%     matsort_perimetral
    
    % This meant that if we did a BW(x1:x2, y1:y2) with these regions, we get the image.
    % Let's say they are x1, x2, y1, y2:
    % If we added the lines:
%     BW_perimeter_proba = BW_perimeter;
%     figure; imshow(BW_perimeter_proba)
    
    % Define the points x and y
    x_linia_escalatBW = x_linia + matsort_perimetral(3)-1;
    y_linia_escalatBW = y_linia + matsort_perimetral(1)-1;
    
    % Graph BW_skel with the region, obtaining BW_skel_final_estes.
    ind_linia_escalatBW = sub2ind(size(BW_skel_final_estes), y_linia_escalatBW, x_linia_escalatBW);    
    BW_skel_final_estes(ind_linia_escalatBW) = true;
    
%     figure; imshow(BW_skel_final_estes)
    

end
% figure; imshow(imoverlay(BW_skel|BW_perimeter, (BW_skel_final_estes - BW_skel)>0, "r"))    


% figure; imshow(imoverlay(BW_inicial, BW_skel_final_estes, "r"))


end