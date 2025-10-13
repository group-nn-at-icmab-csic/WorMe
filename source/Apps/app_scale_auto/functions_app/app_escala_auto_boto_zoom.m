function app_escala_auto_boto_zoom(app)

% from app_scale_auto app, Zoom button.
% START OF FUNCTION

    if isempty(app.Image3.ImageSource)
        imatge_principal = app.Image2.ImageSource;
    else
        imatge_principal = app.Image3.ImageSource;
    end
    
    
    
    % We crop the image when zooming
    [~, xy_punts_a_retall] = imcrop(imatge_principal);
    
    % If a selection has been made
    if ~isempty(xy_punts_a_retall)
        close
        xy_punts_a_retall = floor(xy_punts_a_retall);
        
        [imatge_primera_retallada] = cut_imgs_points(imatge_principal, xy_punts_a_retall);
        
        app.Image.ImageSource = imatge_primera_retallada;
        % imshow(imatge_primera_retallada, 'Parent', app.UIAxes);

        % We also save the small image
        app.Image3.ImageSource = imatge_primera_retallada;
        
        % We make the return image button visible:
        %app.LupaButton_return.Visible = 'on';


        % __We describe new action__
        % Define initial message
        app.Label.Text = "Select the scale bar";
        app.SelectbarButton.Visible = 'on';

    end            
    
    
    % We display buttons
    app.ZoomreturnButton.Visible = 'on';

% END OF FUNCTION


end