function [index_punts] = draw_BB_josep_puntsBB(BB_punts, BW_img_size)

% Given the bounding box points of an image, and its size, es
% returns the indices of the points in the image where the bounding box would go.
% It is an optimized form of draw_BB_josep.m, given that the input is not the
% binary image.
%
% To get the points of the Bounding box
% example: 126.5000 536.5000 530.0000 83.0000
%
% BB_points = regionprops(BW_img, 'BoundingBox');
% BB_points = BB_points.BoundingBox;
%
% To get the size of the image:
% BW_img_size = size(BW_img);
%
% Processing time:
% tic; [index_points] = draw_BB_josep_puntsBB(BB_points, BW_img_size); touch
% >>> Elapsed time is 0.002090 seconds.
%
%
% See also
% draw_BB_josep
% draw_BB_josep_complert

x_punt = ceil(BB_punts(1)); y_punt = ceil(BB_punts(2)); w_punt = BB_punts(3); h_punt = BB_punts(4);
punts_totals = [x_punt y_punt];


for cada_w = 0:w_punt
    punts_totals = [punts_totals; x_punt + cada_w, y_punt];

    punts_totals = [punts_totals; x_punt + cada_w, y_punt + h_punt];    
end

for cada_h = 0:h_punt
    punts_totals = [punts_totals; x_punt, y_punt + cada_h];

    punts_totals = [punts_totals; x_punt + w_punt, y_punt + cada_h];
end



index_punts = sub2ind(BW_img_size, punts_totals(:,2), punts_totals(:,1));
% We get the points

% To graph
% BW_img_new = BW_img;
% BW_img_new(index_points) = true;

%imshow(BW_img_new)

end