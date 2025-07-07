function app_proc_button_open(app)

% In app_image_processing App, the button of image open (OpenButtonPushed).
%
%
% See also
% app_image_processment


% START OF THE FUNCTION

    app.Image2.Visible = 'on';
    
    % _Afegim la modificació_
    [field_set] = app_proc_obten_fieldset(app);
    
    % Valor del bwareaopen
    valor_modif = app.Spinner_2.Value;
    
    % Afegim al text la modificació
    text_modific = strcat("open_disc(", string(valor_modif), ")");
    txt_seg(field_set, text_modific, ";") % seguiment config.
    
    
    % VISUALIZATION OF THE MODIFICATIONS
    app_proc_visual_modif(app)
    
    
    app.Image2.Visible = 'off';   


% END OF THE FUNCTION


end