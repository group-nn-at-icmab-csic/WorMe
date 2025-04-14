function [S_textscan_table_filtred_drawline, taula_dibuix_filted_nonproc] = app_interf_select_drawline(app)

% Donada la taula de drawline i la taula general de dades, es fa una
% selecció de les dades en funció a si són presents en una banda u altre.
% D'aquesta manera es permèt tenir consideració de quins elements s'han
% processat i quins no.
%
%
%   Variables
%       output:
%           taula_dibuix_filted_nonproc : 
%               taula dades de draw, sense els valors que han sigut seleccionats manualment.
%
%           S_textscan_table_filtred_drawline :
%               taula main amb els valors filtrats de drawline.
%
%


% INICI FUNCIÓ

% _Taula main dades_
% Obtenim taula principal de dades
[S_textscan_table] = app_interf_lectura_Stable(app);


% Filtrem per nom
S_textscan_table_filtred = S_textscan_table(S_textscan_table.NomWorm == app.img_original_nomLabel.Text, :);


% Filtrem la taula els valors de draw:
S_textscan_table_filtred_drawline = S_textscan_table_filtred(S_textscan_table_filtred.Modifs == "DrawLine", :);
% En aqui hi hauria d'haver les línies de draw lines que s'han
% seleccionat i guardat. Aquestes ara es descartaran de la taula principal. Estan duplicades.



% _Taula draw_
taula_dibuix = app.taula_draw_main;

if ~isempty(taula_dibuix)
    % Filtrem per nom
    taula_dibuix_filted = taula_dibuix(taula_dibuix.NomWorm == app.img_original_nomLabel.Text, :);
    
    % Taula dibuix a anar eliminant
    taula_dibuix_filted_t = taula_dibuix_filted;

    if ~isempty(S_textscan_table_filtred_drawline)

        % Filtrem per index processats:
        taula_dibuix_filted_nonproc = taula_dibuix_filted(~ismember(taula_dibuix_filted.Indx_skel, S_textscan_table_filtred_drawline.Indx_skel), :);

    else
        taula_dibuix_filted_nonproc = taula_dibuix_filted;
    end
else
    % disp("Isemptyy")
    taula_dibuix_filted_nonproc = [];
end


% FINAL FUNCIÓ


end