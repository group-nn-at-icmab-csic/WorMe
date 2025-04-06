function [index_punts] = draw_BB_josep_puntsBB(BB_punts, BW_img_size)

% Donats els punts del bounding box d'una imatge, i la size d'aquesta, es
% retorna els indexs dels punts de la imatge on aniria el bounding box.
% Es una forma optimitzada de draw_BB_josep.m, donat que l'entrada no es la
% imatge binaria.
%
% Per a obtenir els punts del Bounding box
%   exemple: 126.5000  536.5000  530.0000   83.0000
%
% BB_punts = regionprops(BW_img, 'BoundingBox');
% BB_punts = BB_punts.BoundingBox;
%
% Per a obtenir el size de la imatge:
% BW_img_size = size(BW_img);
%
% Temps de processament:
% tic; [index_punts] = draw_BB_josep_puntsBB(BB_punts, BW_img_size);toc
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
% Obtenim els punts

% Per graficar
% BW_img_new = BW_img;
% BW_img_new(index_punts) = true;

%imshow(BW_img_new)

end