function write_taula_add(arxiu_dir, table_main, separador)

% Given a table, it is printed to a new text file (overwriting the previous one, if any).
% Comes from f'write_taula_fun'.
%
%
% Variables
%   arxiu_dir
%   table_main
%   separador
%
% % Example:
% write_taula_sense_ultima_fila("Josep_proba.txt", taula_ex , "$");
% 
% % Check
% [S_textscan_table_newJosep] = read_data("Josep_proba.txt", typology_formatspec_table_norm(taula_ex ), "$", taula_ex .Properties.VariableNames);
% S_textscan_table_newJosep
%
% See also
% write_taula_fun
% read_data
% typology_formatspec_table_norm



% START FUNCTION

% Erase the table
fid = fopen(arxiu_dir);
line = fgetl(fid);
fclose(fid); % Elapsed time is 0.050528 seconds.

% delete(arxiu_dir)

% Transform table to cell
table_celled = table2cell(table_main);

% Check
if height(table_main) > 1;     error("Error in f'write_taula_add': Table more than a row."); end


% Print for each cell:

if line == -1

    % No space at the beginning
    fid = fopen(arxiu_dir,'a+');
    fprintf(fid, typology_formatspec_table_sep(table_main, separador), table_celled{:});
    % Nota: if not working use f'typology_formatspec_table_norm'
    fclose(fid);    
    
else

    fid = fopen(arxiu_dir,'a+');
    fprintf(fid, strcat("\n", typology_formatspec_table_sep(table_main, separador)), table_celled{:});
    fclose(fid);    
    
end




% % Obtain table properties:
% formatSpec_arxiu = typology_formatspec_table_norm(table_main);
% Variablenames_taula = table_main.Properties.VariableNames;



% END FUNCTION

end