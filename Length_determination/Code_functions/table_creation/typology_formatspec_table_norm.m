function [formatSpec] = typology_formatspec_table_norm(table_dades_totals)

% Determines the formatSpec when doing an fprintf, when creating a
% file, of the data in a table.
%
%
% See also
% create_S_textscan_modifs
% typology_formatspec_table_sep
 
% START FUNCTION

% tipus_dades = []; % Control-check
formatSpec = "";
for n_cell = 1:width(table_dades_totals)
    % cell_dades_totals{n_cell}
    if isequal(string(class(table2array(table_dades_totals(:, n_cell)))), "double")
        formatSpec = strcat(formatSpec, "%f");
    elseif isequal(string(class(table2array(table_dades_totals(:, n_cell)))), "string")
        formatSpec = strcat(formatSpec, "%s");
    else
        error("Error in f''tipologia_formatspec: not specified the correct variable")
    end
    % tipus_dades = [tipus_dades, string(class(cell_dades_totals{n_cell}))]; % Control-check
end


% unique(tipus_dades) % Control-check
% END FUNCTION

end