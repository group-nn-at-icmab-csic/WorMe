function [cell_ini] = cell_insert_valors(cell_ini, valors)

    % Inserta valors en una cell (principi bàsic, estalviar codi)

    if isempty(cell_ini)
        cell_ini = {valors};
    else
        cell_ini{end+1} = valors;
    end
end