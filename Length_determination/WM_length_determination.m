% WorMe_length_determination_v2_17
disp("WorMe_length_determination_v2_17")

% Developed in MATLAB 2021b version

% v.2.17: integration of selected worms counter + grayscale image reading.

% _____ PRINCIPAL VARIABLES ____
% userSavedDocuments - directory of the program (in MATALB o compiled)
%                   ex (using MATLAB):  'C:\Users\jllobet\Desktop\Length determination v2_16'
%                   ex (compiled in Windows): 'C:\Users\Josep TOSHIBA\Documents\WorMe_Length_Results'
%
% carpeta_output - directory of res
% ults
%                   ex (using MATLAB):  "C:\Users\jllobet\Desktop\Length determination v2_15\Results_out\20230124_1625_C_48"
%                   ex (compiled in Windows): 'C:\Users\Josep TOSHIBA\Documents\WorMe_Length_Results Results_out\20230407_1813_control'
%
% theFiles : Data structure of the images (name, folder, date, ...). Utility for obtaining images.



% ------------------------------------------------
% ______________START OF THE PROGRAM______________
% ------------------------------------------------


% __Determination of paths and folders__

% _Path determination_
[userSavedDocuments] = path_determination(); % local function

% _Initial folder creation_
initial_folder_creation(userSavedDocuments)

% _Botation of the initial image folder_
[theFiles, carpeta_input, nom_carpeta_input, porta_f] = obtain_theFiles_img(userSavedDocuments);


% If the selection is correct:
if porta_f
    
    % _Creation of results folder_
    % Create the results folder.
    [carpeta_output] = results_folder_create(userSavedDocuments, nom_carpeta_input);   
    
    % ___Scale determination (App)___
    [escala_imatge] = scale_determination_main(userSavedDocuments, theFiles, carpeta_output);
    
    % ___Processment of the image (App)___ 
    waitfor(app_image_processment(theFiles, carpeta_output))
    
    % ___Worm selection (App)___
    waitfor(app_selection_pannel(theFiles, carpeta_output, escala_imatge))

end


% -------------------------------------------------
% ______________FINAL OF THE PROGRAM ______________
% -------------------------------------------------













% __Local functions__


% Note: Not to move the function path_determination from local main script.

function [userSavedDocuments] = path_determination()
% Automatically determines the path.
%
% Note: This function requires being in the main script.

% START OF THE FUNCTION
    
    
    % ___PATH DETERMINATION___
    
    % -_modificacio_executable: The entire try and catch of addpath is inhibited (%).
    
    % %_Folders_%  
    % userSavedDocuments :  
    %           e.g. execution in MATLAB: 'C:\Users\jllobet\Desktop\Length determination v2_12new'
    %           e.g. execution in .exe: C\:Users\jllobet\Documents\WorMe_Length_Results
    % currentDir         : 
    %           e.g. execution in MATLAB: 'C:\Users\jllobet\Desktop\Length determination v2_12new'
    %           e.g. execution in .exe: 'C:\Users\jllobet\Desktop\Length determination v2_12new\Compilacio\WM_length_determinationv212\for_testing'

    
    
    % If execute the software instal·led (from .exe, from compiled file)
    if isdeployed % Stand-alone mode.(Runtime)
        [status, result] = system('path');
        currentDir = char(regexpi(result, 'Path=(.*?);', 'tokens', 'once'));
        
        % Obtain the directory where we save the files:
        userProfile = getenv('USERPROFILE');
        userDocuments = strcat(userProfile, "\Documents");
        
        % Create the folder for to save the results:
        if ~isfolder(userDocuments)
            waitfor(msgbox({"Error Documents: Folder:", userDocuments, "doesn't defined."}, 'Error','error'));
            waitfor(msgbox("Please, define a new folder for save the program results."));
            userSavedDocuments = uigetdir(predef_folder_carpeta, "Select the folder with images");
            
        % If Documents exists, we create the folder where the results are going to be saved:
        else
            userSavedDocuments = strcat(userDocuments, "\WorMe_Length_Results");
            mkdir(userSavedDocuments)
            %waitfor(msgbox(userSavedDocuments))
        end
    
        % Change the directory of the actual folder:
        cd(userSavedDocuments)
        
        
    % If we execute from MATLAB Desktop (from code):
    else % MATLAB mode.
        try
            % Determine the current path from where the current MATLAB script is being used.
            path_actual = matlab.desktop.editor.getActiveFilename; % Path de l'arxiu actual obert de MATLAB.
            % fprintf('%s\n',path_actual);
            ultim_barra = strfind(path_actual, "\");
            index_ultim_barra = ultim_barra(numel(ultim_barra)) -1 ;
            path_actual = path_actual(1:index_ultim_barra); clear index_ultim_barra ultim_barra;
    
            addpath(genpath(path_actual));
            cd(path_actual);
            pwd;
            cd;
    
            clear ultim_barra index_ultim_barra
    
        catch
    
            addpath(genpath(pwd));
            cd(pwd);
            pwd;
            cd;
    
        end
    
        % Folders are defined as the current program.
        currentDir = pwd;
        userSavedDocuments = pwd;
    
        % __Package determination___
        % Determine if there is installed the packages necessary for the program (Image Processing, etc.)
        determine_packages()    
    end

% FINAL OF THE FUNCTION

end



