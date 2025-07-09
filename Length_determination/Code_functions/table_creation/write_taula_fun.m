function write_taula_fun(arxiu_dir, table_main, var_disc)

% Write taula funcional: Si no existeix l'arxiu, es crea, si existeix però
% hi ha una variable igual, la sobreescriu, sinó la afegeix.
%
% La taula ha de ser igual la definida que la que es llegeix.
%
%
% Variables
%   arxiu_dir : directori de la taula (Josep/files/taula.txt)
%   table_main : Taula a escriure en l'ariux.
%   var_disc : variable a discriminar la repetitivitat. ex: "Frame"
%
%
%
% Molt semblant a app_sel_computar_dades_manual_file, però ara els tèrmes
% poden ser nous.
%
%
%
% % Exemple
% % Obtenim taula
% [table_S_textscan_tracking] = app_sel_open_S_textscan_tracking(app);
% 
% % Obtenim una fila, la canviem (a mode d'exemple)
% table_S_textscan_tracking_new = table_S_textscan_tracking(1,:)
% table_S_textscan_tracking_new.("Frame") = string(randi(10))
% 
% % Write taula
% arxiu_dir = strcat(app.directori_nomvideo_v, "\Tracking_analysis\", "Tracking_data_", carpeta_ultim(app.directori_nomvideo_v), ".txt");
% write_taula_fun(arxiu_dir, table_S_textscan_tracking_new, "Frame")
% 
% % Lectura taula actual per comprovació
% [S_textscan_table_new] = read_data(arxiu_dir, typology_formatspec_table_norm(table_S_textscan_tracking_new), "$", table_S_textscan_tracking_new.Properties.VariableNames);
% 
% S_textscan_table_new
%
%
% See also
% app_sel_computar_dades_manual_file

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