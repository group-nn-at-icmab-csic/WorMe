function app_proc_button_binarise_by_value(app)

% In app_image_processing App, the button of binarize by value.
%
% Binarize the image by the value threshold settled.
%
% See also
% app_image_processment


% START OF THE FUNCTION
            % Value of the Slider:
    binarize_value = app.BinarizeSlider.Value;
   
    
    
    app.Image2.Visible = 'on';
    
    % _Add the modification_
    [field_set] = app_proc_obten_fieldset(app);
    % Add the modification to the text
    text_modific = strcat("binarize_by_value(", string(binarize_value), ")");
    txt_seg(field_set, text_modific, ";") % configuration tracking           


    % VISUALIZATION OF THE MODIFICATIONS
    app_proc_visual_modif(app)

    app.Image2.Visible = 'off';


% END OF THE FUNCTION


end