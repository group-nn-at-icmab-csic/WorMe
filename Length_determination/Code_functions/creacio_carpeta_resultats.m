function [carpeta_output] = creacio_carpeta_resultats(userSavedDocuments, nom_carpeta_input)

% cREATE THE RESULTS FOLDER

% START OF THE FUNCTION
    
    %Data
    data_temps = clock;
    data_actual = strcat( ...
        string(data_temps(1)), ...
        string(retorna_zeros_un(data_temps(2))), ...
        string(retorna_zeros_un(data_temps(3))), "_", ...
        string(retorna_zeros_un(data_temps(4))), ...
        string(retorna_zeros_un(data_temps(5))));
    
    carpeta_output = strcat(userSavedDocuments, "\Results_out\", data_actual, "_", nom_carpeta_input);
    
    
    % Carpeta resultats output
    if ~isfolder(carpeta_output)
        mkdir(carpeta_output)
        mkdir(strcat(carpeta_output, "\Processment_parameters"))
    end

% FINAL OF THE FUNCTION

end