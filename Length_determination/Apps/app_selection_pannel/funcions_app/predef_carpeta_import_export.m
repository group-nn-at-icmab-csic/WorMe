function [predef_folder_carpeta] = predef_carpeta_import_export(app, str_tipu_export, write_read, ruta_write)


% Obté o guarda la carpeta predefinida concreta.
%
%
% Variables
% Input:
%   str_tipu_export - nom de la exportació (ex: "excel"). Es farà lectura i/o guardarà l'arxciu amb aquest nom.
%   write_read - "read" o "write" si el que es fa és llegir o crear l'arxiu
%   ruta_write - ruta a guardar (nomes en write)
% 
% Output:
%   predef_folder_carpeta - directori obtingut del read.
%
% See also
% app_interf_boto_exportia
% app_interf_button_export

% INICI FUNCIÓ


        % Predefinicio carpeta:
        
        % Obtenim ruta Results_out:
        carpeta_output = app.appv_dir_output; % dir_output, que és en script principal carpeta_output 
        % ex: "D:\Escritorio\Length determination v2_15\Results_out\20230121_1947_200"

        carpeta_output_split = strsplit(carpeta_output, "\");
        results_out = strjoin(carpeta_output_split(1:end-1), "\");

        predefined_folder_input = strcat(results_out, "\Internal_code_files\predefined_folder_exp_", str_tipu_export, ".txt");

        % Lectura de la ruta predefinida
        if isequal(write_read, "read")
    
            if isfile(predefined_folder_input)
                % Si existeix un arxiu de text que contingui l'escala
                predef_folder_llegida = llegir_text_delimitadors(predefined_folder_input, ";");
                predef_folder_carpeta = predef_folder_llegida{2}; % es defineix la carpeat predefinida
            else
                % Si no existeix una escala definida, es guarda sense valor.
                predef_folder_carpeta = '';
            end
        
        % Write de la ruta predefinida
        elseif isequal(write_read, "write")
            % Definim l'arxiu:
            array_write_folder = ["Folder", ruta_write];
            % Fem el .txt
            write_text_array(predefined_folder_input, array_write_folder, ";");

            predef_folder_carpeta = '';
        else
            % Sino hi ha error
            error("Error in f'predef_carpeta_import_export': not defined a correct function")
        end

% FINAL FUNCIÓ

end