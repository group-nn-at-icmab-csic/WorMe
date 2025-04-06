function write_dades_cell(txt_data_name, cell_dades_totals, write_values, separador_char)

% Guarda les dades d'una cell, de manera que es pugui fer servir després la funció f'llegir_dades' per a poder
% llegir en format de taula aquestes.
% 
%
% Variables:
% txt_data_name : directori i nom del arxiu.
%           ex: "Results\main_results_josep.txt"
%
% cell_dades_totals : cell amb les dades
%
% write_values : és el codi del fprint que s'ha d'entrar.
%           ex: "%s%s%.3f%s%s%s%s%s" en una cell de 7 valors.
%
% separador_char: separador que tindràn els valors de cada cell
%           ex: "$"
%
% See also
% llegir_dades
% app_interf_llegir_main_dades
% appf_split_strindex

% INICI FUNCIÓ


% _Pre-procés caràcters printf_
[C_str] = strsplit(write_values, "%");
write_values = strcat("%", strjoin(C_str(2:end), strcat(separador_char, "%") ));

% __Write de l'arxiu__
if ~isfile(txt_data_name)
    % disp("New file")
    % No se li posa espai inicial.
    fid = fopen(txt_data_name,'a+');
    fprintf(fid, write_values, cell_dades_totals{:});
    fclose(fid);    
else
    % disp("Existing file")
    fid = fopen(txt_data_name,'a+');
    fprintf(fid, strcat("\n", write_values), cell_dades_totals{:});
    fclose(fid);    
end



% FINAL FUNCIÓ


end