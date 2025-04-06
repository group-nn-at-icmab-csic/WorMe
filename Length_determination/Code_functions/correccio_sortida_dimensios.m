function [proporcio_img_new] = correccio_sortida_dimensios(proporcio_img, size_final)

% Donada una posicio de les mesures, si aquestes sobrepassen la imatge, es
% corregeixen les mateixes.
%
%
%
% See also
% retallar_BWRGBimatge_BB_nou


% INICI FUNCIÓ

% size_final = size(BW_final)
x_size = size_final(1);
y_size = size_final(2);

% _Correcció possible sortida de les mesures_
proporcio_img_new = proporcio_img;

% SI hi ha número negatius.
if ismember(1, proporcio_img_new <= 0)
    % Es cambia el valor per 0, i es suma a la amplada/llargada d'aquest.
    % En X:
    if proporcio_img_new(1) <= 0
    valor_x = proporcio_img_new(1);
    proporcio_img_new(3) = proporcio_img_new(3) + valor_x +1;
    proporcio_img_new(1) = 1; % Ha de ser 1, i no 0, perque estem parlant de posixions X,Y
    end
    % En Y:
    if proporcio_img_new(2) <= 0
        valor_x = proporcio_img_new(2);
        proporcio_img_new(4) = proporcio_img_new(4) + valor_x +1;
        proporcio_img_new(2) = 1;
    end
end


% Si el tamany de la imatge retallada és superior a les mesures de la imatge inicial:
% En Y
if proporcio_img_new(2) + proporcio_img_new(4) > x_size
    diferencia_x = x_size - (proporcio_img_new(2) + proporcio_img_new(4) );
    proporcio_img_new(4) = proporcio_img_new(4) + diferencia_x;
end

% En X
if proporcio_img_new(1) + proporcio_img_new(3) > y_size
    diferencia_y = y_size - (proporcio_img_new(1) + proporcio_img_new(3) );
    proporcio_img_new(3) = proporcio_img_new(3) + diferencia_y;
end


% FINAL FUNCIÓ

end