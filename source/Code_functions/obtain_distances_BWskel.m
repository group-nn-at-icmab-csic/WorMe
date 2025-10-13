function [dades_imatge_row, dades_imatge_manual_corrected] = obtain_distances_BWskel(BW_skel, escala_imatge, n_pixel_margin)

% Comes from worm_skeletonization_manual.
% 
%
% -- Variables input:
% -- BW_skel
%       Skeletonized binary image
%
%
% -- escala_imatge
%       Defines the scale at which the image will be scaled, in
%       when calculating its distance.
%       If not defined, this is equal to 1.
%
%
% - n_pixel_margin : pixel margin of the distance calculation with manual error.
%
%
% - dades_imatge_manual_corrected - Data with manual error correction.
%
% - dades_imatge_row - Data without manual error correction.
%
%
% Optimized: 
% worm_skeletonization : Elapsed time is 0.362784 seconds.
%
%
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
% worm_length



% START SCRIPT


% _Obtain numeric length_

% _Data with manual error correction_
[worm_length_dist_manual] = worm_length_manual(BW_skel, n_pixel_margin);

dades_imatge_manual_corrected = worm_length_dist_manual / escala_imatge; % Multiplies by the scale ratio (pixels / unit)


% _Data without manual error correction_

[worm_length_dist_normal] = worm_length(BW_skel);

dades_imatge_row = worm_length_dist_normal / escala_imatge; % Multiplies by the scale ratio (pixels / unit)


% % _Check comparison between both distances:_
% Note: the error is 1 pixel, due to the methodology. It is susceptible
% to not being considered.
% [Area_1] = worm_length_manual(BW_skel, 1)
% [Area_2] = worm_length(BW_skel)
% if isequal(Area_1, Area_2); disp("Equal length"); end


% END SCRIPT


end