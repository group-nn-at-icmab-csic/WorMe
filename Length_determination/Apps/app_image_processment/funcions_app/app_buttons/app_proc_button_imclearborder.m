function app_proc_button_imclearborder(app)

% In app_image_processing App, the button of imclearborder (imclearborderButtonPushed).
%
%
% See also
% app_image_processment


% START OF THE FUNCTION

    app.Image2.Visible = 'on';
    
    % _Add the modification_
    [field_set] = app_proc_obten_fieldset(app);

    % Add the text to the modification
    txt_seg(field_set, "Imclearborder", ";") % seguiment config.
    
    % VISUALIZATION OF THE MODIFICATIONS
    app_proc_visual_modif(app)
    
    
    app.Image2.Visible = 'off'; 

% END OF THE FUNCTION


end