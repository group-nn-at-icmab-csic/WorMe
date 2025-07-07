function app_proc_button_imadjust(app)

% In app_image_processing App, the button of imadjust modification.
%
%
% See also
% app_image_processment


% START OF THE FUNCTION

    app.Image2.Visible = 'on';
    
    % _Afegim la modificació_
    [field_set] = app_proc_obten_fieldset(app);
    txt_seg(field_set, "imadjust", ";")

    % VISUALIZATION OF THE MODIFICATIONS
    app_proc_visual_modif(app)

    app.Image2.Visible = 'off';


% END OF THE FUNCTION


end