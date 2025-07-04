function [BW_final] = processament_imatge2(imatge_input, carpeta_configs, seguiment_graficacio, carpeta_output_imseguiment, nom_file)

% Processament d'imatge obtenint imatge binària. Seguiment de configuracións.
%
% Variables:
% imatge_input
% carpeta_configs : 
% seguiment_graficacio : true/false si es vol guardar les imatges en una variable. 
% carpeta_output_imseguiment : carpeta on es guarda el seguiment
% nom_file
%
%
% Exemeple Variables:
% carpeta_internal_code_files : "D:\Escritorio\C elegans Analisis Imatge - ICMAB\Length determination v2_1\Internal_code_files"
% 
% Exempe escriptura i lectura de patróns de processament
% % Variables
% % field_set : carpeta on es guarda
% field_set = strcat(pwd, "\asdf.txt");
% txt_seg(field_set, "Im2gray", ";;") % seguiment config.
% % Lectura de patróns
% [array_sortida_modifs, ~] = llegir_text_delimitadors(field_set, ";;");
% array_sortida_modifs
% % delete(field_set)
%
% Nota: S'ha probat el filtre per gradient d'imatge, sense resultar eficaç.

% INICI FUNCIÓ
%--------------

% contador seguiment processament imatge
contador_process = 0;

% 
if ~exist('seguiment_graficacio','var')
    seguiment_graficacio = false;
    carpeta_output_imseguiment = false;
end


% Carpeta seguiment configuracions
if exist('carpeta_configs','var')
    field_set = strcat(carpeta_configs, "\image_seting.txt");
else
    field_set = "Internal_code_files\Image_processing_settings\image_seting.txt";
end


% Creem l'arxiu vuit
txt_seg(field_set, "", ";", "nou", "blanc")

% TO GRAYSCALE  :::im2gray():::
I1grey = im2gray(imatge_input);
%______________________seguiment______________________
txt_seg(field_set, "Im2gray") % seguiment config.
% ________seguiment graficació________
if seguiment_graficacio
    write_img_dir( ficar_text_imatge(I1grey, "im2gray", "", "auto"), carpeta_output_imseguiment, 1, nom_file, "_0_", string(contador_process) );
    contador_process = contador_process + 1;
end


% GREYSCALE ADJUSTMENT  :::imadjust():::
I1greyAdj = imadjust(I1grey);
%______________________seguiment______________________
txt_seg(field_set, "imadjust") % seguiment config.

% ________seguiment graficació________
if seguiment_graficacio
    write_img_dir( ficar_text_imatge(I1greyAdj, "imadjust", "", "auto"), carpeta_output_imseguiment, 1, nom_file, "_0_", string(contador_process) );
    contador_process = contador_process + 1;
end



% BINARIZATION :::imbinarize():::
BW = ~imbinarize(I1greyAdj,"adaptive",...
            "ForegroundPolarity","dark");
%______________________seguiment______________________
txt_seg(field_set, "Imbinarize_adaptative_Foreground_dark") % seguiment config.

% ________seguiment graficació________
if seguiment_graficacio
    write_img_dir( ficar_text_imatge(BW, "imbinarize", "", "auto"), carpeta_output_imseguiment, 1, nom_file, "_0_", string(contador_process) );
    contador_process = contador_process + 1;
end


%CLEAN LITTLE FRAGMENTS  :::bwareaopen():::
%BW_bwa = bwareaopen(BW,800);  %<- filtre anterior
[BW_bwa, ~] = bwareaopen_percentatge(BW, 2);
%______________________seguiment______________________
txt_seg(field_set, "bwareaopen(2)") % seguiment config.

% ________seguiment graficació________
if seguiment_graficacio
    write_img_dir( ficar_text_imatge(BW_bwa, "bwareaopen(2)", "", "auto"), carpeta_output_imseguiment, 1, nom_file, "_0_", string(contador_process) );
    contador_process = contador_process + 1;
end


%CLEAR BORDER   :::imclearborder():::
BW_bwa_imcl = imclearborder(BW_bwa);
%______________________seguiment______________________
txt_seg(field_set, "Imclearborder") % seguiment config.

% ________seguiment graficació________
if seguiment_graficacio
    write_img_dir( ficar_text_imatge(BW_bwa_imcl, "imclearborder()", "", "auto"), carpeta_output_imseguiment, 1, nom_file, "_0_", string(contador_process) );
    contador_process = contador_process + 1;
end



%FILL SPACES   :::imfill():::
BW_bwa_imcl = imfill(BW_bwa_imcl, "holes");
% __seguiment__
txt_seg(field_set, "imfill") % seguiment config.

