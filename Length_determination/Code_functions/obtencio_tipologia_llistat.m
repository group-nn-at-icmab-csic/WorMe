function [tipus_im_modif, processament_im] = obtencio_tipologia_llistat(tipologia_input)

% Donat un tipus de modificació últim d'una imatge (tipologia_input), es retorna 
% el tipus d'imatge que aquesta modificació genera. En exemple: rgb, gray o binary.
%
% La utilitat és en app_image_processment per a filtrar les
% modificacions.
%
% Variables
%
% -input-
%
% -output-
%
%
% __Tipologia de les funcións__
% 
% RGB a Grey
% ----------
% "Im2gray"				: im2gray(imatge_input)
% 
% Grey Modificació
% ----------------
% "imadjust"				: imadjust(I1grey)
% 
% Grey a Binaria
% --------------
% "Imbinarize_adaptative_Foreground_dark" : ~imbinarize(I1greyAdj,"adaptive", "ForegroundPolarity","dark");
% 
% Binaria Modificació
% -------------------
% "bwareaopen(2)"				: [~, BW_bwa] = bwareaopen_percentatge(BW, 2);
% "Imclearborder"				: imclearborder(BW_bwa)
% "imfill"	        			: imfill(BW_bwa_imcl, "holes");
% "open_disc(4)"				: SE = strel("disk", 4);
% 					              BW_bwa_imcl = imopen(BW_bwa_imcl, SE);
% "close_disc(3)"				: SE = strel("disk", 3);
% 					              BW_bwa_imcl = imclose(BW_bwa_imcl, SE);
%
%
%
% PARÀMETRES DEL PROCESSAMENT
% "()" : paréntesis : indiquen el valor de la modificació. SI no hi ha
% paréntesis no s'empra el valor en la funció.
%
%
% See also
% processament_imatge_llistat
% app_proc_obtenir_array_modificacions

% INICI FUNCIÓ

% _Variables internes_
% imatge_input_modif : imatge a modificar en processament.


% Nom processament
processament_im_cru = tipologia_input;

% Si hi ha paréntesis
if contains(processament_im_cru, "(")

    splited_nom_arxiu = split(processament_im_cru, "(");

    % Obtenim nom processament
    processament_im = splited_nom_arxiu(1);

    % Obtenim valor
    split_valor_prov = split(splited_nom_arxiu(2), ")");
    valor_processament_im = double(split_valor_prov(1));

% Si no hi ha paréntesis
else
    % Processament
    processament_im = processament_im_cru;
    % Valor processament (null)
    valor_processament_im = false;
end

%processament_im
%valor_processament_im




% _PROCESSAMENT DE LA IMATGE_

% RGB to Grey
if processament_im == "Im2gray"
    tipus_im_modif = "gray";

% Grey modif
elseif processament_im == "imadjust"
    tipus_im_modif = "gray";
    
elseif processament_im == "imadjust_croped"
    tipus_im_modif = "gray";

% Grey a Binària
elseif processament_im == "Imbinarize_adaptative_Foreground_dark"
    tipus_im_modif = "binary";

    
% Binària Modif
elseif processament_im == "bwareaopen"
    tipus_im_modif = "binary";

elseif processament_im == "Imclearborder"
    tipus_im_modif = "binary";

elseif processament_im == "imfill"
    tipus_im_modif = "binary";

    
elseif processament_im == "open_disc"
    tipus_im_modif = "binary";

elseif processament_im == "close_disc"
    tipus_im_modif = "binary";
    
elseif processament_im == "Flip"
    tipus_im_modif = "binary";

elseif processament_im == "edge_approxcanny"
    tipus_im_modif = "binary";
    
elseif processament_im == "binarize_by_value"
    tipus_im_modif = "binary";
        
end





end