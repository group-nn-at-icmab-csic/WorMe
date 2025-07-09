function [split_arxiu_sortida] = splits_objectes_valor(string_to_split, delimitador, valors_restants)

% Given a string and a delimiter, the delimiter is separated and the string obtained.
% It takes away however many delimiters as specified ('valors_restants'). 
%
% It is useful to pre-separate folders in a path.
%
% Example:
%
% 'C:\Users\Josep TOSHIBA\Desktop'
%
% to
%
% 'C:\Users'
%
% The function does:
%
% valors_restants = 1;
% string_to_split = 'C:\Users\Josep TOSHIBA\Desktop\Length determination v2_4\_Extern\Imatges exemple\Input_images_Amanda_poques';
% delimitador = "\";
% [split_arxiu_sortida] = splits_objectes_valor(string_to_split, delimitador, valors_restants)
%
%
% See also:
% divide_pointfile

% Split file:
split_arxiu = strsplit(string_to_split, delimitador);

split_arxiu_nou = {};
%[nfila, ~, ~] = size(split_arxiu)

% If the value is surpassed
if valors_restants > length(split_arxiu)
    valors_restants = length(split_arxiu)-1;
end

% We obtain the new path without the last or multiple last values (according to valors_restants)
for cada_split = 1:length(split_arxiu) - valors_restants
    split_arxiu_nou{end+1} = split_arxiu{cada_split};    
end

split_arxiu_sortida_prov = join(split_arxiu_nou, "\");
split_arxiu_sortida = split_arxiu_sortida_prov{1};


end