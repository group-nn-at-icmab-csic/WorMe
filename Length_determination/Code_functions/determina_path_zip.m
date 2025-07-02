function [complete_rute, indx_decisio] = determina_path_zip(predef_folder, predef_file)

% Determines the path of the zip file by opening a dialog box to generate
% the file.
%
% Variables
%   Input
%         predef_folder - predefined folder. e.g.: "C:\Users\jllobet\Downloads"
%         predef_file - predefined file name. e.g.: "Josepfile"
%   Output
%       complete_rute - full path. 'C:\Users\jllobet\Desktop\Josepfile.zip'
%       indx_decisio - true/false depending on whether it executed successfully or not.

% START OF FUNCTION



%     filter = {'*.zip';'*.rar'};
    filter = {'*.zip'};

    [file_export, path_export, indx_decisio_t] = uiputfile(filter, "Save the file", strcat(predef_folder, "\", predef_file, '.zip'));
    complete_rute = strcat(path_export, file_export);

    % indx_decisio_t : is 1 if a name is determined, whether overwritten
    %                  or not, and is 0 if canceled.

    indx_decisio = logical(indx_decisio_t);


% FINAL OF FUNCTION

end