function [imatge_amb_text] = ficar_text_imatge(imatge_ficar_text, text_introduir, dades_introduir, escala_opci)

% Fica el text en una imatge. Diferents paràmetres com automatitzar el text a la grandaria de la imatge, escalar imatge, etc. 
%
% input:    
%   imatge_ficar_text : imatge a la que es vol ficar text
%   text_introduir    : text a introduïr
%   dades_introduir   : text complementari a introduïr, pot ser numèric
%   escala_opci : opció d'escalat
% 
% output:   imatge_amb_text
%
% Paràmetres:
%               escala_opci
%                               "auto"
%                                       Es rescala el tamany de les lletres
%                                       per a adaptar a la imatge.
%
%                               "rescale"
%                                       Es rescala el tamany de la imatge
%                                       per a adaptar a les lletres.
% 
%                               valor numèric (ex: 1.4)
%                                        Determina valor numèric, la escala, en que
%                                        s'escalaràn les lletres de la imatge.
%
% Nota: el paràmetre més probable que funcioni correctament serà el
% "rescale", donat que en imatges petites la escala de les lletres les fa
% il·legibles, mentre que si s'escala la imatge petita a gran, hi ha
% resolució suficient com per a llegir.
%
% Nota 2: aquesta funció depèn de la funció *text2im*
%
% See also
% text2im

% INICI CODI

% Comprovacio dades inicials
if ~exist('dades_introduir','var')
    dades_introduir = "";
end

if isnumeric(text_introduir)
    text_introduir = string(text_introduir);
end


%% Definicio tipologia execucio programa -segons- classe imatge i dimensió
% 'tipus_imatge'
if islogical(imatge_ficar_text)
    % Suposem que la dimensió serà de 1
    tipus_imatge = "logical";
    %disp("TIPUS IMATGE: LOGICAL");
    class(imatge_ficar_text);
    
    
    % Si es volgués passar la imatge de logica a uint8:
%         image_1 = cast(image_1, "uint8");
%         image_1 = cat(3, image_1, image_1, image_1);
end


if isa(imatge_ficar_text,'integer')
    % Suposem que la dimensió serà de 3
    tipus_imatge = "uint8";
    %disp("TIPUS IMATGE: INTEGER ");
    class(imatge_ficar_text);
end

% Mesura imatge ('dimensio_imatge')
[~, ~, dimensio_imatge] = size(imatge_ficar_text);

%% Addició imatge amb dades

%Convertim amb les variables:
text_hola = strcat(text_introduir, string(dades_introduir));
HOLA = text2im(text_hola);  %  funció - - > text2im.m <- - modificada. ref:[https://es.mathworks.com/matlabcentral/fileexchange/19896-convert-text-to-an-image?s_tid=srchtitle]
[~, size_Hola_cols, ~] = size(HOLA);
HOLA = cat(1,HOLA, ones(8, size_Hola_cols) );
HOLA = cat(1,ones(8, size_Hola_cols), HOLA );

% Obtenim la llargada de les columnes 
[size_Hola_rows, ~, ~] = size(HOLA);
HOLA = cat(2,ones(size_Hola_rows, 8), HOLA );
HOLA = cat(2,HOLA, ones(size_Hola_rows, 8));
%imshow(HOLA);


%posició on voldriem el cuadre
[colum_sf, raw_sf, ~] = size(imatge_ficar_text);
column_punt_xy = round(colum_sf * 0.1);
raw_punt_xy = round(raw_sf * 0.9);



%Resize here

if exist('escala_opci', 'var')
    if islogical(escala_opci)
        HOLA = imresize(double(HOLA), escala_opci);
        HOLA = imbinarize(HOLA);
        %imshow(HOLA);
        size(HOLA);
    elseif isstring(escala_opci)
        if escala_opci == "auto"
            % Es rescala el tamany de les lletres per a adaptar a la imatge
            % Aquesta escala es basa en la distància que hi ha entre el
            % punt inicial de les lletres (el punt del 10% de la distància
            % vertical de la imatge), redimensionant en una alçada del 40%
            % d'aquesta distància.
            [row_HOLA, ~, ~] = size(HOLA);
            resize_value = (column_punt_xy .* 0.40) / row_HOLA;
            
            HOLA = imresize(double(HOLA), resize_value);
            HOLA = imbinarize(HOLA);
            %imshow(HOLA);
            size(HOLA);
        elseif escala_opci == "rescale"
            % Es rescala el tamany de les la imatge per a adaptar a les lletres
            
            % Aquesta escala es basa en la mesura inicial de la distància vertical, l'alçada,
            % de les lletres, de manera que s'iguala l'alçada de la imatge
            % com la mesura de 20 vegades l'alçada de la imatge de les
            % lletres.
            
            [row_HOLA, ~, ~] = size(HOLA);
            [row_imatge, ~] = size(imatge_ficar_text);
            factor_escalat = (row_HOLA .* 20) / row_imatge;
            if tipus_imatge == "uint8"
                imatge_ficar_text = imresize(imatge_ficar_text, factor_escalat);
                size(imatge_ficar_text);
            elseif tipus_imatge == "logical"
                imatge_ficar_text = imresize(imatge_ficar_text, factor_escalat);
                %imatge_ficar_text = imbinarize(imatge_ficar_text);
                size(imatge_ficar_text);
            end
            % Redefinim la posicio de la imatge amb text en la imatge
            % principal, donat que hem modificat mesures d'una u altre.
            % Posició on voldriem el quadre:
            [colum_sf, raw_sf, ~] = size(imatge_ficar_text);
            column_punt_xy = round(colum_sf * 0.1);
            raw_punt_xy = round(raw_sf * 0.9);
    
        end
    end
end


[rows_hola, colums_hola, ~] = size(HOLA);

% Canvi imatge lletres, segons tipologia imatge
if dimensio_imatge == 3
    HOLA_rgbImage = cat(3, HOLA .* 255, HOLA .* 255, HOLA .* 255);
else
    if tipus_imatge == "uint8"
        HOLA_rgbImage = HOLA .* 255;
    else
        HOLA_rgbImage = HOLA;
    end
end



%Canviem el format a 3 dimensions, imultipliquem per 255 per a fer-lo en
%blanc i negre de rgb:

%imshow(rgbImage)

% Juntem les imatges
%Definim la part de la imatge igual a la part de la nostra imatge. 
%Nota que s'està igualant una matriu de 3, i no així sols una matriu
%sola. D'allà, es va cap enrrere, es a dir, cap a l'eix d'abscices.
% Posicionament a: abaix a esquerra
% imatge_ficar_text(colum_sf-colums_hola+1:colum_sf, raw_sf-raws_hola:raw_sf-1,:) = HOLA_rgbImage;
% imshow(imatge_ficar_text)

% Posicionament a: posició desitjada
imatge_ficar_text(column_punt_xy-rows_hola+1:column_punt_xy, raw_punt_xy-colums_hola:raw_punt_xy-1,:) = HOLA_rgbImage;
imatge_amb_text = imatge_ficar_text;
%imshow(imatge_amb_text);


%%% FINAL CODI



end









