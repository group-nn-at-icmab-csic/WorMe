function write_taula(arxiu_dir, table_main, separador)

% Donada una taula, es printa en un arxiu de text nou (sobrescrivint l'anterior, si n'hi ha).
%
% Provinent de la f'write_taula_sense_ultima_fila'.
%
%
% % Exemple:
% write_taula_sense_ultima_fila("Josep_proba.txt", taula_ex , "$");
% 
% % Comprovació
% [S_textscan_table_newJosep] = read_data("Josep_proba.txt", typology_formatspec_table_norm(taula_ex ), "$", taula_ex .Properties.VariableNames);
% S_textscan_table_newJosep
%
% See also
% write_taula_sense_ultima_fila
% read_data
% typology_formatspec_table_norm



% START FUNCTION

% Borrem la taula:
fid = fopen(arxiu_dir,'w');
fclose(fid); % Elapsed time is 0.050528 seconds.

% delete(arxiu_dir)

% Passem la taula a cell:
table_celled = table2cell(table_main);


% Printem per cada cell:
for cada_tableline = 1:height(table_celled)
    
    if cada_tableline == 1

        % No se li posa espai inicial.
        fid = fopen(arxiu_dir,'a+');
        fprintf(fid, typology_formatspec_table_sep(table_main, separador), table_celled{cada_tableline, :});
        % Nota: sino funciona fer servir funció f'typology_formatspec_table_norm'
        fclose(fid);    
        
    else

        fid = fopen(arxiu_dir,'a+');
        fprintf(fid, strcat("\n", typology_formatspec_table_sep(table_main, separador)), table_celled{cada_tableline, :});
        fclose(fid);    
        
    end

    
   
end

% % Obtenim propietats de la taula:
% formatSpec_arxiu = typology_formatspec_table_norm(table_main);
% Variablenames_taula = table_main.Properties.VariableNames;


% END FUNCTION

end