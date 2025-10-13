function app_escala_linia_boto_zoomreturn(app)

% from app_scale_line App, the Zoom return button.

% START OF FUNCTION

    % Definition of the original image
    imatge_original = app.Image2.ImageSource;

    app.Image.ImageSource = imatge_original;
    
    app.Image3.ImageSource = imatge_original;            

    % Hide the button
    app.ZoomreturnButton.Visible = 'off';

% END OF FUNCTION

end