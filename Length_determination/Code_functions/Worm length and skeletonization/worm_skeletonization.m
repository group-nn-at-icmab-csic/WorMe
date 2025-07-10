function [BW_skel, dades_imatge, dades_imatge_corrected] = worm_skeletonization(BW_final, escala_imatge, extendre_skel_opcio, reduce_line)

% Given a binary image and its scale, its skeletonized image and the distance to that scaled image are returned.
%
% Diferent than worm_skeletonization_manual, here the manual error
% pixels are fixed (every 5 pixels, which was the lower error).
%
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
% OPITMIZED: 
% worm_skeletonization : Elapsed time is 0.362784 seconds.
%
%
% An initial normal image is also added for a final plot.
% UPGRADE:
% - The original image is not considered
% - there can only be one binary object
% - All variables must be defined
%
% Variables example
% BW_final = BW_llistat_imatges;
% I1 = imageArray;
% escala_imatge = escala_imatge;
% extendre_skel_opcio = 1;
%
%
%
% See also
% large_skel
% skel_elongate
% worm_length
% worm_skeletonization_manual

% START SCRIPT


% general skeletonization
BW_skel = bwskel(BW_final);

% endpoints take
endpoints_BW = find(bwmorph(BW_skel,'endpoints'));
%find(bwmorph(BWskel_1,'branchpoints'));


if reduce_line % If line reduction is applied:
    if numel(endpoints_BW)>2
        % vell: [BW_skel, ~] = longestConstrainedPath_Josep(BW_final, "thinOpt", "thin");
        % [BW_skel] = large_skel(BW_skel);
        [BW_skel] = large_skel_iter(BW_skel); % Upgrade josep 11/09/2022
    else
        % Nothing, we have defined the BW_skel
    end
else
    % Nothing, we have defined the BW_skel
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
% [Area_Josep] = worm_length(BW_skel)
[Area_Josep] = worm_length_manual(BW_skel, 5);
Area_Josep_scaled = Area_Josep / escala_imatge; % Multiplies by the scale ratio (pixels / unit)
dades_imatge_corrected = Area_Josep_scaled;

% % _Check comparison between both distances:_
% Note: the error is 1 pixel, due to the methodology. It is susceptible
% to not being considered.
% [Area_Josep_1] = worm_length_manual(BW_skel, 1)
% [Area_Josep_2] = worm_length(BW_skel)
% if isequal(Area_Josep_1, Area_Josep_2); disp("Equal length"); end

[Area_Josep] = worm_length(BW_skel);

Area_Josep_scaled = Area_Josep / escala_imatge; % Multiplies by the scale ratio (pixels / unit)

dades_imatge = Area_Josep_scaled;



% END SCRIPT


end