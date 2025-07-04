function initial_folder_creation(userSavedDocuments)
% Creation of the basic and main folders during the first initialization of the program.
%
% _Variables_
% currentDir                  : Current folder from where the program is executed.
%                               In Program Files if running as
%                               compiled, or in the program folder (where the main .m file
%                               is located).
%                               >>Used only for reading files<<,
%                               Folder from where the program is executed.
% userSavedDocuments          : Folder where the Results_out results are saved.
%                               This is stored in Documents if the
%                               program is executable, and in the main folder if running from MATLAB.

% START OF THE FUNCTION

    % INITIAL FOLDER MAIN RESULTS FOLDER
    if ~isfolder(strcat(userSavedDocuments, "\Results_out"))
        mkdir(strcat(userSavedDocuments, "\Results_out"))
    end
    
    % Folder creation
    
    % Image processing settings 
    carpetes_fer = ["Image_processing_settings", "Image_processing_settings\temporals"]; % Folders inside "\Internal_code_files"
    if ~isfolder(strcat(userSavedDocuments, "\Results_out\Internal_code_files"))
        mkdir(strcat(userSavedDocuments, "\Results_out\Internal_code_files"))
        for cada_carpet = carpetes_fer
            mkdir(strcat(userSavedDocuments, "\Results_out\Internal_code_files\", cada_carpet))
        end
    end
    
    
    % OBTAINING FOLDER AND CREATION OF RESULTS FOLDERS
    % Directory of folder Internal_code_files
    dir_internal_code_files = strcat(userSavedDocuments, "\", "Results_out\Internal_code_files");
    dir_internal_code_files_imagefiles = strcat(dir_internal_code_files, "\", "Image_processing_settings");
    
    


% FINAL OF THE FUNCTION

end

