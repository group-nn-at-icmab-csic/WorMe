function [formatSpec] = tipologia_formatspec_table(table_dades_totals)

% Determina el formatSpec a l'hora de fer un fprintf, quan es crea un
% arxiu, de les dades d'una TAULA.
%
%
% See also
% tipologia_formatspec
% write_dades_cell
% creacio_S_textscan
 
% INICI FUNCIÓ

% tipus_dades = []; % Control-comprovació
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
    % tipus_dades = [tipus_dades, string(class(cell_dades_totals{n_cell}))]; % Control-comprovació
end


% unique(tipus_dades) % Control-comprovació
% FINAL FUNCIÓ

end