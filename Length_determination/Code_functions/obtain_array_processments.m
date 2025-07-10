function [array_processaments] = obtain_array_processments(field_set)

% Summary form to obtain the array with the processing, to
% apply it.
%
% Exemple: field_set = strcat("Apps\app_image_processment\Internal code files\Image processing settings\", string(value));

% we obtain the array from reading the text document and print it
[array_sortida_modifs, ~] = read_text_delimiters(field_set, ";");
cell_cont = array_sortida_modifs(2:end, 2);
array_processaments = cell2array_own(cell_cont);


end