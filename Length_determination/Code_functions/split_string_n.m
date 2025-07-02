function [str_rute_redef] = split_string_n(str_rute, n_restant)

    % Substracts the number n of last folders (n_restant) of a path (str_rute).
    % 
    %
    % See also:
    % determina_path_def
    % determinacio_path


    % START FUNCTION

    % Split values
    spit_rute = strsplit(str_rute, "\");
    
    % Add strings
    str_rute_redef = strjoin(spit_rute(1:end-n_restant), "\");


    % END FUNCTION

end
