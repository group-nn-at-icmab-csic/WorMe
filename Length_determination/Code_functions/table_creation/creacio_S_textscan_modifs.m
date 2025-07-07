function [S_textscan_table_row, variables_noms] = creacio_S_textscan_modifs(BW_label_1, isceleg, nomworm, modifs_string)


% Provinent de creacio_S_textscan
% Crea l'arxiu S_textscan_table com a variable i com a arxiu de text, el
% qual contindrà les diferents propietats descrites de l'objecte binari i
% que seràn la base per al tracking i anàlisi posteriors.
%
%
% Variables
%       input
%           BW_1_obj - Objecte binari principal, imatge principal (no retallada)
%           frame - frame de l'objecte           
%           img_1 - imatge RGB del frame
%           morph_tipus - tipus de morfologia ("relax", "pump")
%           anot_tipus - tipus d'anotació ("golden", "silver", "bronze", etc.)
%
%       output
%           S_textscan_table_row - Taula creada (una sola línia)
% 
% Funcións d'interès
% llegir_dades
%
%
% See also
% creacio_S_textscan

% START FUNCTION



% ___ obtenim dades ___ %

BW_indx_string = strjoin(string(find(BW_label_1)), ";");
% Elapsed time: 0.0160 seconds
% % Lectura:
% BW_indx = appf_split_strindex(BW_indx_string);
% % Elapsed time: 0.00592 seconds

% Resolucio img
resol_string = strjoin(string([size(BW_label_1, 1), size(BW_label_1, 2)]), ";");

% % 



BWskel_indx_string  = "Pikatchu";
BWwidth_string = "Pikatchu";
dades_imatge = "Pikatchu";


BB = regionprops(BW_label_1, 'BoundingBox', "Circularity", 'MajorAxisLength', 'Area');
% Elapsed time: 0.00788 seconds ; 50 iterations in 4.3Gb of RAM memory used

BB_string = strjoin(string(BB.BoundingBox), ";");

morph_prop_circularity = BB.Circularity;
morph_prop_majoraxis = BB.MajorAxisLength;
morph_prop_area = BB.Area;




% disp("llargada")
% dades_imatge
% disp("major axis")
% BB.MajorAxisLength
% disp("factor")
% dades_imatge / BB.MajorAxisLength


% BB.Circularity



% % Dades falten
% isceleg = "yes";
% nomworm = "imatge.png";
% modifs_string = "modificacios;etc";


% ___ realitzem taula ___ %
 
% _Cell de dades_
cell_dades_totals = {isceleg, nomworm, dades_imatge, BB_string, modifs_string, ...
        BWskel_indx_string, BW_indx_string, BWwidth_string, resol_string, morph_prop_circularity, morph_prop_majoraxis, morph_prop_area};

variables_noms = [ "IsCeleg", "NomWorm", "Length", "Bounding", "Modifs", ...
    "Indx_skel", "Indx_BW", "WidthValues", "Resolution", "Morph_circularity", "Morph_majoraxis", "Morph_area"];

% ___Creació en taula___
S_textscan_table_row = cell2table(cell_dades_totals, 'VariableNames', variables_noms);




% __Guradat arxiu__
% write_dades_cell(arxiu_dir, cell_dades_totals, tipologia_formatspec(cell_dades_totals), "$"); % Guardem en arxiu de text



% END FUNCTION

end