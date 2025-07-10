function [BW_final, beono] = processment_img_list(imatge_input, array_processaments)

% Given an array of processing types, the consecutive processing 
% of the image is done according to the type of this array.

% If an error occurs in any image (eg: cleanborders and there is none, or
% the like), the last modified image is returned with an "error" in the
% middle, and a counter of whether it went well or badly (beono).

% Variables
%
% -input-
% imatge_input          : input image. Original, 3D.
% array_processaments   : processing typology array.
%                         Their parameters are determined by their
%                         own names, ex: bwareaopen(3).
%
% -output-
% beono : counter whether the process has gone correctly to the end or not.
% BW_final : final processed image.
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
% processament_img_list

% START FUNCTION

% _Internal variables_
% imatge_input_modif : image to be modified during processing.
% splited_nom_arxiu  : Name of the file

% We define the image to modify.
imatge_input_modif = imatge_input;

% For each processing:
for cada_process = 1:length(array_processaments)
    
    % _Get name and value of the processing_
    
    % processing name
    processament_im_cru = array_processaments(cada_process);

    % If there are parentheses
    if contains(processament_im_cru, "(")
        
        splited_nom_arxiu = split(processament_im_cru, "(");
        
        % Obtain processing name
        processament_im = splited_nom_arxiu(1);
        
        % Obtain value
        split_valor_prov = split(splited_nom_arxiu(2), ")");

        % Filter if there is comma (ex: (23, 32)
        if contains(split_valor_prov(1), ",")
            valor_processament_im = double(split(split_valor_prov(1), ","))';
        else
            valor_processament_im = double(split_valor_prov(1));
        end
       
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
        imatge_input_modif = im2gray(imatge_input_modif);

    % Grey modif
    elseif processament_im == "imadjust"
        imatge_input_modif = imadjust(imatge_input_modif);
        
        
    % Grey to Binary
    elseif processament_im == "Imbinarize_adaptative_Foreground_dark"
        imatge_input_modif = ~imbinarize(imatge_input_modif,"adaptive", "ForegroundPolarity","dark");


    % Binary Modif
    elseif processament_im == "bwareaopen"
        [imatge_input_modif, ~] = bwareaopen_percentage(imatge_input_modif, valor_processament_im);
        
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
        % The return from edge is a binary image.
        imatge_input_modif = edge(imadjust(im2gray(imatge_input)), "approxcanny");
        
    % Grey modif _croped_
    elseif processament_im == "imadjust_croped"
        % Obtain parameters
        % imadjust_croped(prm_average, prm_sigma)"
        n = 2;  
        prm_average = valor_processament_im(1);
        prm_sigma = valor_processament_im(2);
        imatge_input_modif = imadjust(imatge_input_modif,[prm_average-n*prm_sigma/255 prm_average+n*prm_sigma/255],[]); % Imatge semi-binaria 3D. %[avg-n*sigma/255 avg+n*sigma/255]

        % im2gray of the general image:
        imatge_input_modif = im2gray(imatge_input_modif);
        
        % Make a 'complement' of the binary image
        imatge_input_modif = imcomplement(imatge_input_modif);
        
    elseif processament_im == "region_imopen"
        %imatge_input_modif
        %valor_processament_im
    elseif processament_im == "binarize_by_value"
        % Binarize per value
        imatge_input_modif = imatge_input_modif >= valor_processament_im;
    end

end


%imshow(imatge_input_modif)
beono = true;

BW_final = imatge_input_modif;

% END FUNCTION


% ANNEX END NOTES
% ##################

% % EXAMPLE STANDARD IMAGE PROCESSING OF THE  f'processament_imatge2' v2.8.
% % --------------------------------------------------------------------------
%
% % TO GRAYSCALE  :::im2gray():::
% I1grey = im2gray(imatge_input);
% %______________________follow-up______________________
% txt_seg(field_set, "Im2gray") % follow-up config.
% 
% 
% % GREYSCALE ADJUSTMENT  :::imadjust():::
% I1greyAdj = imadjust(I1grey);
% %______________________follow-up______________________
% txt_seg(field_set, "imadjust") % follow-up config.
% 
% % BINARIZATION :::imbinarize():::
% BW = ~imbinarize(I1greyAdj,"adaptive",...
%             "ForegroundPolarity","dark");
% %______________________follow-up______________________
% txt_seg(field_set, "Imbinarize_adaptative_Foreground_dark") % follow-up config.
% 
% 
% %CLEAN LITTLE FRAGMENTS  :::bwareaopen():::
% %BW_bwa = bwareaopen(BW,800);  %<- filtre anterior
% [~, BW_bwa] = bwareaopen_percentage(BW, 2);
% %______________________follow-up______________________
% txt_seg(field_set, "bwareaopen(2)") % follow-up config.
% 
% 
% %CLEAR BORDER   :::imclearborder():::
% BW_bwa_imcl = imclearborder(BW_bwa);
% %______________________follow-up______________________
% txt_seg(field_set, "Imclearborder") % follow-up config.
% 
% %FILL SPACES   :::imfill():::
% BW_bwa_imcl = imfill(BW_bwa_imcl, "holes");
% % __follow-up__
% txt_seg(field_set, "imfill") % follow-up config.
% 
% % OPEN IMAGE MORPHOLOGY
% SE = strel("disk", 4);
% BW_bwa_imcl = imopen(BW_bwa_imcl, SE);
% %______________________follow-up______________________
% txt_seg(field_set, "open_disc(4)") % follow-up config.
% 
% 
% % CLOSE IMAGE MORPHOLOGY
% SE = strel("disk", 3);
% BW_bwa_imcl = imclose(BW_bwa_imcl, SE);
% %______________________follow-up______________________
% txt_seg(field_set, "close_disc(3)") % follow-up config.
% 
% % CLOSE IMAGE MORPHOLOGY x2
% SE = strel("disk", 3);
% BW_bwa_imcl = imclose(BW_bwa_imcl, SE);
% %______________________follow-up______________________
% txt_seg(field_set, "close_disc(3)") % follow-up config.
% 
% 
% %FILL SPACES   :::imfill():::
% BW_bwa_imcl = imfill(BW_bwa_imcl, "holes");
% %______________________follow-up______________________
% txt_seg(field_set, "imfill") % follow-up
% 
% % FILTER BIG SOUND  :::bwareaopen():::
% % BW_bwa_imcl = bwareaopen(BW_bwa_imcl,2300); %<- filtre anterior
% [~, BW_bwa_imcl] = bwareaopen_percentage(BW_bwa_imcl, 3.5);
% %______________________follow-up______________________
% txt_seg(field_set, "bwareaopen(3.5)") % follow-up
% 
% % FILTER BIG SOUND 2
% % BW_bwa2_imcl_fill_open_close = bwareaopen(BW_bwa_imcl, 800);  %<-Filtre antic
% [~, BW_bwa_imcl] = bwareaopen_percentage(BW_bwa_imcl, 2);
% 
% %______________________follow-up______________________
% txt_seg(field_set, "bwareaopen(2)") % follow-up



end