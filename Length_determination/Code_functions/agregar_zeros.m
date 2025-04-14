%% Agrega regións vuides a la imatge de forma proporcionada de manera que aquesta quedi en forma de cuadrat. 
%% L'objectiu principal és modificar la imatge per a obtenir video.
%% Aquesta funció es pot fer servir per igualar diferents imatges vers una d'inicial, si es compara la llargada de les files i columnes de cada una amb la inicial.

function imatge_final = agregar_zeros(imatge_inicial, nombre_de_zeros, percentatge_adicional)

   %% INICI CODI

%% Agrega regións vuides a la imatge de forma proporcionada de manera que aquesta quedi en forma de cuadrat. 
%% L'objectiu principal és modificar la imatge per a obtenir video.
%% Aquesta funció es pot fer servir per igualar diferents imatges vers una d'inicial, si es compara la llargada de les files i columnes de cada una amb la inicial.

% [imatge_final] = agregar_zeros(imatge_inicial, nombre_de_zeros, percentatge_adicional)

% Input: imatge_inicial, nombre_de_zeros, percentatge_adicional
% Output: imatge_final

% Paràmetres:
%       nombre_de_zeros: 
%                       "aquesta"  :  s'eixample aquesta imatge
%                       [files, columnes] : files i columnes a agregar a la
%                       imatge
%       percentatge_adicional: 
%                           empty : es determina com a zero

% Imatge inicial
image_1 = imatge_inicial;
%     imshow(image_1)

% Si la imatge és binaria, la convertim en 3D
if islogical(image_1)
    patro_imatge = "logical";
    disp("TIPUS IMATGE: LOGICAL");

    % Si es volgués passar la imatge de logica a uint8:
%         image_1 = cast(image_1, "uint8");
%         image_1 = cat(3, image_1, image_1, image_1);
end

if isa(image_1,'integer')
    patro_imatge = "uint8"
end

%imshow(image_1);

% Quants zeros volem agregar? X i Y zeros en els eixos.

% en el nostre cas:
[rows_m, columns_m, ~] = size(image_1);

% Percentatge adicional a afegir a la imatge (percentatge_adicional)
% Si no es definit es defineix com a zero.
if ~exist('percentatge_adicional','var')
    percentatge_adicional = 0;
end
deu_percent = round(rows_m * percentatge_adicional/100);  % ex: 10%


if ~exist('nombre_de_zeros','var')
    disp("Nombre de files i columnes a agregar no definit")
end



% Imatge primera
if string(nombre_de_zeros) == "aquesta"
    % Mirem llargada files:
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

    rows_agregar;        % Files a agregar
    columns_agregar;     % Columnes a agregar
else
    rows_agregar = nombre_de_zeros(1);        % Files a agregar
    columns_agregar = nombre_de_zeros(2);     % Columnes a agregar



end

% _Agreguem en Files_
% Matriu zeros files (rows)
[rows_r, columns_r, ~] = size(image_1);

zeros_row = zeros(rows_agregar,columns_r); 

if patro_imatge == "uint8"
    zeros_row = cat(3, zeros_row, zeros_row, zeros_row);
    zeros_row = cast(zeros_row, 'uint8');
end

size(zeros_row);
size(image_1);

% % Dividim matriu de zeros entre dos
[rows_tot, ~, ~] = size(zeros_row);
half = round(rows_tot/2);
end_fin = rows_tot;

% Dividim per sobre
if patro_imatge == "uint8"
    zeros_up = zeros_row(1:half, :, :);
    zeros_up = cast(zeros_up, 'uint8');
else
    zeros_up = zeros_row(1:half, :);

end

size(zeros_up);

% Dividim per sota


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

% Agreguem les files vuides
image_1 = cat(1, zeros_up, image_1);
image_1 = cat(1, image_1, zeros_down);
%imshow(image_1)



% _Agreguem en Columnes_
% Matriu zeros files (rows)
[rows_c, columns_c, ~] = size(image_1);

zeros_col = zeros(rows_c, columns_agregar); 
zeros_col = cat(3, zeros_col, zeros_col, zeros_col);
if patro_imatge == "uint8"
    zeros_col = cast(zeros_col, 'uint8');
end
size(zeros_col);
size(image_1);

% % Dividim matriu de zeros entre dos
[~, cols_tot, ~] = size(zeros_col);
half = round(cols_tot/2);
end_fin = cols_tot;

% Dividim per sobre

if patro_imatge == "uint8"
    zeros_up = zeros_col(:, 1:half, :);
    zeros_up = cast(zeros_up, 'uint8');
else
    zeros_up = zeros_col(:, 1:half);
end
size(zeros_up);

% Dividim per sota

if patro_imatge == "uint8"
    zeros_down = zeros_col(:, half + 1 : end_fin, :);
    zeros_down = cast(zeros_down, 'uint8');
else
    zeros_down = zeros_col(:, half + 1 : end_fin);
end
size(zeros_down);

% _Control_ Llargada igual
[~, size_zup] = size(zeros_up) ; [~, size_zdown] = size(zeros_down);  
if (size_zup + size_zdown) == cols_tot
    disp("Divisió zeros row OK")
end

%% Agreguem les files vuides
image_1 = cat(2, zeros_up, image_1);
image_1 = cat(2, image_1, zeros_down);

imatge_final = image_1;
%imshow(image_1)

%% FINAL CODI




end
