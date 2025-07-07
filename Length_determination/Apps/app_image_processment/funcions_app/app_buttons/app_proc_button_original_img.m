function app_proc_button_original_img(app)

% In app_image_processing App, the button of Original (OriginalButton).
%
% Change the image visualization to the original image.
%
%
% See also
% app_image_processment


% START OF THE FUNCTION

            
    value_OriginalButton = app.OriginalButton.Value;
    
    % Unselect buttons
    if value_OriginalButton
        app.MaskedButton.Value = false;
        app.ModifiedButton.Value = false;
    end


    % Change of the button if selected
    if app.OriginalButton.Value
        app.OriginalButton.BackgroundColor = 'y';
    else
        app.OriginalButton.BackgroundColor = [0.96,0.96,0.96];
    end

                
    % Reading of the image button
    fullFileName = app.vapp_ruta_img_origin;
    imatge_original = imread_ifgrey(fullFileName);
    app.Image.ImageSource = imatge_original;


% END OF THE FUNCTION


end