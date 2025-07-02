function [imatge_amb_text] = ficar_text_imatge(imatge_ficar_text, text_introduir, dades_introduir, escala_opci)

% Puts text on an image. Different parameters such as automating the text size
% to the image size, scaling the image, etc.
%
% input:
%   imatge_ficar_text : image on which text is to be placed
%   text_introduir    : text to insert
%   dades_introduir   : complementary text to insert, can be numeric
%   escala_opci       : scaling option
%
% output:   imatge_amb_text
%
% Parameters:
%               escala_opci
%                               "auto"
%                                       Rescales the letter size
%                                       to fit the image.
%
%                               "rescale"
%                                       Rescales the image size
%                                       to fit the letters.
%
%                               numeric value (e.g., 1.4)
%                                        Determines a numeric value, the scale,
%                                        to scale the letters on the image.
%
% Note: the parameter most likely to work correctly is
% "rescale", since in small images the letter scale makes them
% unreadable, while if the small image is scaled up, there is
% enough resolution to read.
%
% Note 2: this function depends on the function *text2im*
%
% See also
% text2im

% START OF CODE


% Initial data comprovation
if ~exist('dades_introduir','var')
    dades_introduir = "";
end

if isnumeric(text_introduir)
    text_introduir = string(text_introduir);
end


% Definition of program execution typology -according to- image class and dimension
% 'tipus_imatge'
if islogical(imatge_ficar_text)
    % We supose the dimension will be 1
    tipus_imatge = "logical";
    %disp("TIPUS IMATGE: LOGICAL");
    class(imatge_ficar_text);
    
    
    % If we want image from logic to uint8:
%         image_1 = cast(image_1, "uint8");
%         image_1 = cat(3, image_1, image_1, image_1);
end


if isa(imatge_ficar_text,'integer')
    % Supose the image dimension is 3
    tipus_imatge = "uint8";
    %disp("TIPUS IMATGE: INTEGER ");
    class(imatge_ficar_text);
end

% imatge measure ('dimensio_imatge')
[~, ~, dimensio_imatge] = size(imatge_ficar_text);

%% Add image with data

% Convert with the variables:
text_hola = strcat(text_introduir, string(dades_introduir));
HOLA = text2im(text_hola);  %  funció - - > text2im.m <- - modificada. ref:[https://es.mathworks.com/matlabcentral/fileexchange/19896-convert-text-to-an-image?s_tid=srchtitle]
[~, size_Hola_cols, ~] = size(HOLA);
HOLA = cat(1,HOLA, ones(8, size_Hola_cols) );
HOLA = cat(1,ones(8, size_Hola_cols), HOLA );

% Obtain the length of the columns
[size_Hola_rows, ~, ~] = size(HOLA);
HOLA = cat(2,ones(size_Hola_rows, 8), HOLA );
HOLA = cat(2,HOLA, ones(size_Hola_rows, 8));
%imshow(HOLA);


% Position where we want the sqare
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
        % The size of the letters is rescaled to fit the image
        % This scale is based on the distance between the
        % starting point of the letters (the point at 10% of the vertical
        % distance of the image), resizing by a height of 40%
        % of this distance.
            [row_HOLA, ~, ~] = size(HOLA);
            resize_value = (column_punt_xy .* 0.40) / row_HOLA;
            
            HOLA = imresize(double(HOLA), resize_value);
            HOLA = imbinarize(HOLA);
            %imshow(HOLA);
            size(HOLA);
        elseif escala_opci == "rescale"
            % The image is resized to fit the letters
            
            % This scale is based on the initial measurement of the vertical distance, the height,
            % of the letters, so that the height of the image
            % is equal to the measurement of 20 times the height of the image
            % of the letters.
            
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
            % We redefine the position of the image with text in the main image
            %, since we have modified the measurements of one or the other.
            % Position where we want the box:
            [colum_sf, raw_sf, ~] = size(imatge_ficar_text);
            column_punt_xy = round(colum_sf * 0.1);
            raw_punt_xy = round(raw_sf * 0.9);
    
        end
    end
end


[rows_hola, colums_hola, ~] = size(HOLA);

% Change image letters, according to image typology
if dimensio_imatge == 3
    HOLA_rgbImage = cat(3, HOLA .* 255, HOLA .* 255, HOLA .* 255);
else
    if tipus_imatge == "uint8"
        HOLA_rgbImage = HOLA .* 255;
    else
        HOLA_rgbImage = HOLA;
    end
end


%We change the format to 3 dimensions, and multiply by 255 to make it
%black and white of rgb:

%imshow(rgbImage)

% We join the images
%We define the part of the image equal to the part of our image.
%Note that a matrix of 3 is being equalized, and not just a matrix
%alone. From there, we go backwards, that is, towards the abscissa axis.
% Positioning to: bottom left
% imatge_ficar_text(colum_sf-colums_hola+1:colum_sf, raw_sf-raws_hola:raw_sf-1,:) = HOLA_rgbImage;
% imshow(imagge_ficar_text)

% Positioning to: desired position
imatge_ficar_text(column_punt_xy-rows_hola+1:column_punt_xy, raw_punt_xy-colums_hola:raw_punt_xy-1,:) = HOLA_rgbImage;
imatge_amb_text = imatge_ficar_text;
%imshow(imatge_amb_text);


%%% FINAL OF THE CODE



end









