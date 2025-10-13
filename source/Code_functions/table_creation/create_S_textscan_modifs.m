function [S_textscan_table_row, variables_noms] = create_S_textscan_modifs(BW_label_1, isceleg, nomworm, modifs_string)

% Create the file S_textscan_table as a variable and as a text file, which
% will contain the different described properties of the binary object and
% will be the basis for subsequent tracking and analysis.
%
%
% Variables
% input
%       BW_1_obj - Main binary object, main image (not cropped)
%       frame - object frame
%       img_1 - RGB image of the frame
%       morph_type - morphology type ("relax", "pump")
%       anot_type - annotation type ("golden", "silver", "bronze", etc.)
%
% output
%       S_textscan_table_row - Table created (single line)
% 
% Functions of interest
% read_data
%
%
% See also

% START FUNCTION



% ___ obtain data ___ %

BW_indx_string = strjoin(string(find(BW_label_1)), ";");
% Elapsed time: 0.0160 seconds
% % Read:
% BW_indx = appf_split_strindex(BW_indx_string);
% % Elapsed time: 0.00592 seconds

% Resolution img
resol_string = strjoin(string([size(BW_label_1, 1), size(BW_label_1, 2)]), ";");

% % 



BWskel_indx_string  = "No_data_yet";
BWwidth_string = "No_data_yet";
dades_imatge = "No_data_yet";


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



% % Data missing
% isceleg = "yes";
% nomworm = "imatge.png";
% modifs_string = "modificacios;etc";


% ___ Make table ___ %
 
% _Data cell_
cell_dades_totals = {isceleg, nomworm, dades_imatge, BB_string, modifs_string, ...
        BWskel_indx_string, BW_indx_string, BWwidth_string, resol_string, morph_prop_circularity, morph_prop_majoraxis, morph_prop_area};

variables_noms = [ "IsCeleg", "NomWorm", "Length", "Bounding", "Modifs", ...
    "Indx_skel", "Indx_BW", "WidthValues", "Resolution", "Morph_circularity", "Morph_majoraxis", "Morph_area"];

% ___Create in table___
S_textscan_table_row = cell2table(cell_dades_totals, 'VariableNames', variables_noms);




% __Save text file__
% write_dades_cell(arxiu_dir, cell_dades_totals, tipologia_formatspec(cell_dades_totals), "$"); 



% END FUNCTION

end