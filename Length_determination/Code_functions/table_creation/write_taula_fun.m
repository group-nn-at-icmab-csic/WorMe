function write_taula_fun(arxiu_dir, table_main, var_disc)

% Write functional table: If the file does not exist, it is created, if it exists but
% there is an equal variable, it is overwritten, otherwise it is added.
%
% The defined table must be equal to the read table
%
%
% Variables
% arxiu_dir : directory of the table (Josep/files/taula.txt)
% table_main : Table to write in the file.
% var_disc : variable to discriminate repetitiveness. ex: "Frame"
%
%
%% % Example
% % We obtain table
% [table_S_textscan_tracking] = app_sel_open_S_textscan_tracking(app);
%
% % We get a row, we change it (as an example)
% table_S_textscan_tracking_new = table_S_textscan_tracking(1,:)
% table_S_textscan_tracking_new.("Frame") = string(randi(10))
%
% % Write table
% arxiu_dir = strcat(app.directori_nomvideo_v, "\Tracking_analysis\", "Tracking_data_", last_folder(app.directori_nomvideo_v), ".txt");
% write_taula_fun(arxiu_dir, table_S_textscan_tracking_new, "Frame")
%
% % Read current table for verification
% [S_textscan_table_new] = read_data(arxiu_dir, typology_formatspec_table_norm(table_S_textscan_tracking_new), "$", table_S_textscan_tracking_new.Properties.VariableNames);
% 
% S_textscan_table_new
%
%
% See also

% START FUNCTION

if height(table_main) > 1
    disp("More than a row!")
end

if isfile(arxiu_dir)
    
    % Lectura taula actual
    [S_textscan_table] = read_data(arxiu_dir, typology_formatspec_table_norm(table_main), "$", table_main.Properties.VariableNames);
    
    % Si no hi és en la taula, afegeix (add):
    if ~ismember(double(table_main.(var_disc)), double(S_textscan_table.(var_disc)))
        
        % Afegim a la taula existent
        write_taula_add(arxiu_dir, table_main, "$")
    else
        % Si hi és, treurem la fila i tornarem a posar tota la taula amb la fila nova:
        
        % Re-definim taula lectura i re-describim la taula existent
        S_textscan_table(double(S_textscan_table.(var_disc)) == double(table_main.(var_disc)), :) = table_main;
        
        write_taula(arxiu_dir, S_textscan_table, "$")
        
    end

else

    % Si no hi és l'arxiu, se'n crea un de nou
    write_taula(arxiu_dir, table_main, "$")
    % error("Not file defined")
    
end

% END FUNCTION

end