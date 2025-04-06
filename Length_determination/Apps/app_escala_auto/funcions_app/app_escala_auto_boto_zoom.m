function app_escala_auto_boto_zoom(app)

% From app_escala_auto app, Zoom button.

% START OF FUNCTION

    if isempty(app.Image3.ImageSource)
        imatge_principal = app.Image2.ImageSource;
    else
        imatge_principal = app.Image3.ImageSource;
    end
    
    
    
    % Retallem la imatge en fer zoom
    [~, xy_punts_a_retall] = imcrop(imatge_principal);
    
    %Si s'ha realitzat una selecció
    if ~isempty(xy_punts_a_retall)
        close
        xy_punts_a_retall = floor(xy_punts_a_retall);
        
        [imatge_primera_retallada] = retallar_imatges_punts(imatge_principal, xy_punts_a_retall);
        
        app.Image.ImageSource = imatge_primera_retallada;
        % imshow(imatge_primera_retallada, 'Parent', app.UIAxes);

        % Guardem també en imatge en petit
        app.Image3.ImageSource = imatge_primera_retallada;
        
        % Fem visible el botó de return de la imatge:
        %app.LupaButton_return.Visible = 'on';


        % __Describim nova acció__
        % Definim missatge inicial
        app.Label.Text = "Select the scale bar";
        app.SelectbarButton.Visible = 'on';

    end            
    
    
    % Mostrem botóns
    app.ZoomreturnButton.Visible = 'on';

% END OF FUNCTION

end