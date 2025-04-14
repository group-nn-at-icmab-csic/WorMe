function [carpeta_input, nom_carpeta_input] = troncal_obtencio_dir_originals(userSavedDocuments)

% ___OBTENCIÓ CARPETA IMATGES ORIGINALS___
% v'predef_folder_carpeta'  : carpeta predefinida d'inici de cerca.
% v'carpeta_input'          : directori de les imatges originals.
% v'nom_carpeta_input'      : nom del directori de les imatges originals
%
% _Obtenció (o no) valor de la carpeat predefinit
% S'obté de "Results_out\Internal_code_files\predefined_folder.txt"
predefined_folder_input = strcat(userSavedDocuments, "\Results_out\Internal_code_files", "\predefined_folder.txt");

if isfile(predefined_folder_input)
    % Si existeix un arxiu de text que contingui l'escala
    predef_folder_llegida = llegir_text_delimitadors(predefined_folder_input, ";");
    predef_folder_carpeta = predef_folder_llegida{2}; clear predef_folder_llegida  % es defineix la carpeat predefinida
else
    % Si no existeix una escala definida, es guarda sense valor.
    predef_folder_carpeta = '';
end

% __Obtenció carpeta__
% Carpeta entrada
carpeta_input = uigetdir(predef_folder_carpeta, "Select the folder with images");

% _Write carpeta predefinida_
% Obtenim la mateixa string de la carpeta, definit una carpeta anterior a la última definida.
[split_arxiu_sortida] = splits_objectes_valor(carpeta_input, "\", 1); % Exemple: 'C:\Users\Josep TOSHIBA\Desktop' -to-> 'C:\Users\Josep TOSHIBA'
array_write_folder = ["Folder", split_arxiu_sortida];
write_text_josep(predefined_folder_input, array_write_folder, ";"); clear split_arxiu_sortida array_write_folder

%_Obtenim nom del directori_
% Nom de la carpeta d'entrada
nom_carpeta_input_cru = split(carpeta_input, "\");
nom_carpeta_input = nom_carpeta_input_cru{end}; clear nom_carpeta_input_cru




end