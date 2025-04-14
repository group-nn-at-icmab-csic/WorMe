function [BW_final, beono] = processament_imatge_llistat(imatge_input, array_processaments)

% Donat un array de tipus de processament, es fa el processament consecutiu
% de la imatge en funció a la tipologia d'aquest array.

% Si dona error en alguna imatge (ex: cleanborders i no hi ha, o per
% l'estil), que es retorni la última imatge modificada amb un "error" al
% mig, i un contador de si ha anat bé o malament (beono).

% Variables
%
% -input-
% imatge_input          : imatge d'entrada. Original, 3D.
% array_processaments   : array de la tipologia dels processaments.
%                         Els paràmetres d'aquests són detemrinats pel nom
%                         dels mateixos, ex: bwareaopen(3).
%
% -output-
% beono : contador si el procés ha anat correctament fins al final o no.
% BW_final : imatge final processada.
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
% "edge_approxcanny"            : fa un edge ce tipus approxcanny. Veure probes_edge
%
% PARÀMETRES DEL PROCESSAMENT
% "()" : paréntesis : indiquen el valor de la modificació. SI no hi ha
% paréntesis no s'empra el valor en la funció.
%
%
% See also
% processament_imatge2

% INICI FUNCIÓ

% _Variables internes_
% imatge_input_modif : imatge a modificar en processament.
% splited_nom_arxiu  : Nom del 

% Definim imatge a modificar.
imatge_input_modif = imatge_input;

% Per cada processament:
for cada_process = 1:length(array_processaments)
    
    % _Obtenim nom i valor del processament_
    
    % Nom processament
    processament_im_cru = array_processaments(cada_process);

    % Si hi ha paréntesis
    if contains(processament_im_cru, "(")
        
        splited_nom_arxiu = split(processament_im_cru, "(");
        
        % Obtenim nom processament
        processament_im = splited_nom_arxiu(1);
        
        % Obtenim valor
        split_valor_prov = split(splited_nom_arxiu(2), ")");

        % Filtrem si hi ha coma (ex: (23, 32)
        if contains(split_valor_prov(1), ",")
            valor_processament_im = double(split(split_valor_prov(1), ","))';
        else
            valor_processament_im = double(split_valor_prov(1));
        end
       
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
        imatge_input_modif = im2gray(imatge_input_modif);

    % Grey modif
    elseif processament_im == "imadjust"
        imatge_input_modif = imadjust(imatge_input_modif);
        
        
    % Grey a Binària
    elseif processament_im == "Imbinarize_adaptative_Foreground_dark"
        imatge_input_modif = ~imbinarize(imatge_input_modif,"adaptive", "ForegroundPolarity","dark");


    % Binària Modif
    elseif processament_im == "bwareaopen"
        [imatge_input_modif, ~] = bwareaopen_percentatge(imatge_input_modif, valor_processament_im);
        
    elseif processament_im == "Imclearborder"
        imatge_input_modif = imclearborder(imatge_input_modif);
        
    elseif processament_im == "imfill"
        imatge_input_modif = imfill(imatge_input_modif, "holes");
        
    elseif processament_im == "open_disc"
        SE = strel("disk", valor_processament_im);
		imatge_input_modif = imopen(imatge_input_modif, SE);

    elseif processament_im == "close_disc"
        SE = strel("disk", valor_processament_im);
        imatge_input_modif = imclose(imatge_input_modif, SE);
        
    elseif processament_im == "Flip"
        imatge_input_modif = ~imatge_input_modif;
    
    elseif processament_im == "edge_approxcanny"
        % El retorn de edge és una imatge binària.
        % ÇÇÇ: Aquesta modificació hauria de restar a la imatge la bora?
        imatge_input_modif = edge(imadjust(im2gray(imatge_input)), "approxcanny");
        
    % Grey modif _croped_
    elseif processament_im == "imadjust_croped"
        % Obtencio parametres
        % imadjust_croped(prm_average, prm_sigma)"
        n = 2;  
        prm_average = valor_processament_im(1);
        prm_sigma = valor_processament_im(2);
        imatge_input_modif = imadjust(imatge_input_modif,[prm_average-n*prm_sigma/255 prm_average+n*prm_sigma/255],[]); % Imatge semi-binaria 3D. %[avg-n*sigma/255 avg+n*sigma/255]

        % im2gray de la imatge general:
        imatge_input_modif = im2gray(imatge_input_modif);
        
        % Fem un 'complement' de la imatge binaria
        imatge_input_modif = imcomplement(imatge_input_modif);
        
    elseif processament_im == "region_imopen"
        % ÑÑÑ MODIFICANT DES D'AQUI
        %imatge_input_modif
        %valor_processament_im
    elseif processament_im == "binarize_by_value"
        % Binaritzem per valor
        imatge_input_modif = imatge_input_modif >= valor_processament_im;
    end

end


%imshow(imatge_input_modif)
beono = true; % ççç a definim de moment així, perquè encara no entrem a descriure una imatge de sortida amb errors.

BW_final = imatge_input_modif;

% FINAL FUNCIÓ

% ANNEX NOTES FINALS
% ##################

% % EXEMPLE PROCESSAMENT IMATGE ESTÁNDAR DE LA f'processament_imatge2' v2.8.
% % --------------------------------------------------------------------------
%
% % TO GRAYSCALE  :::im2gray():::
% I1grey = im2gray(imatge_input);
% %______________________seguiment______________________
% txt_seg(field_set, "Im2gray") % seguiment config.
% 
% 
% % GREYSCALE ADJUSTMENT  :::imadjust():::
% I1greyAdj = imadjust(I1grey);
% %______________________seguiment______________________
% txt_seg(field_set, "imadjust") % seguiment config.
% 
% % BINARIZATION :::imbinarize():::
% BW = ~imbinarize(I1greyAdj,"adaptive",...
%             "ForegroundPolarity","dark");
% %______________________seguiment______________________
% txt_seg(field_set, "Imbinarize_adaptative_Foreground_dark") % seguiment config.
% 
% 
% %CLEAN LITTLE FRAGMENTS  :::bwareaopen():::
% %BW_bwa = bwareaopen(BW,800);  %<- filtre anterior
% [~, BW_bwa] = bwareaopen_percentatge(BW, 2);
% %______________________seguiment______________________
% txt_seg(field_set, "bwareaopen(2)") % seguiment config.
% 
% 
% %CLEAR BORDER   :::imclearborder():::
% BW_bwa_imcl = imclearborder(BW_bwa);
% %______________________seguiment______________________
% txt_seg(field_set, "Imclearborder") % seguiment config.
% 
% %FILL SPACES   :::imfill():::
% BW_bwa_imcl = imfill(BW_bwa_imcl, "holes");
% % __seguiment__
% txt_seg(field_set, "imfill") % seguiment config.
% 
% % OPEN IMAGE MORPHOLOGY
% SE = strel("disk", 4);
% BW_bwa_imcl = imopen(BW_bwa_imcl, SE);
% %______________________seguiment______________________
% txt_seg(field_set, "open_disc(4)") % seguiment config.
% 
% 
% % CLOSE IMAGE MORPHOLOGY
% SE = strel("disk", 3);
% BW_bwa_imcl = imclose(BW_bwa_imcl, SE);
% %______________________seguiment______________________
% txt_seg(field_set, "close_disc(3)") % seguiment config.
% 
% % CLOSE IMAGE MORPHOLOGY x2
% SE = strel("disk", 3);
% BW_bwa_imcl = imclose(BW_bwa_imcl, SE);
% %______________________seguiment______________________
% txt_seg(field_set, "close_disc(3)") % seguiment config.
% 
% 
% %FILL SPACES   :::imfill():::
% BW_bwa_imcl = imfill(BW_bwa_imcl, "holes");
% %______________________seguiment______________________
% txt_seg(field_set, "imfill") % seguiment
% 
% % FILTER BIG SOUND  :::bwareaopen():::
% % BW_bwa_imcl = bwareaopen(BW_bwa_imcl,2300); %<- filtre anterior
% [~, BW_bwa_imcl] = bwareaopen_percentatge(BW_bwa_imcl, 3.5);
% %______________________seguiment______________________
% txt_seg(field_set, "bwareaopen(3.5)") % seguiment
% 
% % FILTER BIG SOUND 2
% % BW_bwa2_imcl_fill_open_close = bwareaopen(BW_bwa_imcl, 800);  %<-Filtre antic
% [~, BW_bwa_imcl] = bwareaopen_percentatge(BW_bwa_imcl, 2);
% 
% %______________________seguiment______________________
% txt_seg(field_set, "bwareaopen(2)") % seguiment



end