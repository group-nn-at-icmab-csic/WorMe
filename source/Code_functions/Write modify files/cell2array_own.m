function [array_sortida] = cell2array_own(cell_entrada)

% Given a single-row cell of type string, that is, a string of cells, the array of it is returned

array_sortida = [];
for cada_v = 1:length(cell_entrada)
    array_sortida = [array_sortida, string(cell_entrada{cada_v})];
end


end