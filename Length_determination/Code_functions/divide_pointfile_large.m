function [string_file, string_final] = divide_pointfile_large(string1)

%
% returns the parts of a document name with filename
% ex: asdf.jpg -> "asdf" ".jpg"
%
%string1 = "asdf.jpg"

disp("Separar puntfile new")

% Improved:
if contains(string1, ".")
    splited_string1 = split(string1, ".");
    string_file = strjoin(splited_string1(1:end-1),".");
    string_final = strcat(".", splited_string1{end});
end



end