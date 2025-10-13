function [BW_final_object, num, isdrawline] = app_interf_determina_BW_obj_draw(taula_dibuix_filted_nonproc, BW_final_object, num)


% Determines if, given a binary image with a binary object, there should be
% the selection of a draw object.
%
%
% Variables
%   input:
%       BW_final_object : single BW object
%       num : number of objects
%   output
%       isdrawline : counter if it is or not draw
%       taula_dibuix_filted_nonproc : table of unprocessed draws
%       BW_final_object : single BW object
% 

% FUNCTION START


% If there are draw objects:
if ~isempty(taula_dibuix_filted_nonproc)

    % We sum the value of the control variable 'num'
    num = height(taula_dibuix_filted_nonproc);

    % If the 'image index' is earlier, this is done, otherwise the
    % draw object one is done:
    if min(find(BW_final_object)) < min(appf_split_strindex(taula_dibuix_filted_nonproc.Indx_skel)) %#ok 
        isdrawline = false;
    else
        isdrawline = true;

        % We take the drawline with the lowest index value:
        [taula_dibuix_minima] = app_interf_min_indx_drawtable(taula_dibuix_filted_nonproc);
    
        % We obtain the image with the last object:
        BW_final_object = false(double([appf_split_strindex(taula_dibuix_minima.Resolution)']));
        BW_final_object(appf_split_strindex(taula_dibuix_minima.Indx_skel)) = true;
            
    end
else
    isdrawline = false; % Defines if the object or a binary image is obtained.
end



% FUNCTION END




end