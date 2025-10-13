function app_proc_button_im2gray(app)

% In app_image_processing App, the button of grayscale the image (Im2greyButtonPushed).
%
%
% See also
% app_image_processment


% START OF THE FUNCTION


    app.Image2.Visible = 'on';
    
    % _Add the modification_
    [field_set] = app_proc_obten_fieldset(app);
    txt_seg(field_set, "Im2gray", ";") % config tracking


    % Visualization of the modifications
    app_proc_visual_modif(app)

    app.Image2.Visible = 'off';       


% END OF THE FUNCTION


end