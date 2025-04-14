function [montatge_imatge, imatge_zeros] = printar_punts(BW_amplada, indicat_regio, nombre_punts)

% Es grafica els punts màxims o concrets del bwdist(), o bé una regió de la imatge esqueletonitzada.

%% INICI SCRIPT

% Paràmetres:
%               indicat_regio
%                               Valorbwdist
%                               Zonaesquel
%               nombre_punts
%                               si Valorbwdist -> punt concret que es
%                               visualitzarà del bwdist() "max"
%                               si Valorbwdist -> "max": identifica els punts maxims de bwdist() 
%                               si Zonaesquel -> regió de la imatge esqueletonitzada.


BW_amplada_bwdist = bwdist(~BW_amplada);
BW_skel= bwskel(BW_amplada);
[rows, cols] = find(BW_skel); %linies i columnes 

imatge_zeros = zeros(size(BW_amplada_bwdist));  % Matriu on es pintaràn els punts.


% "Valorbwdist": Es vol veure els punts en concret que tenen els valors de bwdist, sobre 
% la regió normal de la imatge binària primera.

if indicat_regio == "Valorbwdist"
    
    % Per a obtenir el valor o els valors máxims de la imatge:
    % Regións amb més amplada:
    [unics, b, n] = unique(BW_amplada_bwdist);
    length(unics);  % 112  ; valors maxims
    length(b);  % 112  ;  index valors maxims de manera singular
    length(n);   % 1900000
    
    unique(n); %<- dona els valors indexats.
    
    
    % Si els inputs son menors que 3, s'aplica el valor maxim del bwdist().
    if nargin < 3
        % Si busquem amb valor maxim
        valor_max = max(unique(unics));
        index_val_max = find((unics == valor_max));
    % Si els inputs són majors de tres, 
    else
        %si s'especifica 'max' dona el maxim, sino el valor indicat
        if string(nombre_punts) == "max"
            valor_max = max(unique(unics));
            index_val_max = find((unics == valor_max));

        else
        % Si busquem amb el valor, per exemple, de '3'
        % nombre_punts = 3;
        index_val_max = find((unics == nombre_punts));
        end
    end
    

    
    % Si busquessim el segon valor més gran
    % [ii,ii] = sort(A);
    % out = A(ii([2,end-1]));
    
    
    % Per a veure quants valor són maxims:
    imatge_BW_index_max = n == index_val_max;
    % Tenim els punts on es troben aquests
    
    % Es modifica la matriu de zeros
    imatge_zeros(imatge_BW_index_max) = 1;

    
end


if indicat_regio == "Zonaesquel"
    
    % Necessitem determinar l'interval de l'esqueletonització,
    % definit de manera percentual.

    percen_tot = length(rows);
    interval_1 = round( ( percen_tot / 100 ) .* nombre_punts(1) );
    interval_2 = round( ( percen_tot / 100 ) .* nombre_punts(2) );

    rows_nou = rows(interval_1 : interval_2);  %<- nota que ha de ser un interval.
    cols_nou = cols(interval_1 : interval_2);   


    % Per cada pixel que volem es determina com 1 en la imatge de zeros
    for cada_pixel = 1:length(rows_nou)
        imatge_zeros(rows_nou(cada_pixel), cols_nou(cada_pixel)) = 1;
    end
end


% Trobem els punts en la matriu
[rows, cols] = find(imatge_zeros);

% - Grafiquem -
% creem punt vermell a marcar en la imatge:
punt = zeros(5);
punt(punt == 0) = 1;
imshow(punt)
% Aquest el pintarem de vermell amb imoverlay

% Fiquem per a cada punt a la imatge
imshow(BW_amplada_bwdist, [])

%Fem una matriu de zeros a on ficarem els punts, per a després juntar-ho
%amb la imatge mascara inicial
imatge_zeros2 = zeros(size(BW_amplada_bwdist));

% Per cada punt definim la matriu de zeros
for cada_punt = 1:length(rows)
    imatge_zeros2( ...
        rows(cada_punt)-2: rows(cada_punt)+2, ...
        cols(cada_punt)-2:cols(cada_punt)+2) = ...
        punt;
end

montatge_imatge = imshow(imoverlay(BW_amplada_bwdist, imatge_zeros2, "r"));
montatge_imatge = montatge_imatge.CData;
imshow(montatge_imatge)

imatge_zeros = im2uint8(imatge_zeros);
imshow(imatge_zeros)


%% FINAL SCRIPT


end