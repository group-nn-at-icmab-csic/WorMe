function app_proc_button_masked_image(app)

% In app_image_processing App, the button of Mask.
%
% Shows the binary image in the main image.
%
% See also
% app_image_processment


% START OF THE FUNCTION

    value_MaskedButton = app.MaskedButton.Value;

    if value_MaskedButton
        app.OriginalButton.Value = false;
        app.ModifiedButton.Value = false;
    end

    % Cambiem color botó segons seleccionat
    if app.OriginalButton.Value
        app.OriginalButton.BackgroundColor = 'y';
    else
        app.OriginalButton.BackgroundColor = [0.96,0.96,0.96];
    end



    % VISUALIZATION OF THE MODIFICATIONS
    app_proc_visual_modif(app)


% END OF THE FUNCTION


end