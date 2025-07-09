function [array_processaments] = obtain_array_processments(field_set)

% Forma resumida per a obtenir l'array amb els processaments, per a
% aplicar-lo.
%
% Exemple: field_set = strcat("Apps\app_image_processment\Internal code files\Image processing settings\", string(value));

% obtneim l'array de la lectura del document de text i el printem
[array_sortida_modifs, ~] = read_text_delimiters(field_set, ";");
cell_cont = array_sortida_modifs(2:end, 2);
array_processaments = cell2array_own(cell_cont);


end