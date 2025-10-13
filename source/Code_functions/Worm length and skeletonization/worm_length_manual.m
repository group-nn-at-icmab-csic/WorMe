function [Area_final] = worm_length_manual(BW_skel, cada_nx)

% Given a skeletonized image, return its length,
% applying the data correction for manual error.
%
% The manual error occurs between the distance between each pixel, and
% the distance between each X pixels, which occurs when the
% measurement is taken manually (not every pixel is taken, 
% but in total there are perhaps 10 points).


% START FUNCTION

% We get the sorted indices
[~, indx_orders] = width_bwskeldist_values(BW_skel, BW_skel);

% We obtain the distance in the way we proposed:
[x_r, y_c] = ind2sub(size(BW_skel), indx_orders);

punts_xy = [x_r, y_c];

% Correction every 10 pixels:
% We take the points every 35 pixels
pos_punts = 1:cada_nx:length(punts_xy);
% Let's add the end:
pos_punts = [pos_punts, length(punts_xy)];

if length(punts_xy(:,1)) > 1
    punts_xy_nou = punts_xy(pos_punts,:);
    
    % hold on;
    % plot(punts_xy_nou(:, 2), punts_xy_nou(:, 1), 'b.','markersize',6)
    % hold off
    
    % _Obtaining points_
    sum_punts = 0;
    for cada_punt = 1:height(punts_xy_nou) -1
        puntdist = [punts_xy_nou(cada_punt, :); punts_xy_nou(cada_punt +1, :)];
        d_punts = pdist(puntdist,'euclidean');
        sum_punts = sum_punts + d_punts;
    end
    
    Area_final = sum_punts;
else
    Area_final = 1;
end

% END FUNCTION

end