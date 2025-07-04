function [BW_skel, dades_imatge_row, dades_imatge_manual_corrected] = worm_skeletonization_manual(BW_final, escala_imatge, extendre_skel_opcio, reduce_line, n_pixel_margin)

% Like worm_skeletonization, but gives both the distance for each
% pixel, and the distance with manual correction. And we can define the
% pixel margin of the manual error.

% Given a binary image and its scale, its skeletonized image and the distance to that scaled image are returned. We can define the pixel range in the manual error.
%
% (CAT)
% Donada una imatge binària i la seva escala, es retorna la seva imatge esqueletonitzada i la distància d'aquesta imatge a escala.
%
% An initial normal image is also added for a final plot.
% UPGRADE:
% - The original image is not considered
% - there can only be one binary object
% - All variables must be defined
%
% -- Input variables:
% -- BW_final
%           Initial binary image
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
% - n_pixel_margin : Number of pixels that will be counted in the manual error. 
%                   For example if it is 5, the distance will be from the pixel 1 to 5, 
%                   from 6 to 10, etc. This is different that in the normal distance, 
%                   where the distance is between each pixel (1-2-3-4-5...). 
%
% Output
% - dades_imatge_manual_corrected - Data with the manual error considered.
%
% - dades_imatge_row - Data standard. Pixel by pixel.
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


% General skeletonization
BW_skel = bwskel(BW_final);

% We take the endpoints
endpoints_BW = find(bwmorph(BW_skel,'endpoints'));
%find(bwmorph(BWskel_1,'branchpoints'));


if reduce_line % If line reduction is applied:
    if numel(endpoints_BW)>2
        % vell: [BW_skel, ~] = longestConstrainedPath_Josep(BW_final, "thinOpt", "thin");
        % [BW_skel] = large_skel(BW_skel);
        [BW_skel] = large_skel_iter(BW_skel); % Upgrade josep 11/09/2022
    else
        % Nothing, we have defined already the BW_skel
    end
else
    % Nothing, we have defined already the BW_skel
end


% Skeletonization extension
if extendre_skel_opcio
% The skeletonized image must be greater than 1, otherwise the image
% cannot be skeletonized.
    if sum(BW_skel(:)) > 1
        [BW_skel] = skel_elongate(BW_final, BW_skel, "prop", 5);
    end
end


% _Getting the numeric length_
% disp("[Area_Josep] = worm_length(BW_skel);")

% _Data with manual error correction_
[Area_Josep] = worm_length_manual(BW_skel, n_pixel_margin);

Area_Josep_scaled = Area_Josep / escala_imatge; %Es multiplica pel ratio de l'escala (pixels / unitat)

dades_imatge_manual_corrected = Area_Josep_scaled;


% _Data without manual error correction_

[Area_Josep] = worm_length(BW_skel);

Area_Josep_scaled = Area_Josep / escala_imatge; % Multiplies by the scale ratio (pixels / unit)

dades_imatge_row = Area_Josep_scaled;

% % _Check comparison between both distances:_
% Note: the error is 1 pixel, due to the methodology. It is susceptible
% to not being considered.
% [Area_Josep_1] = worm_length_manual(BW_skel, 1)
% [Area_Josep_2] = worm_length(BW_skel)
% if isequal(Area_Josep_1, Area_Josep_2); disp("Equal length"); end


% FINAL SCRIPT


end