function app_proc_button_binarize(app)

% In app_image_processing App, the button of binarize (BinarizeButtonPushed).
%
%
% See also
% app_image_processment


% START OF THE FUNCTION


    app.Image2.Visible = 'on';
    
    % _Add the modification_
    [field_set] = app_proc_obten_fieldset(app);
    txt_seg(field_set, "Imbinarize_adaptative_Foreground_dark", ";") % configuration following


    % Visualization of the modifications
    app_proc_visual_modif(app)

    app.Image2.Visible = 'off';

% END OF THE FUNCTION


end