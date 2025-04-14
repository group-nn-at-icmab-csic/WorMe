function [BW_skel, dades_imatge, dades_imatge_corrected] = esqueletonitzacio_josep_optim(BW_final, escala_imatge, extendre_skel_opcio, reduce_line)

% Given a binary image and its scale, its skeletonized image and the distance to that scaled image are returned.
%
% Diferent than esqueletonitzacio_josep_optim_2, here the manual error
% pixels are fixed (every 5 pixels, which was the lower error).
%
% (CAT)
% Donada una imatge binària i la seva escala, es retorna la seva imatge esqueletonitzada i la distància d'aquesta imatge a escala.
%
%
% -- Variables input:
% -- BW_final
%               Input binary image
% 
% -- I1
%       imatge inicial
% 
% -- escala_imatge
%               Defines the scale in which the image will be scaled, 
%               regarding the calculation of its distance. If not defined, 
%               this is equal to 1.
%
% - extendre_skel_opcio
%                       if it is determined as 1, extend the skeleton of the
%                       skeletonized image. 
% 
% - reduce_line   (true/false)
%                reduce the branchpoints if there is many, to the larger one. 
%               It uses the funcion longestConstrainedPath.
%
%
%
% OPITMITZAT: 
% esqueletonitzacio_josep       : Elapsed time is 0.205519 seconds.
% esqueletonitzacio_josep_optim : Elapsed time is 0.362784 seconds.
%
%
% També s'afegeix una imatge normal inicial per a una graficació final.
% UPGRADE: 
% - No es considera la imatge original
% - sols hi pot haber un objecte binari
% - S'han de definir totes les variables
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
% llargada_josep
% esqueletonitzacio_josep_optim_2



% INICI SCRIPT


% Esqueletonització general
BW_skel = bwskel(BW_final);

% Agafem els endpoints
endpoints_BW = find(bwmorph(BW_skel,'endpoints'));
%find(bwmorph(BWskel_1,'branchpoints'));


if reduce_line % Si s'aplica reducció de la línia:
    if numel(endpoints_BW)>2
        % vell: [BW_skel, ~] = longestConstrainedPath_Josep(BW_final, "thinOpt", "thin");
        % [BW_skel] = large_skel(BW_skel);
        [BW_skel] = large_skel_iter(BW_skel); % Upgrade josep 11/09/2022
    else
        % Res, ja tenim definit el BW_skel
    end
else
    % Res, ja tenim definit el BW_skel
end


% Extensió esqueletonització
if extendre_skel_opcio
    % La imatge esqueletonitzada ha de ser superior a 1, sinó la imatge
    % no pot ser esqueletonitzada.
    if sum(BW_skel(:)) > 1
        [BW_skel] = extendre_skel_estes_nou(BW_final, BW_skel, "prop", 5);
    end
end


% _Obtenció de la llargada numèrica_
% disp("[Area_Josep] = llargada_josep(BW_skel);")
% [Area_Josep] = llargada_josep(BW_skel)
[Area_Josep] = llargada_josep_Fiji(BW_skel, 5);
Area_Josep_scaled = Area_Josep / escala_imatge; %Es multiplica pel ratio de l'escala (pixels / unitat)
dades_imatge_corrected = Area_Josep_scaled;

% % _Comprovació comparació entre ambdós distancies:_
% Nota: l'error és de 1 pixel, a causa de la metodologia. Es subsceptible
% de no ser considerat.
% [Area_Josep_1] = llargada_josep_Fiji(BW_skel, 1)
% [Area_Josep_2] = llargada_josep(BW_skel)
% if isequal(Area_Josep_1, Area_Josep_2); disp("Equal length"); end

[Area_Josep] = llargada_josep(BW_skel);

Area_Josep_scaled = Area_Josep / escala_imatge; %Es multiplica pel ratio de l'escala (pixels / unitat)

dades_imatge = Area_Josep_scaled;



% FINAL SCRIPT


end