function [string_file, string_final] = divide_pointfile(string1)

%
% Returns the parts of a document name as an archive name in a string
% 
% example:
% asdf.jpg -> "asdf" ".jpg"
% string1 = "asdf.jpg"
%
% See also:
% divide_file_folder

disp("Separar puntfile normal")

if contains(string1, ".")
    splited_string1 = split(string1, ".");
    string_file = splited_string1{1};
    string_final = strcat(".", splited_string1{2});
end




end