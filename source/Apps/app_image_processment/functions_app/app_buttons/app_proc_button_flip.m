function app_proc_button_flip(app)

% In app_image_processing App, the button of Flip.
% Reverse the binary values of the image.
%
%
% See also
% app_image_processment


% START OF THE FUNCTION

    app.Image2.Visible = 'on';
    
    % _Add the modification_
    [field_set] = app_proc_obten_fieldset(app);
    % Add the modification to the text
    txt_seg(field_set, "Flip", ";") % config tracking.

    % VISUALIZATION OF THE MODIFICATIONS
    app_proc_visual_modif(app)

    app.Image2.Visible = 'off';



% END OF THE FUNCTION


end