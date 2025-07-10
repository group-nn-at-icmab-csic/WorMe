function [formatSpec] = typology_formatspec_table_sep(table_dades_totals, separador)

% Determines the formatSpec when doing an fprintf, when creating a
% file, of the data in a table.
%
%
% See also
% create_S_textscan_modifs
% typology_formatspec_table_norm
 
% START FUNCTION

% tipus_dades = []; % Control-check
formatSpec = "";
for n_cell = 1:width(table_dades_totals)
    % cell_dades_totals{n_cell}
    if isequal(string(class(table2array(table_dades_totals(:, n_cell)))), "double")
        if isequal(n_cell, 1)
            formatSpec = strcat(formatSpec, "%f");
        else
            formatSpec = strcat(formatSpec,separador, "%f");
        end

    elseif isequal(string(class(table2array(table_dades_totals(:, n_cell)))), "string")
        if isequal(n_cell, 1)
            formatSpec = strcat(formatSpec, "%s");
        else
            formatSpec = strcat(formatSpec,separador, "%s");
        end
        
    else
        error("Error in f''tipologia_formatspec: not specified the correct variable")
    end
    % tipus_dades = [tipus_dades, string(class(cell_dades_totals{n_cell}))]; % Control-check
end



% unique(tipus_dades) % Control-check
% END FUNCTION

end