function app_proc_button_close(app)

% In app_image_processing App, the button of close image (CloseButtonPushed).
%
%
% See also
% app_image_processment


% START OF THE FUNCTION

    app.Image2.Visible = 'on';

    % _Add the modification_
    [field_set] = app_proc_obten_fieldset(app);
    % Value of bwareaopen
    valor_modif = app.Spinner_3.Value;
    % Add the modification to the text
    text_modific = strcat("close_disc(", string(valor_modif), ")");
    txt_seg(field_set, text_modific, ";") % configuration tracking


    % VISUALIZATION OF THE MODIFICATIONS
    app_proc_visual_modif(app)



    app.Image2.Visible = 'off';   
% END OF THE FUNCTION


end