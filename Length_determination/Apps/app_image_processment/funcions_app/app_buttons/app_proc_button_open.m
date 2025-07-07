function app_proc_button_open(app)

% In app_image_processing App, the button of image open (OpenButtonPushed).
%
%
% See also
% app_image_processment


% START OF THE FUNCTION

    app.Image2.Visible = 'on';
        % _Add the modification_
    [field_set] = app_proc_obten_fieldset(app);
    
    % Value of bwareaopen
    valor_modif = app.Spinner_2.Value;
    
    % Add the modification to the text
    text_modific = strcat("open_disc(", string(valor_modif), ")");
    txt_seg(field_set, text_modific, ";") % config tracking.

    
    
    % VISUALIZATION OF THE MODIFICATIONS
    app_proc_visual_modif(app)
    
    
    app.Image2.Visible = 'off';   


% END OF THE FUNCTION


end