function write_dades_cell(txt_data_name, cell_dades_totals, write_values, separador_char)

% Saves the data of a cell, so that the f'llegir_dades' function can be 
% used later to read these in table format.
%
%
% Variables:
% txt_data_name : directory and file name.
%           example: "Results\main_results_josep.txt"
%
% cell_dades_totals : cell with the data
%
% write_values ​​: fprint code that must be entered.
%           example: "%s%s%.3f%s%s%s%s%s" in a cell with 7 values.
%
% separador_char: separator that the values ​​of each cell will have
%           example: "$"
%
% See also:
% llegir_dades
% app_interf_llegir_main_dades
% appf_split_strindex

% START FUNCTION


% _printf the pre process characters_
[C_str] = strsplit(write_values, "%");
write_values = strcat("%", strjoin(C_str(2:end), strcat(separador_char, "%") ));

% __Write from the file__
if ~isfile(txt_data_name)
    % disp("New file")
    % No space at the beginning.
    fid = fopen(txt_data_name,'a+');
    fprintf(fid, write_values, cell_dades_totals{:});
    fclose(fid);    
else
    % disp("Existing file")
    fid = fopen(txt_data_name,'a+');
    fprintf(fid, strcat("\n", write_values), cell_dades_totals{:});
    fclose(fid);    
end



% END FUNCTION


end