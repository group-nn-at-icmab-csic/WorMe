function [string_file, string_folder, string_folder_file] = divide_file_folder(string1)

% Donada la ruta d'una imatge, retorna el nom de l'arxiu, la carpeta
% precedent, i ambdós junts.%
% 
% ruta_img = "2023_01_03_Generar_PascalVOC\Anotacio exemple 2\Image_961.jpg"
%
% string_file = 'Image_961.jpg'
% string_folder = 'Anotacio exemple 2'
% string_folder_file = "Anotacio exemple 2\Image_961.jpg"
%
%
% See also
% divide_pointfile

% START FUNCTION

    if contains(string1, "\")
        splited_string1 = split(string1, "\");
        string_file = splited_string1{end};
        string_folder = splited_string1{end-1};
    end
    
    
    % string_file % nom arxiu
    % string_folder % nom carpeta
    string_folder_file = strcat(string_folder, "\", string_file); % Nom carpeta + nom arxiu



% END FUNCTION

end
