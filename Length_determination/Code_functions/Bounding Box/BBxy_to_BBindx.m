function [index_punts] = BBxy_to_BBindx(BB_punts, BW_size)

% Given a point (x,y) from a bounding box, return the indexed values 
% of each of the connected regions that form a square.
% This is made to graph the bounding box on the image.
%
% Processing time:
% Elapsed time is 0.000764 seconds.
%
% Example
%     BB = regionprops(BW_final,'BoundingBox');
%     BB.BoundingBox
%     [index_punts] = BBxy_to_BBindx(BB.BoundingBox, size(BW_final))
%
%
% See also:
% paint_indx_to_RGB


% START FUNCTION

% _Correcting measurements if they are out of the image_
[BB_punts] = dimension_output_correction(BB_punts, BW_size); %ex: 1080        1920

x_punt = ceil(BB_punts(1)); y_punt = ceil(BB_punts(2)); w_punt = ceil(BB_punts(3)); h_punt = ceil(BB_punts(4));


% Apply correction if it goes over the image dimensions.
if x_punt + w_punt > BW_size(2)
    %disp("Correction BBxy_to_BBindx 1")
%     x_punt
%     w_punt
%     BW_size
    w_punt = w_punt - 1;
end
if y_punt + h_punt > BW_size(1)
    %disp("Correction BBxy_to_BBindx 2")
%     y_punt
%     h_punt
%     BW_size(1)
    h_punt = h_punt - 1;
end

% In summary:
punts_totals = [x_punt y_punt;
[x_punt + (0:w_punt); repelem(y_punt, w_punt+1)]';
[x_punt + (0:w_punt); repelem(y_punt + h_punt, w_punt+1)]';
[repelem(x_punt, h_punt+1); y_punt + (0:h_punt)]';
[repelem(x_punt + w_punt, h_punt+1); y_punt + (0:h_punt)]'];
% Elapsed time is 0.000937 seconds.

index_punts = sub2ind(BW_size, punts_totals(:,2), punts_totals(:,1));
% We obtain the points

% END FUNCTION

end