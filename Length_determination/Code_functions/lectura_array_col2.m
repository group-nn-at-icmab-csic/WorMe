function [array_dades_est_col_2, array_dades_est_col_1] = lectura_array_col2(array_text)


% Donat una cell de dos columnes, es retorna la primera i segona columna sense encapçalament, com a cells apart.


% Si no hi ha sols una fila.
[n_files, ~] = size(array_text);

if n_files > 1
    
    % Obtenir sols les dades
    array_dades_est_c2 = array_text(2:end, 2:end);
    array_dades_est_c1 = array_text(2:end, 1:end);
    [n_files_cell, ~] = size(array_dades_est_c2);
    
    array_dades_est_col_2 = {};
    array_dades_est_col_1 = {};
    for n_arrays_n = 1:n_files_cell
        array_dades_est_col_2{end+1} = cell2mat(array_dades_est_c2(n_arrays_n));
        array_dades_est_col_1{end+1} = cell2mat(array_dades_est_c1(n_arrays_n));
        %array_dades_est_col_2 = [array_dades_est_col_2; cell2mat(array_dades_est_c2(n_arrays_n))];
        %array_dades_est_col_1 = [array_dades_est_col_1; cell2mat(array_dades_est_c1(n_arrays_n))];
    end

else
    array_dades_est_col_2 = false;

end

end