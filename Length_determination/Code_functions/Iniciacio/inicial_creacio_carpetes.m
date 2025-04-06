function inicial_creacio_carpetes(userSavedDocuments)

% Creació de les carpetes bàsiques i troncals en la iniciació primera del programa.
%
% _Variables_
% currentDir                  : Carpeta actual de sd'on s'executa el programa.
%                               En Archivos de programa si s'executa en
%                               Compilat, o en la carpeta del programa (on hi ha l'arxiu .m 
%                                pricipal).
%                               >>Sols es fa servir per a llegir arxius<<,
%                               Carpeta des d'on s'executa el programa.
% userSavedDocuments          : Carpeta on es guarden els resultats Results_out.
%                               Aquesta es guarda en Documentos si el
%                               programa és executable, i en la carpeta
%                               principal si s'executa des de MATLAB.


% INICI FUNCIÓ


    
    % CARPETA INICIAL CARPEAT PRINCIPAL RESULTATS
    if ~isfolder(strcat(userSavedDocuments, "\Results_out"))
        mkdir(strcat(userSavedDocuments, "\Results_out"))
    end
    
    % Creació de carpetes
    
    % Image processing settings 
    carpetes_fer = ["Image_processing_settings", "Image_processing_settings\temporals"]; % carpetes dins de "\Internal_code_files"
    if ~isfolder(strcat(userSavedDocuments, "\Results_out\Internal_code_files"))
        mkdir(strcat(userSavedDocuments, "\Results_out\Internal_code_files"))
        for cada_carpet = carpetes_fer
            mkdir(strcat(userSavedDocuments, "\Results_out\Internal_code_files\", cada_carpet))
        end
    end
    
    
    % OBTENCIÓ CARPETA I CREACIÓ CARPETES RESULTATS
    % Directori carpeta Internal_code_files
    dir_internal_code_files = strcat(userSavedDocuments, "\", "Results_out\Internal_code_files");
    dir_internal_code_files_imagefiles = strcat(dir_internal_code_files, "\", "Image_processing_settings");
    
    


% FINAL FUNCIÓ

end

