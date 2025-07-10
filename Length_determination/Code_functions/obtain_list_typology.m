function [tipus_im_modif, processament_im] = obtain_list_typology(tipologia_input)

% Given a last modification type of an image (input_type), the
% type of image that this modification generates is returned. For example: rgb, gray or binary.
%
% The utility is in app_image_processment to filter the
% modifications.
%
% Variables
%
% -input-
%
% -output-
%
%
% __Function types__
% 
% RGB to Grey
% ----------
% "Im2gray"				: im2gray(imatge_input)
% 
% Modify Grey
% ----------------
% "imadjust"				: imadjust(I1grey)
% 
% Grey to Binary
% --------------
% "Imbinarize_adaptative_Foreground_dark" : ~imbinarize(I1greyAdj,"adaptive", "ForegroundPolarity","dark");
% 
% Modify binary
% -------------------
% "bwareaopen(2)"				: [~, BW_bwa] = bwareaopen_percentage(BW, 2);
% "Imclearborder"				: imclearborder(BW_bwa)
% "imfill"	        			: imfill(BW_bwa_imcl, "holes");
% "open_disc(4)"				: SE = strel("disk", 4);
% 					              BW_bwa_imcl = imopen(BW_bwa_imcl, SE);
% "close_disc(3)"				: SE = strel("disk", 3);
% 					              BW_bwa_imcl = imclose(BW_bwa_imcl, SE);
%
%
%
% PROCESSING PARAMETERS
% "()" : parentheses : indicate the value of the modification. IF there are no
% parentheses the value is not used in the function.
%
%
% See also
% processment_img_list
% app_proc_obtenir_array_modificacions

% START FUNCTION

% _Internal variables_
% imatge_input_modif : image to be modified during processing.


% processing name
processament_im_cru = tipologia_input;

% If there are parentheses
if contains(processament_im_cru, "(")

    splited_nom_arxiu = split(processament_im_cru, "(");

    % Obtain processing name
    processament_im = splited_nom_arxiu(1);

    % Obtain value
    split_valor_prov = split(splited_nom_arxiu(2), ")");
    valor_processament_im = double(split_valor_prov(1));

% If there are no parentheses
else
    % Processing
    processament_im = processament_im_cru;
    % Processing value (null)
    valor_processament_im = false;
end

%processament_im
%valor_processament_im




% _IMAGE PROCESSING_

% RGB to Grey
if processament_im == "Im2gray"
    tipus_im_modif = "gray";

% Grey modif
elseif processament_im == "imadjust"
    tipus_im_modif = "gray";
    
elseif processament_im == "imadjust_croped"
    tipus_im_modif = "gray";

% Grey to Binary
elseif processament_im == "Imbinarize_adaptative_Foreground_dark"
    tipus_im_modif = "binary";

    
% Binary Modif
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