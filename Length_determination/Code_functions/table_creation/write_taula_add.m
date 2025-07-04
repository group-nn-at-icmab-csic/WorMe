function write_taula_add(arxiu_dir, table_main, separador)

% Donada una taula, es printa en un arxiu de text nou (sobrescrivint l'anterior, si n'hi ha).
%
% Provinent de la f'write_taula_sense_ultima_fila'.
%
%
% Variables
%   arxiu_dir : 
% 
%   table_main : 
%
%   separador : 
%
% % Exemple:
% write_taula_sense_ultima_fila("Josep_proba.txt", taula_ex , "$");
% 
% % Comprovació
% [S_textscan_table_newJosep] = llegir_dades("Josep_proba.txt", tipologia_formatspec_table(taula_ex ), "$", taula_ex .Properties.VariableNames);
% S_textscan_table_newJosep
%
% See also
% write_taula_sense_ultima_fila
% llegir_dades
% tipologia_formatspec_table



% INICI FUNCIÓ

% Borrem la taula:
fid = fopen(arxiu_dir);
line = fgetl(fid);
fclose(fid); % Elapsed time is 0.050528 seconds.

% delete(arxiu_dir)

% Passem la taula a cell:
table_celled = table2cell(table_main);

% Comprovacio
if height(table_main) > 1;     error("Error in f'write_taula_add': Table more than a row."); end


% Printem per cada cell:

if line == -1

    % No se li posa espai inicial.
    fid = fopen(arxiu_dir,'a+');
    fprintf(fid, tipologia_formatspec_table_separador(table_main, separador), table_celled{:});
    % Nota: sino funciona fer servir funció f'tipologia_formatspec_table'
    fclose(fid);    
    
else

    fid = fopen(arxiu_dir,'a+');
    fprintf(fid, strcat("\n", tipologia_formatspec_table_separador(table_main, separador)), table_celled{:});
    fclose(fid);    
    
end




% % Obtenim propietats de la taula:
% formatSpec_arxiu = tipologia_formatspec_table(table_main);
% Variablenames_taula = table_main.Properties.VariableNames;



% FINAL FUNCIÓ

end