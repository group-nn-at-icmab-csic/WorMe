% WorMe_length_determination_v2_17
disp("WorMe_length_determination_v2_17")

% Developed in MATLAB 2021b version

% v.2.17: integration of selected worms counter.

% _____ VARIABLES PRINCIPALS ____
% userSavedDocuments - carpeta ruta programari (en MATALB o compilat)
%                   ex (using MATLAB):  'C:\Users\jllobet\Desktop\Length determination v2_16'
%                   ex (compiled in Windows): 'C:\Users\Josep TOSHIBA\Documents\WorMe_Length_Results'
%
% carpeta_output - ruta resultats
%                   ex (using MATLAB):  "C:\Users\jllobet\Desktop\Length determination v2_15\Results_out\20230124_1625_C_48"
%                   ex (compiled in Windows): 'C:\Users\Josep TOSHIBA\Documents\WorMe_Length_Results Results_out\20230407_1813_control'


% ___ Internes ____ %
%   theFiles : Estructura de dades de les imatges (name, folder, date, ...). Utilitari per a l'obtenció de les imatges.



% ------------------------------------------
% ______________INICI PROGRAMA______________
% ------------------------------------------


% _Temporització total programa_ 
temps_inicial = datetime("now");


% Contador temps
%Control temps 1
data_time_1 = datetime("now");



% _______DETERMINACIO PATH I CARPETES_______

% ___Determinació path___
[userSavedDocuments] = determinacio_path();

% ___Creació carpetes inicial___
inicial_creacio_carpetes(userSavedDocuments)



% _____APP INICIACIÓ PROGRAMA_____ 
% waitfor(app_iniciacio_program(userSavedDocuments))


% ___OBTENCIÓ CARPETA IMATGES ORIGINALS___
% [theFiles, carpeta_input, nom_carpeta_input, porta_f] = obtencio_theFiles_dir(userSavedDocuments);    
% myFolder = carpeta_input;
[theFiles, carpeta_input, nom_carpeta_input, porta_f] = obtencio_theFiles_img(userSavedDocuments);


% Si la selecció és correcte:
if porta_f
    
    % ___CREACÓ CARPETA RESULTATS___
    % Crea la carpeta de resultats.
    [carpeta_output] = creacio_carpeta_resultats(userSavedDocuments, nom_carpeta_input);   
    
    % __Determinació escala__
    [escala_imatge] = determinacio_escala_main(userSavedDocuments, theFiles, carpeta_output);
    
    
    % __Processament de la imatge___ 
    waitfor(app_processament_imatge_autoreflow(theFiles, carpeta_output))
    
    % ___Selecció imatges___
    % Es seleccionene les imatges
    waitfor(app_nova_interfaz_nova_funcions(theFiles, carpeta_output, escala_imatge))
                                % Carpeta imatges , carpeta resultats, escala
                                       
    % Variables
    % carpeta_output : carpeta resultats
    %                   ex: ...\Results_out\20221005_Poques
    % myFolder : Carpeta origen imatges

end






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



