function [cell_dades_totals] = app_interf_descriure_dades_draw_cell(app, dades_imatge, zeros_imatge_cotxe)

% Descriure dades de la línia dibuixada en una taula.
%
% Variables taula: "IsCeleg","NomWorm", "Length", "Bounding", "Modifs", "Indx_skel", "Indx_BW", "WidthValues", "Resolution"
%
%   Variables
%       input
%           dades_imatge : dades_llargada
%           zeros_imatge_cotxe : imatge_esqueletonització
%
% See also
% app_interf_guardar_main_dades
% app_interf_llegir_main_dades


% INICI FUNCIÓ


% Definim els elements:

% Selecció
v_IsCeleg = "IsDraw";

% Nom imatge
v_NomWorm = app.img_original_nomLabel.Text;

% Llargada
v_Length = dades_imatge;

% Bounding Box
[BB_values_list, ~] = retallar_BB_BWimg(zeros_imatge_cotxe);
v_Bounding = strjoin(string(BB_values_list), ";");

% v_Modifs
v_Modifs = "DrawLine";

% v_Indx_skel
v_Indx_skel = strjoin(string(find(zeros_imatge_cotxe)), ";");

% v_Indx_BW
v_Indx_BW = v_Indx_skel;

% v_WidthValues
v_WidthValues = NaN;

% v_Resolution
v_Resolution = app.resolucio_img;

cell_dades_totals = {v_IsCeleg, v_NomWorm, v_Length, v_Bounding, v_Modifs, ...
                     v_Indx_skel, v_Indx_BW, v_WidthValues, v_Resolution};



% FINAL FUNCIÓ

end