function [array_sortida] = cell2array_josep(cell_entrada)

% Donat una cell d'una sola fila tipus string, és a dir, una cadena de cell, es retorna
% l'array d'aquesta.

array_sortida = [];
for cada_v = 1:length(cell_entrada)
    array_sortida = [array_sortida, string(cell_entrada{cada_v})];
end


end