function [S_textscan_table_filtred_drawline, taula_dibuix_filted_nonproc] = app_interf_select_drawline(app)

% Given the drawline table and the general data table, a selection of data
% is performed based on whether they are present in one or the other.
% This allows keeping track of which elements have been processed
% and which have not.
%
%
%   Variables
%       output:
%           taula_dibuix_filted_nonproc :
%               data table of draw, excluding the values that have been manually selected.
%
%           S_textscan_table_filtred_drawline :
%               main table with filtered drawline values.
%
%


% START FUNCTION

% _Main data table_
% Obtain main data table
[S_textscan_table] = app_interf_lectura_Stable(app);


% Filter by name
S_textscan_table_filtred = S_textscan_table(S_textscan_table.NomWorm == app.img_original_nomLabel.Text, :);


% Filter the table for draw values:
S_textscan_table_filtred_drawline = S_textscan_table_filtred(S_textscan_table_filtred.Modifs == "DrawLine", :);
% Here there should be the draw lines that have been
% selected and saved. These will now be removed from the main table. They are duplicated.



% _Draw table_
taula_dibuix = app.taula_draw_main;

if ~isempty(taula_dibuix)
    % Filter by name
    taula_dibuix_filted = taula_dibuix(taula_dibuix.NomWorm == app.img_original_nomLabel.Text, :);
    
    % Draw table to be reduced
    taula_dibuix_filted_t = taula_dibuix_filted;

    if ~isempty(S_textscan_table_filtred_drawline)

        % Filter by processed indices:
        taula_dibuix_filted_nonproc = taula_dibuix_filted(~ismember(taula_dibuix_filted.Indx_skel, S_textscan_table_filtred_drawline.Indx_skel), :);

    else
        taula_dibuix_filted_nonproc = taula_dibuix_filted;
    end
else
    % disp("Isemptyy")
    taula_dibuix_filted_nonproc = [];
end


% END FUNCTION



end