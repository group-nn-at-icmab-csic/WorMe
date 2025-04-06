function [total_indx_fin] = eixamplar_indx_BB(total_indx, val_exampl, size_BW)

% Donada una llista de index d'un Bounding Box, es retorna els index del
% mateix Bounding Box examplat horitzontal i verticalment.
%
% Variables:
% val_exampl - Valor a eixamplar. Si és 1, s'eixamplarà 1 pixel.
% total_indx - index totals, en una sola columna.
% size_BW - size de la imatge, ha de ser 2D.
%
% total_indx_fin - index totals finals
%
% Temps de processament: 0.0017 (50 loops, 8Gb RAM)
%
%
% Exemple:
% tic; total_indx_fin = eixamplar_indx_BB(total_indx', 1, size(BW_final)); toc
% [RGB_to_color_new] = pintar_indx_to_RGB(imageArray, total_indx_fin, "red"); %Elapsed time is 0.003674 seconds.
% imshow(RGB_to_color_new)
%
% See also
% pintar_indx_to_RGB
% pintar_BW_color
% BBxy_to_BBindx
% BW_to_BBindx
% correccio_sortida_dimensios


% A x,y
[x_values, y_values] = ind2sub(size_BW, total_indx);

% Ara anem a sumar 1, i restar 1 a cada valor de X i Y, i els guardarem tots, de manera que tindrem més
% aixamplat els Bounding Box.
% Molts elements es veuràn repetits, perquè es superposaràn en la mateixa
% posició.

% Mirem que no es sobresurtin de la imatge. Si es així, treurem els valors
% que sobresurtin.

% size_BW(1) %1080 (Y)
% size_BW(2) % 1920 (X)


% unique( (x_values + val_exampl) > size_BW(2) )
% unique( (y_values + val_exampl) > size_BW(1) )
% unique( (x_values - val_exampl) < 0 )
% unique( (y_values - val_exampl) < 0 )

% x_values_fin = [x_values; x_values - val_exampl; x_values + val_exampl; x_values    ; x_values    ];
% y_values_fin = [y_values; y_values;     y_values;     y_values - val_exampl; y_values + val_exampl];
% 
% Per a cada valor s'eixampla, sinó simplement es creen línies:
x_values_fin = [];
y_values_fin = [];

for val_exampl_temp = 1:val_exampl
    x_values_fin = [x_values_fin; x_values; x_values - val_exampl_temp; x_values + val_exampl_temp; x_values    ; x_values    ];
    y_values_fin = [y_values_fin; y_values; y_values;     y_values;     y_values - val_exampl_temp; y_values + val_exampl_temp];
end


% Si algún valor és superat de la dimensió de la imatge, o bé és menor
% d'aquesta, es treu:
indxlog_xy_values_fin = (x_values_fin > size_BW(1) ) | ( x_values_fin <= 0 ) | ( y_values_fin > size_BW(2) ) | ( y_values_fin <= 0);

y_values_fin = y_values_fin(~indxlog_xy_values_fin);
x_values_fin = x_values_fin(~indxlog_xy_values_fin);



% Tornem a passar a índex:
total_indx_fin_t = sub2ind(size_BW, x_values_fin, y_values_fin);

total_indx_fin = unique(total_indx_fin_t);

% % Comprovació
% unique(ismember(total_indx_fin_t, total_indx_fin))
% ismember("A", ["D" "A"])

end