function [sum_punts] = ditancia_varis_punts(punts_xy_nou)

% Donats diferents punts d'una imatge, es retorna la distància en pixels
% d'aquests.
%
%
%
%
% See also:
% llargada_josep_Fiji
% draw_line_length


% INICI FUNCIO


% _Obtencio dels punts_
sum_punts = 0;
for cada_punt = 1:height(punts_xy_nou) -1

    % Operació
    puntdist = [punts_xy_nou(cada_punt, :); punts_xy_nou(cada_punt +1, :)];
    d_punts = pdist(puntdist,'euclidean');
    sum_punts = sum_punts + d_punts;



%     % __Graficació__
% 
%     % Graficació comprovació
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
%     % Punts
%     y_endpoint = [punt1(1) punt2(1)]';    
%     x_endpoint = [punt1(2) punt2(2)]';
% 
%     % Line
%     line(y_endpoint, x_endpoint)
% 
%     % Punt
%     plot(y_endpoint, x_endpoint, 'b.','markersize',6)
%     hold off
    

end




% FINAL FUNCIO


end