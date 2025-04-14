function [str_rute_redef] = split_string_n(str_rute, n_restant)

    % Resta el nombre n de carpetes (n_restant) finals d'una ruta (str_rute).
    % 
    %
    % See also
    % determina_path_def
    % determinacio_path


    % INICI FUNCIÓ

    % Resta el nombre n de carpetes (n_restant) finals d'una ruta (str_rute).

    % Split valors
    spit_rute = strsplit(str_rute, "\");
    
    % Sumem strings
    str_rute_redef = strjoin(spit_rute(1:end-n_restant), "\");


    % FINAL FUNCIÓ

end
