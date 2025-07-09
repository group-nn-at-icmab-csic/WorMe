function [S_textscan_table_draw] = app_interf_descriure_dades_draw_taula(app, dades_imatge, zeros_imatge_cotxe)

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
% app_interf_descriure_dades_draw_cell


% INICI FUNCIÓ


% Definim els elements:

% Selecció
v_IsCeleg = "IsDraw";

% Nom imatge
v_NomWorm = string(app.img_original_nomLabel.Text);

% Llargada
v_Length = dades_imatge;

% Bounding Box
[BB_values_list, ~] = cut_BB_BW_image_3(zeros_imatge_cotxe);
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


% Ho passem a taula
S_textscan_table_draw = table(v_IsCeleg, v_NomWorm, v_Length, v_Bounding, v_Modifs, ...
                     v_Indx_skel, v_Indx_BW, v_WidthValues, v_Resolution, ...
                        'VariableNames', ["IsCeleg","NomWorm", "Length", "Bounding", "Modifs", "Indx_skel", "Indx_BW", "WidthValues", "Resolution"] );





% FINAL FUNCIÓ

end