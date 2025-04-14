function [index_punts] = BBxy_to_BBindx(BB_punts, BW_size)

% Given an x,y bounding box point, the indexed values of each of the connected regions that form a square of it are returned.
% This is made for graph permanently the bounding box in the image.
%
% (CAT)
% Donat un punt x,y de bounding box, es retorna els valors indexats de cadascun de les regions conectades que formen un quadrat d'aquest.
%
% Processment time:
% Elapsed time is 0.000764 seconds.
%
% Example
%     BB = regionprops(BW_final,'BoundingBox');
%     BB.BoundingBox
%     [index_punts] = BBxy_to_BBindx(BB.BoundingBox, size(BW_final))
%
%
% See also
% pintar_indx_to_RGB
% pintar_BW_color
% BW_to_BBindx


% INICI FUNCIÓ

% _Correcció possible sortida de les mesures_
[BB_punts] = correccio_sortida_dimensios(BB_punts, BW_size); %ex: 1080        1920

% MODIF JOSEP UPGRADE 12/01/2023: x_punt = ceil(BB_punts(1)); y_punt = ceil(BB_punts(2)); w_punt = BB_punts(3); h_punt = BB_punts(4);
x_punt = ceil(BB_punts(1)); y_punt = ceil(BB_punts(2)); w_punt = ceil(BB_punts(3)); h_punt = ceil(BB_punts(4));


% Apliquem correcció si es passa de les dimensións de la imatge.
if x_punt + w_punt > BW_size(2)
    %disp("Correccio BBxy_to_BBindx 1")
%     x_punt
%     w_punt
%     BW_size
    w_punt = w_punt - 1;
end
if y_punt + h_punt > BW_size(1)
    %disp("Correccio BBxy_to_BBindx 2")
%     y_punt
%     h_punt
%     BW_size(1)
    h_punt = h_punt - 1;
end

% En resumit:
punts_totals = [x_punt y_punt;
[x_punt + (0:w_punt); repelem(y_punt, w_punt+1)]';
[x_punt + (0:w_punt); repelem(y_punt + h_punt, w_punt+1)]';
[repelem(x_punt, h_punt+1); y_punt + (0:h_punt)]';
[repelem(x_punt + w_punt, h_punt+1); y_punt + (0:h_punt)]'];
% Elapsed time is 0.000937 seconds.

index_punts = sub2ind(BW_size, punts_totals(:,2), punts_totals(:,1));
% Obtenim els punts

% FINAL FUNCIÓ

end