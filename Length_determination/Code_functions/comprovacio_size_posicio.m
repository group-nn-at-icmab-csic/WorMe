function [proporcio_img] = comprovacio_size_posicio(proporcio_img, size_imatge)

% Donada la posicio d'una imatge (ex: 1   985   176    95), [x y w h]
% es retorna aquesta sense que hi puguin haver sobre-sortints de la
% mateixa, és a dir, sense que pugui ser que excedeixi les dimensions de la
% imatge, o bé que sigui inferior a x o y.

% INICI FUNCIO 

x_size = size_imatge(1);
y_size = size_imatge(2);

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


end