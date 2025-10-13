function [cell_ini] = cell_insert_values(cell_ini, valors)

    % Insert values ​​into a cell (basic principle, save code)

    if isempty(cell_ini)
        cell_ini = {valors};
    else
        cell_ini{end+1} = valors;
    end
end