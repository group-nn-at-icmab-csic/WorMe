function app_escala_auto_boto_zoomreturn(app)

% From app_escala_auto App, reutrn Zoom button.

% START OF FUNCTION

    % Definició imatge original
    imatge_original = app.Image2.ImageSource;

    app.Image.ImageSource = imatge_original;
    % imshow(imatge_original, 'Parent', app.UIAxes);
    
    app.Image3.ImageSource = imatge_original;            
    % Amaguem el botó
    app.ZoomreturnButton.Visible = 'off';

% END FUNCTION

end

