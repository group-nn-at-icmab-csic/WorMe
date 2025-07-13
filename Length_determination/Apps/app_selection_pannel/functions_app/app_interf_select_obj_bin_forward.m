function [proc_BW, new_img, num, BW_final_object, BW_final_noproc, imatge_original] = app_interf_select_obj_bin_forward(app, number_BW, BW_final_noproc, dir_output, imatge_original)

% Selects the binary objects from the image and returns them if there are any,
% otherwise returns the newly processed image.
% Function from the app 'app_selection_pannel'.
%
%
%
% Variables
% number_BW : number of binary objects (from unprocessed BW objects 'BW_final_noproc')

% START FUNCTION

% If there is any binary object
if number_BW > 0

    [BW_final_object, num] = app_interf_take_unique_obj(BW_final_noproc);

    % Define precedence flags
    proc_BW = true; % Flag indicating the end has not been reached    
    new_img = false; % Flag for new image

    % Change buttons: deselect original button
    app.OriginalButton.Value = false;

% If there are no more binary objects:
else
    % _Continue with the next image_
    [BW_final, BW_final_object, BW_final_noproc, imatge_original, proc_BW, new_img, num] = app_interf_precedencia_img(app, dir_output);

end

% END FUNCTION


end