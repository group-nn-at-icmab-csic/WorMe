function [dades_imatge_row, dades_imatge_manual_corrected] = obtenir_distancies_BWskel(BW_skel, escala_imatge, n_pixel_margin)

% Prové de worm_skeletonization_manual.
% 
%
% -- Variables input:
% -- BW_skel
%               Imatge binària esqueletonitzada
% 
% 
% -- escala_imatge
%                   Defineix la escala en que s'escalarà la imatge, en
%                   cuant a el càlcul de la distància d'aquesta.
%                   Si no es defineix, aquesta és igual a 1.
%
%
% - n_pixel_margin : marge de pixels del calcul de la distància amb l'error manual.
%
%
% - dades_imatge_manual_corrected - Dades amb la correcció de l'error manual.
%
% - dades_imatge_row - Dades sense correcció d'error manual.
%
%
% OPITMITZAT: 
% worm_skeletonization : Elapsed time is 0.362784 seconds.
%
%
%
% Variables exemple
% BW_final = BW_llistat_imatges;
% I1 = imageArray;
% escala_imatge = escala_imatge;
% extendre_skel_opcio = 1;
%
%
%
% See also
% esqueletonitzacio_josep
% large_skel
% extendre_skel_estes
% worm_length



% INICI SCRIPT


% _Obtenció de la llargada numèrica_
% disp("[Area_Josep] = worm_length(BW_skel);")

% _Dades amb correcció error manual_
[Area_Josep] = worm_length_manual(BW_skel, n_pixel_margin);

Area_Josep_scaled = Area_Josep / escala_imatge; %Es multiplica pel ratio de l'escala (pixels / unitat)

dades_imatge_manual_corrected = Area_Josep_scaled;


% _Dades sense correcció error manual_

[Area_Josep] = worm_length(BW_skel);

Area_Josep_scaled = Area_Josep / escala_imatge; %Es multiplica pel ratio de l'escala (pixels / unitat)

dades_imatge_row = Area_Josep_scaled;

% % _Comprovació comparació entre ambdós distancies:_
% Nota: l'error és de 1 pixel, a causa de la metodologia. Es subsceptible
% de no ser considerat.
% [Area_Josep_1] = worm_length_manual(BW_skel, 1)
% [Area_Josep_2] = worm_length(BW_skel)
% if isequal(Area_Josep_1, Area_Josep_2); disp("Equal length"); end


% FINAL SCRIPT


end