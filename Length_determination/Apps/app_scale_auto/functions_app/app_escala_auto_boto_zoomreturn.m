function app_escala_auto_boto_zoomreturn(app)

% from app_scale_auto App, reutrn Zoom button.

% START OF FUNCTION

    % Original image definition
    imatge_original = app.Image2.ImageSource;

    app.Image.ImageSource = imatge_original;
    % imshow(imatge_original, 'Parent', app.UIAxes);
    
    app.Image3.ImageSource = imatge_original;            

    % Hide the button
    app.ZoomreturnButton.Visible = 'off';

% END FUNCTION

end

