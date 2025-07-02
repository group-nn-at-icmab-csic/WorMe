function [tipus_imatge] = tipus_rgbgraybw_image(imatge_input)

% Given an image (rgb, gray or BW), the image type is returned which is ('image_type'), in the form of the string "rgb", "gray", or "binary".
%
% (CAT)
% Donada una imatge (rgb, gray o BW), es retorna el tipus d'imatge que és('tipus_imatge'), en forma de string "rgb", "gray", o "binary".

% START FUNCTION

[~, ~, dim_im] = size(imatge_input); % Dimensions

if dim_im == 3
    % la imatge és RGB. No cal modificar res.
    tipus_imatge = "rgb";
elseif dim_im ~= 1
    error("Error en f'graficar_rgbgraybw_image', les dimensions no són ni 3 ni 1", "")
else
    % Les dimensions seràn 1.
    % La imatge és o en escala de grisos o binària.
    
    if ~islogical(imatge_input)
        % Si la imatge és en grisos
        % Convertida a 3D
        tipus_imatge = "gray";
    else
        % Sino, la imatge és binària
        % Convertida a 3D
        tipus_imatge = "binary";

    end
end

% FI FUNCIÓ


end