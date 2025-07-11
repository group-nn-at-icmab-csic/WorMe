function [sum_punts] = distance_many_points(punts_xy_nou)

% Given different points in an image, the distance in pixels
% of these is returned.
%
%
%
%
% See also:
% worm_length_manual
% draw_line_length


% START FUNCTION


% _Obtain points_
sum_punts = 0;
for cada_punt = 1:height(punts_xy_nou) -1

    % Operation
    puntdist = [punts_xy_nou(cada_punt, :); punts_xy_nou(cada_punt +1, :)];
    d_punts = pdist(puntdist,'euclidean');
    sum_punts = sum_punts + d_punts;



%     % __Graph__
% 
%     % Graph check
%     punt1 = punts_xy_nou(cada_punt, :);
%     punt2 = punts_xy_nou(cada_punt+1, :);    
% 
%     disp(strcat("Posicio ", string(cada_punt)))
%     disp(strcat("punt 1:", string(punt1(1)), ",", string(punt1(2)), " to ", string(punt2(1)), ",", string(punt2(2)), " Distance: ", string(round(d_punts)) ))
% 
% 
%     figure
%     imshow(imoverlay(BW_ini_regio_cropped, zeros_imatge_cotxe_nou, "r" ))
%     hold on;
% 
%     % Points
%     y_endpoint = [punt1(1) punt2(1)]';    
%     x_endpoint = [punt1(2) punt2(2)]';
% 
%     % Line
%     line(y_endpoint, x_endpoint)
% 
%     % Point
%     plot(y_endpoint, x_endpoint, 'b.','markersize',6)
%     hold off
    

end




% END FUNCTION


end