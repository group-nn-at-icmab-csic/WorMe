function app_interf_write_taula_sense_ultima_fila(app, dir_output, table_main)

% Donada una taula, es printa aquesta a un arxiu sense la seva última fila.

% Borrem la taula:
fid = fopen(strcat(dir_output, "/main_data_analysis.txt"),'w');
fclose(fid); % Elapsed time is 0.050528 seconds.

% delete(strcat(dir_output, "/main_data_analysis.txt"))

% Passem la taula a cell:
table_celled = table2cell(table_main);

[rows_tab,  ~] = size(table_celled);

% Printem per cada cell:
for cada_tableline = 1:rows_tab-1
    
    if cada_tableline == 1

        % No se li posa espai inicial.
        fid = fopen(strcat(dir_output, "/main_data_analysis.txt"),'a+');
        fprintf(fid, "%s$%s$%.3f$%s$%s$%s$%s$%s$%s", table_celled{cada_tableline, :});
        fclose(fid);    
        
    else

        fid = fopen(strcat(dir_output, "/main_data_analysis.txt"),'a+');
        fprintf(fid, "\n%s$%s$%.3f$%s$%s$%s$%s$%s$%s", table_celled{cada_tableline, :});
        fclose(fid);    
        
    end
   
end


% Upgade_taula:
% Redefinim la taula sense la última fila
S_textscan_table = app.global_S_textscan_table;
app.global_S_textscan_table = S_textscan_table(1:end-1,:);


end