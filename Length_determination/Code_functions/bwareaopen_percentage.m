function [imatge_sortida_bwareaopen, valor_p_bwareaopen] = bwareaopen_percentage(imatge_filtrar_bwarea, valor_percentual)

% Obtain the numerical value of the percentage of the surface of an image, with the intention of applying it to the bwareaopen() function.

% START FUNCTION

% Determine small pixels
% Since the bwareaopen() function is based on the maximum number of pixels in
% the objects, we understand that the number of pixels can be proportional to the
% surface of the image.
% That is, if we determine 500 pixels in the bwareaopen() function, it means
% that those objects whose sum is 500 are eliminated.
% This means that, for example, if we define a value of 2300,
% a square that is ~47 x 47 would be eliminated, since sqrt(2800) is 47.
% If we compare this value with that of the initial image, we can determine
% a percentage

% We obtain the surface
[imatge_filtrar_bwarea_rows, imatge_filtrar_bwarea_cols, ~ ] = size(imatge_filtrar_bwarea);
imatge_filtrar_bwarea_superficie = imatge_filtrar_bwarea_rows .* imatge_filtrar_bwarea_cols;

% Square of the surface
sqrt_imatge_filtrar_bwarea_superficie = sqrt(imatge_filtrar_bwarea_superficie);

valor_p_bwareaopen = round(((valor_percentual/100) .* sqrt_imatge_filtrar_bwarea_superficie)^2);
% Nota: if the valor_percentual is 100, meaning 100%, the 
% valor_p_bwareaopen would be the same than the one of the surface of the image.

imatge_sortida_bwareaopen = bwareaopen(imatge_filtrar_bwarea, valor_p_bwareaopen);
%imshow(imatge_sortida_bwareaopen)

% % % Theoretical explanation of mathematical formulas
% % 
% % % Let’s suppose bwareaopen(BW, 800)
% disp(sqrt(800))
% disp(sqrt_BW_bwa_superficie)
% (sqrt(800)/sqrt_BW_bwa_superficie).*100
% % 
% % 
% % 
% % % Let’s suppose bwareaopen(BW, 2300)
% sqrt(2300)
% valor_percentual = (sqrt(2300)/sqrt_BW_bwa_superficie) .*100
% % This value is the percentage between the surface we want to define (2300) 
% % and that of the image.
% % If we directly compare the surfaces, we must apply the square root 
% % to them, since the scale is not the same:
% sqrt(2300 / BW_bwa_superficie) .* 100
% % 
% % % Conversely, defining the total surface, which is the value relevant for
% % % the variable bwareaopen()
% ((valor_percentual/100) .* sqrt_BW_bwa_superficie)^2
% % 
% % % If we obtained a result between an image and half of it:
% ((sqrt_BW_bwa_superficie/2)/sqrt_BW_bwa_superficie) .*100
 

% FINAL OF THE FUNCTION

end
