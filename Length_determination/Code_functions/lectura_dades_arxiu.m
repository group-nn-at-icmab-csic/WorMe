function [array_dades_est] = lectura_dades_arxiu(arxiu_text_output_manually)

% Definit un arxiu 'txt', de 2 columnes, es retorna l'array de la segona
% columna.

% Llegir arxiu dades
cell_dades_estad = llegir_text_delimitadors(arxiu_text_output_manually, ";");

% Si no hi ha sols una fila.
[n_files, n_columnes] = size(cell_dades_estad);

if n_files > 1
    
    % Obtenir sols les dades
    array_dades_est_prov = cell_dades_estad(2:end, 2:end);
    [n_files_cell, ~] = size(array_dades_est_prov);

    array_dades_est = [];
    for n_arrays_n = 1:n_files_cell
        array_dades_est = [array_dades_est; str2num(cell2mat(array_dades_est_prov(n_arrays_n)))];
    end

else
    array_dades_est = false;

end

end