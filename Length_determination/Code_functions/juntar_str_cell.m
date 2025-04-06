function [sortida_cell] = juntar_str_cell(celltxt)

% Donat un array amb una o varies cells de strings, retorna una sola cell
% amb el string.
%
%
% See also
% write_normal_unicstr_josep
% llegir_text_delimitadors_normal

% INICI FUNCIO


len_cell = length(celltxt);

if len_cell > 1


    sortida_cell = string(celltxt{1});

    for cada_line = 2:len_cell
        
        %sortida_cell = strcat(sortida_cell, "\n", string(celltxt{cada_line}));
        sortida_cell = sortida_cell + newline + string(celltxt{cada_line});
    end
    
    sortida_cell = {sortida_cell};
 
else

    sortida_cell = celltxt;

end


% FINAL FUNCIÓ

end