function [userSavedDocuments] = determinacio_path()

% Determina el path

% INICI FUNCIO


% ___DETERMINACIÓ PATH___

% -_modificacio_executable: S'inhibeix (%) tot el try i catch del addpath.

% %_Carpetes_%
% userSavedDocuments :  
%           ex execució en MATLAB: 'C:\Users\jllobet\Desktop\Length determination v2_12new'
%           ex execució en .exe: C\:Users\jllobet\Documents\WorMe_Length_Results
% currentDir         : 
%           ex execució en MATLAB: 'C:\Users\jllobet\Desktop\Length determination v2_12new'
%           ex execució en .exe: 'C:\Users\jllobet\Desktop\Length determination v2_12new\Compilacio\WM_length_determinationv212\for_testing'


% SI s'executa en programa instal·lat
if isdeployed % Stand-alone mode.(Runtime)
    [status, result] = system('path');
    currentDir = char(regexpi(result, 'Path=(.*?);', 'tokens', 'once'));
    
    % Obtenim el directori on guardarem els arxius:
    userProfile = getenv('USERPROFILE');
    userDocuments = strcat(userProfile, "\Documents");
    
    % Creem una carpeta per a guardar els resultats
    if ~isfolder(userDocuments)
        waitfor(msgbox({"Error Documents: Folder:", userDocuments, "doesn't defined."}, 'Error','error'));
        waitfor(msgbox("Please, define a new folder for save the program results."));
        userSavedDocuments = uigetdir(predef_folder_carpeta, "Select the folder with images");
        
    % Si existeix la carpeta Documentos, es crea la carpeta on es guardaràn els resultats.
    else
        userSavedDocuments = strcat(userDocuments, "\WorMe_Length_Results");
        mkdir(userSavedDocuments)
        %waitfor(msgbox(userSavedDocuments))
    end

    % Cambiem el directori de la carpeta actual:
    cd(userSavedDocuments)
    
    
% Si s'executa en MATLAB
else % MATLAB mode.
    try
        % Determinem path actual des d'on s'està fent servir el present escript de MATLAB.
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

    % Les carpetes es defineixen com la corrent del programa.
    currentDir = pwd;
    userSavedDocuments = pwd;

    
    % __Determinació paquets___
    % Determina si hi ha instalats determinats paquest (Image Processing, etc.)
    determinacio_paquets()


end
 


% FINAL FUNCIO

end