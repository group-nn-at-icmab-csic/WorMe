function [imatge_3D_sortida] = graficar_rgbgraybw_image(imatge_input)

% Given any kind of image (rgb, gray, BW), returns the 3 dimensional image,
% mainly for their graphication.
% This helps solving problems when graphing non rgb images.
%
% (CAT)
% Donada una imatge (rgb, gray o BW), retorna en aquesta en 3D per a la seva graficació.
%
% Example :
%   class(graficar_rgbgraybw_image(BW_final))
%   size(graficar_rgbgraybw_image(BW_final))
%   max(graficar_rgbgraybw_image(BW_final(:)))
% 
%   imshow(insertText(graficar_rgbgraybw_image(BW_final), [100,200], "Hola", 'FontSize',50))


% INICI FUNCIÓ

[~, ~, dim_im] = size(imatge_input); % Dimensions

if dim_im == 3
    % la imatge és RGB. No cal modificar res.
    imatge_3D_sortida = imatge_input;
elseif dim_im ~= 1
    error("Error en f'graficar_rgbgraybw_image', les dimensions no són ni 3 ni 1", "")
else
    % Les dimensions seràn 1.
    % La imatge és o en escala de grisos o binària.
    
    if ~islogical(imatge_input)
        % Si la imatge és en grisos
        % Convertida a 3D
        imatge_3D_sortida = cat(3, imatge_input, imatge_input, imatge_input);
    else
        % Sino, la imatge és binària
        % Convertida a 3D
        imatge_3D_sortida = cat(3, imatge_input.* 255, imatge_input.* 255, imatge_input .* 255);

    end
end

% FI FUNCIÓ


end