% ________seguiment graficació________
if seguiment_graficacio
    write_img_dir( ficar_text_imatge(BW_bwa_imcl, "imfill()", "", "auto"), carpeta_output_imseguiment, 1, nom_file, "_0_", string(contador_process) );
    contador_process = contador_process + 1;
end



% OPEN IMAGE MORPHOLOGY
SE = strel("disk", 4);
BW_bwa_imcl = imopen(BW_bwa_imcl, SE);
%______________________seguiment______________________
txt_seg(field_set, "open_disc(4)") % seguiment config.

% ________seguiment graficació________
if seguiment_graficacio
    write_img_dir( ficar_text_imatge(BW_bwa_imcl, "open(disk, 4)", "", "auto"), carpeta_output_imseguiment, 1, nom_file, "_0_", string(contador_process) );
    contador_process = contador_process + 1;
end


% CLOSE IMAGE MORPHOLOGY
SE = strel("disk", 3);
BW_bwa_imcl = imclose(BW_bwa_imcl, SE);
%______________________seguiment______________________
txt_seg(field_set, "close_disc(3)") % seguiment config.


% ________seguiment graficació________
if seguiment_graficacio
    write_img_dir( ficar_text_imatge(BW_bwa_imcl, "close(disk, 3)", "", "auto"), carpeta_output_imseguiment, 1, nom_file, "_0_", string(contador_process) );
    contador_process = contador_process + 1;
end



% CLOSE IMAGE MORPHOLOGY x2
SE = strel("disk", 3);
BW_bwa_imcl = imclose(BW_bwa_imcl, SE);
%______________________seguiment______________________
txt_seg(field_set, "close_disc(3)") % seguiment config.

% ________seguiment graficació________
if seguiment_graficacio
    write_img_dir( ficar_text_imatge(BW_bwa_imcl, "close(disk, 3)", "", "auto"), carpeta_output_imseguiment, 1, nom_file, "_0_", string(contador_process) );
    contador_process = contador_process + 1;
end


%FILL SPACES   :::imfill():::
BW_bwa_imcl = imfill(BW_bwa_imcl, "holes");
%______________________seguiment______________________
txt_seg(field_set, "imfill") % seguiment

% ________seguiment graficació________
if seguiment_graficacio
    write_img_dir( ficar_text_imatge(BW_bwa_imcl, "imfill()", "", "auto"), carpeta_output_imseguiment, 1, nom_file, "_0_", string(contador_process) );
    contador_process = contador_process + 1;
end


% FILTER BIG SOUND  :::bwareaopen():::
% BW_bwa_imcl = bwareaopen(BW_bwa_imcl,2300); %<- filtre anterior
[BW_bwa_imcl, ~] = bwareaopen_percentatge(BW_bwa_imcl, 3.5);
%______________________seguiment______________________
txt_seg(field_set, "bwareaopen(3.5)") % seguiment

% ________seguiment graficació________
if seguiment_graficacio
    write_img_dir( ficar_text_imatge(BW_bwa_imcl, "bwareaopen(3.5)", "", "auto"), carpeta_output_imseguiment, 1, nom_file, "_0_", string(contador_process) );
    contador_process = contador_process + 1;
end


% FILTER BIG SOUND 2
% BW_bwa2_imcl_fill_open_close = bwareaopen(BW_bwa_imcl, 800);  %<-Filtre antic
[BW_bwa_imcl, ~] = bwareaopen_percentatge(BW_bwa_imcl, 2);

%______________________seguiment______________________
txt_seg(field_set, "bwareaopen(2)") % seguiment

% ________seguiment graficació________
if seguiment_graficacio
    write_img_dir( ficar_text_imatge(BW_bwa_imcl, "bwareaopen(2)", "", "auto"), carpeta_output_imseguiment, 1, nom_file, "_0_", string(contador_process) );
    contador_process = contador_process + 1;
end



%BW_final_conjunts: imatge binaritzada amb tots els conjunts de 
BW_final_conjunts = BW_bwa_imcl;

% ________seguiment graficació________
if seguiment_graficacio
    write_img_dir( BW_final_conjunts, carpeta_output_imseguiment, 1, nom_file, "_0_", string(contador_process) );
    contador_process = contador_process + 1;
end


BW_final = BW_final_conjunts;


% Notes sobre processament de la imatge:
       % Es va intentar processar la imatge per textures, però no va
       % resultar en un filtratge significatiu... No es descarta pero per a
       % un futur.



% FINAL FUNCIÓ


end
