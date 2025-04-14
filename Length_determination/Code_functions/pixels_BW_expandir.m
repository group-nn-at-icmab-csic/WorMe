function [BW_to_expand] = pixels_BW_expandir(BW_to_expand, val_expandir)

% Donat una imatge binària, s'expandeixen els pixels d'aquesta el numero de
% vegades determinat (v'val_expandir').
% És a dir, si per exemple es té una línia, i es vol fer 2 vegades, els
% pixels circumdants a cada pixel en 2 pixels posteriors tindàn el valor de
% 1.
%
% Variables
%
% BW_to_expand : imatge binaria
% val_expandir : el valor del qual es vol expandir (ex: 1, 2, 3...)
%
% 0  0  0
% 0  1  0
% 0  0  0
%
% passa a:
% 1  1  1
% 1  1  1
% 1  1  1
% Quan és val_expandir és 1.
%
% Exemples variables
% BW_to_expand = boudng_BW_Llista;
% val_expandir = 3; % pixels que es vol expandir


% INICI FUNCIO

% Copiem la imatge en una v' nova
BW_to_expand_new = BW_to_expand;

if val_expandir == 0
    % Si el valor d'expandir és zero (és a dir, no s'expandeix), es retorna
    % la imatge igual d'entrada.

    % No es fa res (s'ha copiat la imatge anteriorment)
else
    
    [x_cada, y_cada] = find(BW_to_expand);

    for cada_pixel = 1:length(x_cada)

        % Per cada píxel
        for x_123 = -val_expandir:val_expandir
            for y_123 = -val_expandir:val_expandir
                BW_to_expand_new(x_cada(cada_pixel)+x_123, y_cada(cada_pixel)+y_123) = 1;
            end
        end

    end

    % imshow(BW_to_expand)
end

% FINAL FUNCIÓ

end