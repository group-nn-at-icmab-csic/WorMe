function [split_arxiu_sortida] = splits_objectes_valor(string_to_split, delimitador, valors_restants)

% Donada un string, i un delimitador, es separa aquest, i s'obté el string
% resultant de les posicions endarrerides que es vulgui (v'valors_restants') d'aquest. 
%
% Serveix sobretot per a pre-separar carpetes.
%
% exemple:
%
% 'C:\Users\Josep TOSHIBA\Desktop'
%
%  to
%
% 'C:\Users'
%
% Exemple funció
%
% valors_restants = 1;
% string_to_split = 'C:\Users\Josep TOSHIBA\Desktop\Length determination v2_4\_Extern\Imatges exemple\Input_images_Amanda_poques';
% delimitador = "\";
% [split_arxiu_sortida] = splits_objectes_valor(string_to_split, delimitador, valors_restants)
%
%
% See also
% separar_puntfile

% Split arxiu
split_arxiu = strsplit(string_to_split, delimitador);

split_arxiu_nou = {};
%[nfila, ~, ~] = size(split_arxiu)

% Si es sobrepassa el valor
if valors_restants > length(split_arxiu)
    valors_restants = length(split_arxiu)-1;
end

% Obtenim la nova cell sense l'últim o últims valors (segons valors_restants)
for cada_split = 1:length(split_arxiu) - valors_restants
    split_arxiu_nou{end+1} = split_arxiu{cada_split};    
end

split_arxiu_sortida_prov = join(split_arxiu_nou, "\");
split_arxiu_sortida = split_arxiu_sortida_prov{1};


end