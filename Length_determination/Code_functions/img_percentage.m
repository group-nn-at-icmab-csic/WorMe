function [valor_percentual_imatge] = img_percentage(img_inicial, valor_percentual)

% Donada una imatge, i donat un valor de percentatge, es retorna el valor
% proporcional a aquest percentatge respecte les mesures de la imatge. 
%
% Per exemple, si la imatge fa 1080 x 1920, la superfície total és de 
% 1080px · 1920px = 2073600 px^2. Si s'obté l'arrel cuadrada del mateix, es
% retorna un genèric de la superfície de la imatge; en el nostre cas:
% (2073600)^(1/2) = 1440 px. Llavors, si es vol el 3% d'aquest serà 43,2.
%
%
% Exemple funció:
% [valor_percentual_imatge] = img_percentage(BW_ini_regio, 5);
%
% Variables
% img_inicial : imatge inicial
%
% See also:
% bwareaopen_percentage

[h_alt, x_llarg, ~] = size(img_inicial);
total_size_img = sqrt(prod([h_alt, x_llarg]));
valor_percentual_imatge = (valor_percentual/100) .* total_size_img;

end