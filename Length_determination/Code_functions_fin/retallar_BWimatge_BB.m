function [BW_ini_regio_cropped, proporcio_img] = retallar_BWimatge_BB(BW_ini_regio, percentatge_img_origin)

% Given a binary image with just an object, bounding box is generated and
% is obtained the main cropped region, and their data (proportions,
% coordinates).
% This function is very useful for optimize process.
%
% Like retallar_BWimatge_BB_2
%
% Donada una imatge on sols hi ha un objecte binari, es fa un bounding box
% d'aquesta i s'obté la imatge original d'aquesta. 
% OPTIMITZABLE si es treuen els retorns de les imatges.
%
% Variables 
%
% BW_ini_regio : imatge binaria amb sols l'objecte binari
%
% percentatge_img_origin :  percentatge en que s'agrandarà el bounding box
%                           de l'objecte binari. Necessari que sigui major si es volen obtenir
%                           regións externes al bounding box inicial (ex: no es selecciona la cua).
%                           ex: 5
% 
% Output
% BW_ini_regio_cropped : imatge binària retallada
%
%
% Funcions relacionades
% extendre_img_regions : per a juntar la imatge retallada, amb les
% proporcions determinades, una vegada obtinguda.
%
%
% 
% 
%
%
% See also
% retallar_BWRGBimatge_BB
% extendre_img_regions
% retallar_BWRGBimatge_BB_nou

% START FUNCTION

[x_size, y_size] = size(BW_ini_regio); %ex: 1080        1920

prop_regions_BW = regionprops(BW_ini_regio,'BoundingBox');  %<--- rellevant
[valor_percentual_imatge] = percentatge_imatge(BW_ini_regio, percentatge_img_origin);

proporcio_img = round(prop_regions_BW.BoundingBox + valor_percentual_imatge .* [-1 -1 2 2]);

% Proporcio antiga inicial (Comprovació retallar BB)
% [BW_ini_regio_cropped] = imcrop(BW_ini_regio, proporcio_img);        %Es retalla la imatge basant-se amb el BoundingBox.
%imshow(BW_ini_regio_cropped)
%size(BW_ini_regio_cropped)

% SI hi ha número negatius.
if ismember(1, proporcio_img < 0)
    % Es cambia el valor per 0, i es suma a la amplada/llargada d'aquest.
    % En X:
    if proporcio_img(1)<0
    valor_x = proporcio_img(1);
    proporcio_img(3) = proporcio_img(3) + valor_x +1;
    proporcio_img(1) = 1; % Ha de ser 1, i no 0, perque estem parlant de posixions X,Y
    end
    % En Y:
    if proporcio_img(2)<0
        valor_x = proporcio_img(2);
        proporcio_img(4) = proporcio_img(4) + valor_x +1;
        proporcio_img(2) = 1;
    end
end


% Si el tamany de la imatge retallada és superior a les mesures de la imatge inicial:
% En Y
if proporcio_img(2) + proporcio_img(4) > x_size
    diferencia_x = x_size - (proporcio_img(2) + proporcio_img(4) );
    proporcio_img(4) = proporcio_img(4) + diferencia_x;
end

% En X
if proporcio_img(1) + proporcio_img(3) > y_size
    diferencia_y = y_size - (proporcio_img(1) + proporcio_img(3) );
    proporcio_img(3) = proporcio_img(3) + diferencia_y;
end


[BW_ini_regio_cropped] = imcrop(BW_ini_regio, proporcio_img);        %Es retalla la imatge basant-se amb el BoundingBox.
% imshow(BW_ini_regio_cropped)
% size(BW_ini_regio_cropped)


% END FUNCTION

end