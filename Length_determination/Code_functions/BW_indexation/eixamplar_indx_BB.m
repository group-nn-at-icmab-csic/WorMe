function [total_indx_fin] = eixamplar_indx_BB(total_indx, val_exampl, size_BW)

% Given a list of indices of a Bounding Box, the indices of the
% same Bounding Box sampled horizontally and vertically are returned.
%
% Variables:
% val_exampl - Value to be widened. If it is 1, it will be widened by 1 pixel.
% total_indx - total indices, in a single column.
% size_BW - size of the image, must be 2D.
%
% total_indx_fin - final total indices
%
% Processing time: 0.0017 (50 loops, 8GB RAM)
%
%
% Example:
% tic; total_indx_fin = eixamplar_indx_BB(total_indx', 1, size(BW_final)); toc
% [RGB_to_color_new] = pintar_indx_to_RGB(imageArray, total_indx_fin, "red"); %Elapsed time is 0.003674 seconds.
% imshow(RGB_to_color_new)
%
% See also
% pintar_indx_to_RGB
% BBxy_to_BBindx
% correccio_sortida_dimensios


% A x,y
[x_values, y_values] = ind2sub(size_BW, total_indx);
% Now we are going to add 1, and subtract 1 from each value of X and Y, 
% and we will save them all, so that we will have widened the Bounding Box.
% Many elements will be repeated, because they will overlap in the same
% position.

% We make sure that they do not go out of bounds of the image. 
% If so, we will remove the values.

% size_BW(1) %1080 (Y)
% size_BW(2) % 1920 (X)


% unique( (x_values + val_exampl) > size_BW(2) )
% unique( (y_values + val_exampl) > size_BW(1) )
% unique( (x_values - val_exampl) < 0 )
% unique( (y_values - val_exampl) < 0 )

% x_values_fin = [x_values; x_values - val_exampl; x_values + val_exampl; x_values    ; x_values    ];
% y_values_fin = [y_values; y_values;     y_values;     y_values - val_exampl; y_values + val_exampl];
% 
% For each value it is expanded, otherwise lines are simply created:
x_values_fin = [];
y_values_fin = [];

for val_exampl_temp = 1:val_exampl
    x_values_fin = [x_values_fin; x_values; x_values - val_exampl_temp; x_values + val_exampl_temp; x_values    ; x_values    ];
    y_values_fin = [y_values_fin; y_values; y_values;     y_values;     y_values - val_exampl_temp; y_values + val_exampl_temp];
end


% If any value is exceeded by the image dimension, or is less
% than it, it is removed:
indxlog_xy_values_fin = (x_values_fin > size_BW(1) ) | ( x_values_fin <= 0 ) | ( y_values_fin > size_BW(2) ) | ( y_values_fin <= 0);

y_values_fin = y_values_fin(~indxlog_xy_values_fin);
x_values_fin = x_values_fin(~indxlog_xy_values_fin);



% Let's go back to index:
total_indx_fin_t = sub2ind(size_BW, x_values_fin, y_values_fin);

total_indx_fin = unique(total_indx_fin_t);

% % Check
% unique(ismember(total_indx_fin_t, total_indx_fin))
% ismember("A", ["D" "A"])

end