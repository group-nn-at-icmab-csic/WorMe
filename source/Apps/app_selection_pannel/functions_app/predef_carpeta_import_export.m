function [predef_folder_carpeta] = predef_carpeta_import_export(app, str_tipu_export, write_read, ruta_write)


% Gets or saves the specific predefined folder.
%
%
% Variables
% Input:
%   str_tipu_export - name of the export (ex: "excel"). The file will be read and/or saved with this name.
%   write_read - "read" or "write" depending if reading or creating the file
%   ruta_write - path to save (only in write)
% 
% Output:
%   predef_folder_carpeta - directory obtained from the read.
%
% See also
% app_interf_boto_exportia
% app_interf_button_export

% START OF THE FUNCTION


        % Folder predefined:
        
        % We get the Results_out path:
        carpeta_output = app.appv_dir_output; % dir_output, which in main script is carpeta_output 
        % ex: "D:/Escritorio/Length determination v2_15/Results_out/20230121_1947_200"

        carpeta_output_split = strsplit(carpeta_output, filesep);
        results_out = strjoin(carpeta_output_split(1:end-1), filesep);
        predefined_folder_input = strcat(results_out, fullfile(filesep, 'Internal_code_files', 'predefined_folder_exp_'), str_tipu_export, ".txt");


        % Reading the predefined path
        if isequal(write_read, "read")
    
            if isfile(predefined_folder_input)
                % If a text file exists that contains the scale
                predef_folder_llegida = read_text_delimiters(predefined_folder_input, ";");
                predef_folder_carpeta = predef_folder_llegida{2}; % the predefined folder is defined
            else
                % If there is no defined scale, save without value.
                predef_folder_carpeta = '';
            end
        
        % Write the predefined path
        elseif isequal(write_read, "write")
            % Define the file:
            array_write_folder = ["Folder", ruta_write];
            % Create the .txt
            write_text_array(predefined_folder_input, array_write_folder, ";");

            predef_folder_carpeta = '';
        else
            % Otherwise, error
            error("Error in f'predef_carpeta_import_export': not defined a correct function")
        end

% END OF THE FUNCTION


end