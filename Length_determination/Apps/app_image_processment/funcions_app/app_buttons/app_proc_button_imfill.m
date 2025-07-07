function app_proc_button_imfill(app)

% In app_image_processing App, the button of imfill (imfillButtonPushed).
%
%
% See also
% app_image_processment


% START OF THE FUNCTION

    app.Image2.Visible = 'on';
    
    % _Afegim la modificació_
    [field_set] = app_proc_obten_fieldset(app);
    % Afegim al text la modificació
    txt_seg(field_set, "imfill", ";") % seguiment config.


    % VISUALIZATION OF THE MODIFICATIONS
    app_proc_visual_modif(app)            


    app.Image2.Visible = 'off'; 
           

% END OF THE FUNCTION


end