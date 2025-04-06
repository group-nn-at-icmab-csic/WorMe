function [numcell] = strcell2numcell_josep(stringcell)


% Passa d'una cell amb un array de valors en string, a cell amb un array en
% valors numèrics.
%
% Variables:
%
% stringcell : cell amb un array on hi ha un string separat per comes
% (típic de textscan).
% 
%
% Exemple input:
% {'56,45,546,456,456,456,45,645,645,6456,456,45,645,645,64,56,45,64,5645,645645645645,6456456456,45645,6456456,456,456,45,64,564'            }
%     {'56,45,546,456,456,456,45,645,645,6456,456,45,645,645,64,56,45,64,5645,645645645645,6456456456,45645,6456456,456,456,45,64,564'            }
%     {'56,45,546,456,456,456,45,645,645,6456,456,45,645,645,64,56,45,64,5645,645645645645,6456456456,45645,6456456,456,456,45,64,564'            }
%     {'56,45,546,456,456,456,45,645,645,6456,456,45,645,645,64,56,45,64,5645,645645645645,6456456456,45645,6456456,456,456,45,64,564'            }
%     {'56,45,546,456,456,456,45,645,645,6456,456,45,645,645,64,56,45,64,5645,645645645645,6456456456,45645,6456456,456,456,45,64,564'            }
%
%
% Temps processament
% Elapsed time is 0.007262 seconds.


numcell = {};
for cada_v = 1:length(stringcell)
    numcell{end+1} = str2num(stringcell{cada_v});
end

numcell = numcell';


end


