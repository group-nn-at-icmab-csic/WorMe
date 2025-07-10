function [valor_percentual_imatge] = img_percentage(img_inicial, valor_percentual)

% Given an image, and given a percentage value, the value
% proportional to this percentage with respect to the image measurements is returned.
%
% For example, if the image is 1080 x 1920, the total area is
% 1080px · 1920px = 2073600 px^2. If the square root of the same is obtained, 
% a generic of the image area is returned; in our case:
% (2073600)^(1/2) = 1440 px. So, if you want 3% of this it will be 43.2.
%
%
% Example function:
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