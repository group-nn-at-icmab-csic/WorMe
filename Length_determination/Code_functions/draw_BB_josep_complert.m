function [index_punts, BW_img_new, mask_BB] = draw_BB_josep_complert(BW_img)

% Donada una imatge binària, retorna els índexs del punts del bounding box
% d'aquesta i la imatge amb el Bounding box. D'aquesta manera es pot graficar la imatge.
%
% ES UNA FORMA NO- OPTIMITZADA: forma optimitzada es BW_to_BBindx (%Elapsed time is 0.005428 seconds.)
%
% Per a graficar els punts en la imatge binària:
% BW_img_new(index_punts) = true;
% imshow(BW_img_new)
%
% Temps de processament
% tic; [index_punts] = draw_BB_josep(BW_img); toc
% >>> Elapsed time is 0.007276 seconds.
%
%
% See also
% draw_BB_josep_puntsBB
% draw_BB_josep

BW_img_size = size(BW_img);
BB_punts = regionprops(BW_img, 'BoundingBox');
BB_punts = BB_punts.BoundingBox;
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

% Per graficar en la imatge inicial
BW_img_new = BW_img;
BW_img_new(index_punts) = true;

% Print de la imatge amb sols el bounding box
mask_BB = false(size(BW_img));
mask_BB(index_punts) = true;


%imshow(BW_img_new)

end