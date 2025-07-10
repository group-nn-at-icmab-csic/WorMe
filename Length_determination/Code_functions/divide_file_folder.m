function [string_file, string_folder, string_folder_file] = divide_file_folder(string1)

% Given the path of an image, return the file name, the preceding folder
%, and both together.%
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
    
    
    % string_file % name file
    % string_folder % name folder
    string_folder_file = strcat(string_folder, "\", string_file); % name folder + name file



% END FUNCTION

end
