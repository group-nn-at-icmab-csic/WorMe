function [S_textscan_table_row_main] = consol_S_textscan_modifs(BW_final_2, isceleg, nomworm, modifs_string)

% Attach the generated table to

% START FUNCTION

    % Create the main of data:
    [BW_final_lab, n_bwlab] = bwlabel(BW_final_2);

    S_textscan_table_row_main = [];
    for n_bw = 1:n_bwlab

        [S_textscan_table_row, variables_noms] = create_S_textscan_modifs(BW_final_lab == n_bw, isceleg, nomworm, modifs_string);

        if isempty(S_textscan_table_row_main)
            S_textscan_table_row_main = S_textscan_table_row;
        else
            S_textscan_table_row_main = [S_textscan_table_row_main; S_textscan_table_row ];
        end
    end



% END FUNCTION


end