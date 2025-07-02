%% Adds empty regions to the image proportionally so that it is square in shape.
%% The main goal is to modify the image to obtain video.
%% This function can be used to match different images to an initial one, by comparing the length of the rows and columns of each with the initial one.

function imatge_final = agregar_zeros(imatge_inicial, nombre_de_zeros, percentatge_adicional)

% START FUNCTION

% Adds empty regions to the image proportionally so that it is square in shape.
% The main goal is to modify the image to obtain video.
% This function can be used to match different images to an initial one, by comparing the length of the rows and columns of each with the initial one.


% [imatge_final] = agregar_zeros(imatge_inicial, nombre_de_zeros, percentatge_adicional)

% Input: imatge_inicial, nombre_de_zeros, percentatge_adicional
% Output: imatge_final

% Parameters:
%       nombre_de_zeros: 
%                       "aquesta"  :  this image is expanded
%                       [files, columnes] : rows and columns to add tot the image
%       percentatge_adicional: 
%                           empty : determined as zero

% Start image
image_1 = imatge_inicial;
%     imshow(image_1)

% If the image is binary, we convert it to 3D
if islogical(image_1)
    patro_imatge = "logical";
    disp("TIPUS IMATGE: LOGICAL");

    % If want to change the image logic to uint8:
%         image_1 = cast(image_1, "uint8");
%         image_1 = cat(3, image_1, image_1, image_1);
end

if isa(image_1,'integer')
    patro_imatge = "uint8"
end

%imshow(image_1);

% How many zeros we want to add? X and Y zeros in the axis 

% In our case:
[rows_m, columns_m, ~] = size(image_1);

% Additional percentage to add to the image (additional_percentage)
% If not defined it is defined as zero.
if ~exist('percentatge_adicional','var')
    percentatge_adicional = 0;
end
deu_percent = round(rows_m * percentatge_adicional/100);  % ex: 10%


if ~exist('nombre_de_zeros','var')
    disp("Nombre de files i columnes a agregar no definit")
end



% First image 
if string(nombre_de_zeros) == "aquesta"
    % We see the length of rows:
    if rows_m < columns_m
        rows_agregar = abs(columns_m - rows_m) + deu_percent;
        columns_agregar = 0 + deu_percent;
    end
    if rows_m > columns_m
        rows_agregar = 0 + deu_percent;
        columns_agregar = abs(rows_m - columns_m) + deu_percent;
    elseif rows_m == columns_m
        rows_agregar = 0 + deu_percent;
        columns_agregar = 0 + deu_percent;
    end

    rows_agregar;        % Rows to add
    columns_agregar;     % Columns to add
else
    rows_agregar = nombre_de_zeros(1);        % Rows to add
    columns_agregar = nombre_de_zeros(2);     % Columns to add



end

% _We add in Files_
% Matrix of zero rows
[rows_r, columns_r, ~] = size(image_1);

zeros_row = zeros(rows_agregar,columns_r); 

if patro_imatge == "uint8"
    zeros_row = cat(3, zeros_row, zeros_row, zeros_row);
    zeros_row = cast(zeros_row, 'uint8');
end

size(zeros_row);
size(image_1);

% Divide the zero matrix in two
[rows_tot, ~, ~] = size(zeros_row);
half = round(rows_tot/2);
end_fin = rows_tot;

% Divide for up
if patro_imatge == "uint8"
    zeros_up = zeros_row(1:half, :, :);
    zeros_up = cast(zeros_up, 'uint8');
else
    zeros_up = zeros_row(1:half, :);

end

size(zeros_up);

% Divide for down


if patro_imatge == "uint8"
    zeros_down = zeros_row(half + 1 : end_fin, :, :);
    zeros_down = cast(zeros_down, 'uint8');
else
    zeros_down = zeros_row(half + 1 : end_fin, :);
end
size(zeros_down);

% _Control_ Llargada igual
[size_zup, ~] = size(zeros_up) ; [size_zdown, ~] = size(zeros_down);  
if (size_zup + size_zdown) == rows_tot
    disp("Divisió zeros row OK")
end

% We add empty rows
image_1 = cat(1, zeros_up, image_1);
image_1 = cat(1, image_1, zeros_down);
%imshow(image_1)



% _Add in columns_
% Zero matrix rows
[rows_c, columns_c, ~] = size(image_1);

zeros_col = zeros(rows_c, columns_agregar); 
zeros_col = cat(3, zeros_col, zeros_col, zeros_col);
if patro_imatge == "uint8"
    zeros_col = cast(zeros_col, 'uint8');
end
size(zeros_col);
size(image_1);

% Divide matrix of zeros
[~, cols_tot, ~] = size(zeros_col);
half = round(cols_tot/2);
end_fin = cols_tot;

% Divide from up

if patro_imatge == "uint8"
    zeros_up = zeros_col(:, 1:half, :);
    zeros_up = cast(zeros_up, 'uint8');
else
    zeros_up = zeros_col(:, 1:half);
end
size(zeros_up);

% Divide from down

if patro_imatge == "uint8"
    zeros_down = zeros_col(:, half + 1 : end_fin, :);
    zeros_down = cast(zeros_down, 'uint8');
else
    zeros_down = zeros_col(:, half + 1 : end_fin);
end
size(zeros_down);

% _Control_ Same length
[~, size_zup] = size(zeros_up) ; [~, size_zdown] = size(zeros_down);  
if (size_zup + size_zdown) == cols_tot
    disp("Divisió zeros row OK")
end

%% Add empty rows
image_1 = cat(2, zeros_up, image_1);
image_1 = cat(2, image_1, zeros_down);

imatge_final = image_1;
%imshow(image_1)

% END FUNCTION



end
