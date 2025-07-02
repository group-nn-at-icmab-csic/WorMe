function [string_file, string_final] = separar_puntfile(string1)

%
% Returns the parts of a document name as an archive name in a string
% 
% example:
% asdf.jpg -> "asdf" ".jpg"
% string1 = "asdf.jpg"
%
% See also:
% separar_file_carpeta

if contains(string1, ".")
    splited_string1 = split(string1, ".");
    string_file = splited_string1{1};
    string_final = strcat(".", splited_string1{2});
end




end