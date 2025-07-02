function [carpeta_input, nom_carpeta_input] = troncal_obtencio_dir_originals(userSavedDocuments)

% ___OBTAIN THE ORIGINAL IMAGES' FOLDER___
% v'predef_folder_folder' : predefined folder to start the search.
% v'input_folder' : directory of the original images.
% v'input_folder_name' : name of the directory of the original images
%
% _Obtaining (or not) value of the predefined folder
% Obtained from "Results_out\Internal_code_files\predefined_folder.txt"
predefined_folder_input = strcat(userSavedDocuments, "\Results_out\Internal_code_files", "\predefined_folder.txt");

if isfile(predefined_folder_input)
    % If there is a text file that contains the scale
    predef_folder_llegida = llegir_text_delimitadors(predefined_folder_input, ";");
    predef_folder_carpeta = predef_folder_llegida{2}; clear predef_folder_llegida  % define the predefined folder
else
    % If there is not a defined scale, it is saved without a value.
    predef_folder_carpeta = '';
end

% __Obtain the folder__
% Input folder
carpeta_input = uigetdir(predef_folder_carpeta, "Select the folder with images");

% _Write predefined folder__
% Obtain the same string of the folder, defined in a previous folder from the last defined folder
[split_arxiu_sortida] = splits_objectes_valor(carpeta_input, "\", 1); % Exemple: 'C:\Users\Josep TOSHIBA\Desktop' -to-> 'C:\Users\Josep TOSHIBA'
array_write_folder = ["Folder", split_arxiu_sortida];
write_text_josep(predefined_folder_input, array_write_folder, ";"); clear split_arxiu_sortida array_write_folder

%_Obtain directory name_
% Name of the input folder
nom_carpeta_input_cru = split(carpeta_input, "\");
nom_carpeta_input = nom_carpeta_input_cru{end}; clear nom_carpeta_input_cru




end