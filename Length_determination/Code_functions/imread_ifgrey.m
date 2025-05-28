function [imatge_original] = imread_ifgrey(ruta_imatge_original)

% Lectura la imatge: transforma a rgb si és en escala de grisos.

imatge_original = imread(ruta_imatge_original);

% Si la imatge és en blanc i negre es converteix a rgb
if numel(size(imatge_original)) == 2
    % Convertim imatge blanc i negre a RGB (no varia)
    imatge_original = cat(3, imatge_original, imatge_original, imatge_original);

else
    
end



end