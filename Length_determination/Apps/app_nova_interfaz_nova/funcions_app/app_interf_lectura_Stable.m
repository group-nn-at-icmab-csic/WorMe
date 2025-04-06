function [S_textscan_table] = app_interf_lectura_Stable(app)

% Iniciació de la lectura de la taula principal de dades.

% INICI FUNCIO

dir_output = app.appv_dir_output;

if app.seg_inici_taula
    [S_textscan_table] = app_interf_llegir_main_dades(dir_output);
    
    % No tornarem a llegir la taula.
    app.seg_inici_taula = false;
    
    % Definim la taula en la variable semiglobal 'global_S_textscan_table':
    app.global_S_textscan_table = S_textscan_table;
else
    % Si no es llegeix per primera vegada, es descriu aquesta
    % com la guardada en la app:
    S_textscan_table = app.global_S_textscan_table;
end


% FINAL FUNCIO


end