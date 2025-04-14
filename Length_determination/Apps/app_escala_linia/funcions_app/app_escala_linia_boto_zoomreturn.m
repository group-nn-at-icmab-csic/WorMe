function app_escala_linia_boto_zoomreturn(app)

% From app_escala_linia App, the Zoom return button.

% START OF FUNCTION

    % Definició imatge original
    imatge_original = app.Image2.ImageSource;

    app.Image.ImageSource = imatge_original;
    
    app.Image3.ImageSource = imatge_original;            
    % Amaguem el botó
    app.ZoomreturnButton.Visible = 'off';

% END OF FUNCTION

end