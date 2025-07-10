function [carpeta_output] = results_folder_create(userSavedDocuments, nom_carpeta_input)

% Create the results folder

% START FUNCTION
    
    % Date
    data_temps = clock;
    data_actual = strcat( ...
        string(data_temps(1)), ...
        string(return_zeros_one(data_temps(2))), ...
        string(return_zeros_one(data_temps(3))), "_", ...
        string(return_zeros_one(data_temps(4))), ...
        string(return_zeros_one(data_temps(5))));
    
    carpeta_output = strcat(userSavedDocuments, "\Results_out\", data_actual, "_", nom_carpeta_input);
    
    
    % Folder of output results
    if ~isfolder(carpeta_output)
        mkdir(carpeta_output)
        mkdir(strcat(carpeta_output, "\Processment_parameters"))
    end

% END FUNCTION

end