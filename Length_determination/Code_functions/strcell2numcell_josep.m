function [numcell] = strcell2numcell_josep(stringcell)


% Goes from a cell with an array of strings to a cell with an array of numeric values.
%
% Variables:
%
% stringcell : cell with an array with comma separated string values
% (typical from textscan).
% 
%
% Example input:
% {'56,45,546,456,456,456,45,645,645,6456,456,45,645,645,64,56,45,64,5645,645645645645,6456456456,45645,6456456,456,456,45,64,564'            }
% {'56,45,546,456,456,456,45,645,645,6456,456,45,645,645,64,56,45,64,5645,645645645645,6456456456,45645,6456456,456,456,45,64,564'            }
% {'56,45,546,456,456,456,45,645,645,6456,456,45,645,645,64,56,45,64,5645,645645645645,6456456456,45645,6456456,456,456,45,64,564'            }
% {'56,45,546,456,456,456,45,645,645,6456,456,45,645,645,64,56,45,64,5645,645645645645,6456456456,45645,6456456,456,456,45,64,564'            }
% {'56,45,546,456,456,456,45,645,645,6456,456,45,645,645,64,56,45,64,5645,645645645645,6456456456,45645,6456456,456,456,45,64,564'            }
%
%
% Processing time:
% Elapsed time is 0.007262 seconds.


numcell = {};
for cada_v = 1:length(stringcell)
    numcell{end+1} = str2num(stringcell{cada_v});
end

numcell = numcell';


end


