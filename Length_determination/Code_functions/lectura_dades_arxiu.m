function [array_dades_est] = lectura_dades_arxiu(arxiu_text_output_manually)

% Defined a 'txt' file, with 2 columns, the array of the second
% column is returned.

% Read data file
cell_dades_estad = llegir_text_delimitadors(arxiu_text_output_manually, ";");

% If there is just a row: 
[n_files, n_columnes] = size(cell_dades_estad);

if n_files > 1
    
    % Obtain just hte data.
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