function [complete_rute, indx_decisio] = determina_path_zip(predef_folder, predef_file)

% Determina la ruta de l'arxiu zip obrint un quadre de dialeg de generació
% de l'arxiu.
%
% Variables 
%   Input
%         predef_folder - carpeta predefinida. ex: "C:\Users\jllobet\Downloads"
%         predef_file - nom de l'arxiu predefinid. ex: "Josepfile"
%   Output
%       complete_rute - ruta completa.  'C:\Users\jllobet\Desktop\Josepfile.zip'
%       indx_decisio - true/false en funció si s'ha executat o no correctament.



% INICI FUNICÓ


%     filter = {'*.zip';'*.rar'};
    filter = {'*.zip'};

    [file_export, path_export, indx_decisio_t] = uiputfile(filter, "Save the file", strcat(predef_folder, "\", predef_file, '.zip'));
    complete_rute = strcat(path_export, file_export);
    
    % indx_decisio_t : és 1 si es determina un nom, sigui sobreescrit
    %                o no, i és 0 si s'ha cancelat.
    
    indx_decisio = logical(indx_decisio_t);


% FINAL FUNCIÓ

end