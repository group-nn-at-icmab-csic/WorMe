function app_proc_button_modified_img(app)

% In app_image_processing App, the button of Modified.
%
% Shows the image with the modifications.
%
%
% See also
% app_image_processment


% START OF THE FUNCTION

    value_ModifiedButton = app.ModifiedButton.Value;

    if value_ModifiedButton
        app.OriginalButton.Value = false;
        app.MaskedButton.Value = false;
    end


    % VISUALIZATION OF THE MODIFICATIONS
    app_proc_visual_modif(app)


% END OF THE FUNCTION


end