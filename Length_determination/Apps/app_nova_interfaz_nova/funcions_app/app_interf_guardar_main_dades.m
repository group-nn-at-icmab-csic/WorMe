function app_interf_guardar_main_dades(app, dir_output, cell_dades_totals)

% Guarda les dades de la cell a l'arxiu de text "main_data_analysis.txt"
% Funció de la app 'app_nova_interfaz_nova_funcions'.
%
% Les dades de la cell son: "IsCeleg","NomWorm", "Length", "Bounding", "Modifs", "Indx_skel", "Indx_BW", "WidthValues", "Resolution"
%
% See also
% app_interf_llegir_main_dades
% appf_split_strindex

% INICI FUNCIÓ

%strcat(dir_output, "/main_data_analysis.txt")
fid = fopen(strcat(dir_output, "/main_data_analysis.txt"));
line = fgetl(fid);
fclose(fid);


if line == -1
    % No se li posa espai inicial.
    fid = fopen(strcat(dir_output, "/main_data_analysis.txt"),'a+');
    fprintf(fid, "%s$%s$%.3f$%s$%s$%s$%s$%s$%s", cell_dades_totals{:});
    fclose(fid);    
else
    fid = fopen(strcat(dir_output, "/main_data_analysis.txt"),'a+');
    fprintf(fid, "\n%s$%s$%.3f$%s$%s$%s$%s$%s$%s", cell_dades_totals{:});
    fclose(fid);    
end

% Upgrade_taula: afegim al arxiu de la app:
% Si no és l'inici de la taula, no s'afegeix, donat que llavors (i sols llavors) sí que es
% fa la lectura.
if  ~app.seg_inici_taula
    app.global_S_textscan_table = [app.global_S_textscan_table; cell_dades_totals];
end


% FINAL FUNCIÓ


end
