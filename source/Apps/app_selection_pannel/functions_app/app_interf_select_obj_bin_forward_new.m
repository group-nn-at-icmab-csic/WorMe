function [proc_BW, new_img, num, BW_final_object, BW_final_noproc, imatge_original, isdrawline] = app_interf_select_obj_bin_forward_new(app, number_BW, BW_final_noproc, dir_output, imatge_original)

% Selects the binary objects from the image and returns them if there are any,
% otherwise returns the newly processed image.
% Function from the app 'app_selection_pannel'.
%
% Upgrade: Incorporation of draw line table for its selection.
%
% Variables
% number_BW : number of binary objects (from unprocessed BW objects 'BW_final_noproc')

% START FUNCTION

% If there is any binary object
if number_BW > 0

    [BW_final_object, num] = app_interf_take_unique_obj(BW_final_noproc);
    
    % Note: if there is no object it will appear as zeros.

    % We obtain the draw tables
    [S_textscan_table_filtred_drawline, taula_dibuix_filted_nonproc] = app_interf_select_drawline(app);
    
    % _Check if it advances one object from the draw table_
    [BW_final_object, num, isdrawline] = app_interf_determina_BW_obj_draw(taula_dibuix_filted_nonproc, BW_final_object, num);
    % imshow(BW_final_object)

    % Define whether it is a drawn line or not:
    

    % Define precedence counters
    proc_BW = true; % Flag indicating the end has not been reached    
    new_img = false; % Flag for new image


    % Change original button:
    app.OriginalButton.Value = false;

% If there are no more binary objects:
else
    % _Continue with the next image_
    [BW_final, BW_final_object, BW_final_noproc, imatge_original, proc_BW, new_img, num] = app_interf_precedencia_img(app, dir_output);
    
    isdrawline = false;


end


% END FUNCTION



end