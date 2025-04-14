function [S_textscan_table] = app_interf_llegir_main_dades(dir_output)

% Llegeix i guarda en una taula (S_textscan_table) l'arxiu de text "main_data_analysis.txt"
% Funció de la app 'app_nova_interfaz_nova_funcions'.
%
%
% See also
% app_interf_guardar_main_dades
% app_interf_descriure_dades


% INICI FUNCIÓ

fid = fopen(strcat(dir_output, "/main_data_analysis.txt"));
S_textscan = textscan(fid, '%s %s %.3f %s %s %s %s %s %s', 'Delimiter', "$"); % Elapsed time is 0.000535 seconds.
fclose(fid);
% Ho passem a taula
S_textscan_table = table(string(S_textscan{1}), ...
                         string(S_textscan{2}), ...
                          S_textscan{3}, ...
                          string(S_textscan{4}), ...
                          string(S_textscan{5}), ...
                          string(S_textscan{6}), ...
                          string(S_textscan{7}), ...
                          string(S_textscan{8}), ...
                          string(S_textscan{9}), ...
                        'VariableNames', ["IsCeleg","NomWorm", "Length", "Bounding", "Modifs", "Indx_skel", "Indx_BW", "WidthValues", "Resolution"] );




% FINAL FUNCIÓ


end
 