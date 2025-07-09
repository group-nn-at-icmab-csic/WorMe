function [theFiles, carpeta_input, nom_carpeta_input, porta_f] = obtain_theFiles_img(userSavedDocuments)
% Selects the images and obtains the theFiles and the folder paths.
% Like obtain_theFiles_dir but the images are selected.
% Variables
%   input
%       userSavedDocuments - current path route.
%                       e.g.:  'C:\Users\jllobet\Desktop\Length determination v2_15'
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
% 
% See also
% obtain_theFiles_dir



% START FUNCTION

% Explanatory box (up to 7 times)

msgbox_sel_images(userSavedDocuments)

% ___OBTAINING ORIGINAL IMAGES FOLDER___
% v'predef_folder_carpeta'  : predefined folder for starting the search.
% v'carpeta_input'          : directory of the original images.
% v'nom_carpeta_input'      : name of the directory of the original images
%
% _Obtaining (or not) value of the predefined folder
% It is obtained from "Results_out\Internal_code_files\predefined_folder.txt"

predefined_folder_input = strcat(userSavedDocuments, "\Results_out\Internal_code_files", "\predefined_folder.txt");

if isfile(predefined_folder_input)
    % If a text file exists that contains the scale
    predef_folder_llegida = read_text_delimiters(predefined_folder_input, ";");
    predef_folder_carpeta = predef_folder_llegida{2}; clear predef_folder_llegida  % the predefined folder is defined
else
    % If there is no defined scale, it is saved without a value.
    predef_folder_carpeta = '';
end


% Image obtaintion
[filename, pathname] = uigetfile({['*.jpg;*.png;*.jpeg;*.tif;*.tiff;*.jfif;*.bmp']; '*.jpg'; '*.png'; '*.jpeg'; '*.tif'; '*.tiff'; '*.jfif'; '*.bmp'; '*.*'}, "Select the images", predef_folder_carpeta, 'MultiSelect','on');
% pathname :    'C:\Users\jllobet\Desktop\Length determination v2_15\_Imatges exemple\Amanda_Controls_poques\C_48\'
% filename :  {'Image_961.jpg'}    {'Image_970.jpg'}    {'Image_973.jpg'}
% Note: if there is no selection, and the box fails, both pathname and filename are 0.


% If there is selection
if ~isequal(filename, 0)


    %_Obtaintion of directory name_
    % Name of the entry folder
    nom_carpeta_input_cru = split(pathname, "\");
    nom_carpeta_input = nom_carpeta_input_cru{end-1};

    if isequal(pathname(end), "\")
        carpeta_input = pathname(1:end-1);
    else
        error("Error in notation of the folder")
    end


    % __Obtaining the directories___
    % Save the directories
    [split_arxiu_sortida] = splits_objectes_valor(carpeta_input, "\", 1); % Example: 'C:\Users\Josep TOSHIBA\Desktop' -to-> 'C:\Users\Josep TOSHIBA'
    array_write_folder = ["Folder", split_arxiu_sortida];
    write_text_array(predefined_folder_input, array_write_folder, ";"); clear split_arxiu_sortida array_write_folder
    


    % __Obtaining of theFiles__
    arxius_directoris = strcat(pathname, filename);
    % For every pattern
    for n_filep = 1:length(arxius_directoris)
            
%         disp('arxius_directoris')
%         arxius_directoris
%         class(arxius_directoris)
%         length(arxius_directoris)
%         numel(arxius_directoris)
        
        % Obtaining of the pattern structure
        % If there is just one selected image
        if ischar(arxius_directoris)
            struct_fileP = dir(arxius_directoris);
        % If there is many selected images
        else
            struct_fileP = dir(arxius_directoris{n_filep});
        end
    
        if n_filep == 1
            theFiles = struct_fileP;
        else
                if isempty(theFiles)
                    % If theFiles file is eight (no previous images of this type were obtained).
                    theFiles = struct_fileP;
                else
                    % Structures are joined
                    theFiles = cell2struct([struct2cell(theFiles),struct2cell(struct_fileP)],fieldnames(theFiles),1);
                end
            
        end
    
    end

    % If theFiles is eight:
    if isempty(theFiles)
        errordlg('There is no images on the selected folder');
        porta_f = false;
    else
        porta_f = true;
    end


else
    % If there are errors in the uigetfile

    theFiles = [];
    carpeta_input = false; 
    nom_carpeta_input = false; 
    porta_f = false;

end




% FINAL OF THE FUNCTION

end