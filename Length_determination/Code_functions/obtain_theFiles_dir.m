function [theFiles, carpeta_input, nom_carpeta_input, porta_f] = obtain_theFiles_dir(userSavedDocuments)
% Obtains the file theFiles of the images, as well as the path of the selected folder,
% based on the folder description.
%
% Variables
%   input
%       userSavedDocuments - current path route.
%                       e.g.:  'C:\Users\jllobet\Desktop\Length determination v2_15'
%
%   output
%       theFiles - Structure describing images. dir() file of the images
%
%       carpeta_input - path to the images folder
%                       e.g.: 'C:\Users\jllobet\Desktop\Length determination v2_15\_Imatges exemple\Amanda_Controls\C_48'
%
%       nom_carpeta_input - name of the images folder
%                       e.g.: 'C_48'
%
%       porta_f - returns whether processing is correct (true/false)
%
% See also
% obtain_theFiles_img



% START FUNCTION



% ___OBTAINING ORIGINAL IMAGES FOLDER___
% v'predef_folder_carpeta'  : predefined folder for search start.
% v'carpeta_input'          : directory of the original images.
% v'nom_carpeta_input'      : name of the directory of the original images
%
% _Obtaining (or not) value of the predefined folder
% It is obtained from "Results_out\Internal_code_files\predefined_folder.txt"

predefined_folder_input = strcat(userSavedDocuments, "\Results_out\Internal_code_files", "\predefined_folder.txt");

if isfile(predefined_folder_input)
    % If a text file exists that contains the scale
    predef_folder_llegida = read_text_delimiters(predefined_folder_input, ";");
    predef_folder_carpeta = predef_folder_llegida{2}; clear predef_folder_llegida  % es defineix la carpeat predefinida
else
    % If there is no defined scale, it is saved without a value.
    predef_folder_carpeta = '';
end

% __Folder obtaintion__
% Entry folder
carpeta_input = uigetdir(predef_folder_carpeta, "Select the folder with images");


if ~isequal(carpeta_input, 0)
    % _Write predefined folder_
    % We obtain the same string from the folder, defined a folder previous to the last one defined.
    [split_arxiu_sortida] = splits_objectes_valor(carpeta_input, "\", 1); % Exemple: 'C:\Users\Josep TOSHIBA\Desktop' -to-> 'C:\Users\Josep TOSHIBA'
    array_write_folder = ["Folder", split_arxiu_sortida];
    write_text_array(predefined_folder_input, array_write_folder, ";"); clear split_arxiu_sortida array_write_folder
    
    %_Obtain the directory name_
    % Name of the entry folder
    nom_carpeta_input_cru = split(carpeta_input, "\");
    nom_carpeta_input = nom_carpeta_input_cru{end}; clear nom_carpeta_input_cru

    
    myFolder = carpeta_input;
    
    % IMAGES LECTURE .jpg and .png of the folder:
    [theFiles] = read_imgs_folder_structure(myFolder);  %Elapsed time is 0.005087 seconds
    
    if isempty(theFiles)
        errordlg('There is no images on the selected folder');
        % error("No images on the selected folder")

        porta_f = false;
    else
        porta_f = true;
    end

else
    % If there is errors in the uigetdir

    theFiles = [];
    carpeta_input = false; 
    nom_carpeta_input = false; 
    porta_f = false;

end



end