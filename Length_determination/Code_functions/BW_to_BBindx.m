function [cell_indx_punts] = BW_to_BBindx(BW_final)

% Given a binary image, return a cell with the indices of each
% point of its bounding box.
%
%
% Processment time: 0.0089 (8GbRAM)
% Codi: tictoc = []; for nm = 1:50; tic; [cell_indx_punts] = BW_to_BBindx(BW_final); tictoc = [tictoc, toc];end; mean(tictoc)
%
% See also
% pintar_indx_to_RGB
% pintar_BW_color
% BBxy_to_BBindx

BB_struc = regionprops(BW_final,'BoundingBox');
cell_indx_punts = {};
for n_struc = 1:length(BB_struc)
    BB_punts = BB_struc(n_struc).BoundingBox;
    
    x_punt = floor(BB_punts(1)); y_punt = floor(BB_punts(2)); w_punt = BB_punts(3); h_punt = BB_punts(4);
    
    % En resumit:
    punts_totals = [x_punt y_punt;
    [x_punt + (0:w_punt); repelem(y_punt, w_punt+1)]';
    [x_punt + (0:w_punt); repelem(y_punt + h_punt, w_punt+1)]';
    [repelem(x_punt, h_punt+1); y_punt + (0:h_punt)]';
    [repelem(x_punt + w_punt, h_punt+1); y_punt + (0:h_punt)]'];
    % Elapsed time is 0.000937 seconds.
    

    % Possible corrections for under/over image dimensions:
    punts_totals_1 = punts_totals(:, 1);
    punts_totals_1(punts_totals(:, 1) == 0) = 1;
    punts_totals(:, 1) = punts_totals_1;

    punts_totals_2 = punts_totals(:, 2);
    punts_totals_2(punts_totals(:, 2) == 0) = 1;
    punts_totals(:, 2) = punts_totals_2;    

    index_punts = sub2ind(size(BW_final), punts_totals(:,2), punts_totals(:,1));
    % We obtain the points

    cell_indx_punts{end+1} = index_punts;
end


% % Exemple
% BW_final_BB = BW_final;
% BW_final_BB(cell_indx_punts{1}) = true;
% imshow(BW_final_BB)



end