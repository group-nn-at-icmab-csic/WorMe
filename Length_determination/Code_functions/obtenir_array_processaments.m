function [array_processaments] = obtenir_array_processaments(field_set)

% Forma resumida per a obtenir l'array amb els processaments, per a
% aplicar-lo.
%
% Exemple: field_set = strcat("Apps\app_processament_imatge\Internal code files\Image processing settings\", string(value));

% obtneim l'array de la lectura del document de text i el printem
[array_sortida_modifs, ~] = llegir_text_delimitadors(field_set, ";");
cell_cont = array_sortida_modifs(2:end, 2);
array_processaments = cell2array_josep(cell_cont);


end