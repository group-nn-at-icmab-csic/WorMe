function [S_textscan_table] = app_interf_lectura_Stable(app)

% Initialization of reading the main data table.

% FUNCTION START

dir_output = app.appv_dir_output;

if app.seg_inici_taula
    [S_textscan_table] = app_interf_llegir_main_dades(dir_output);
    
    % We will not read the table again.
    app.seg_inici_taula = false;
    
    % Define the table in the semiglobal variable 'global_S_textscan_table':
    app.global_S_textscan_table = S_textscan_table;
else
    % If it’s not the first read, we assign the table
    % as the one saved in the app:
    S_textscan_table = app.global_S_textscan_table;
end


% FUNCTION END



end