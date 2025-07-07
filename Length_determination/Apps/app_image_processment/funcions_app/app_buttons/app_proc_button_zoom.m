function app_proc_button_zoom(app)

% In app_image_processing App, the button of zoom.
%
%
% See also
% app_image_processment


% START OF THE FUNCTION

    imatge_principal = app.Image.ImageSource;
    
    % Cut the image doing zoom
    [~, xy_punts_a_retall] = imcrop(imatge_principal);
    
    % If a selection was developed:
    if ~isempty(xy_punts_a_retall)
        close
        xy_punts_a_retall = floor(xy_punts_a_retall);
        
        [imatge_primera_retallada] = retallar_imatges_punts(imatge_principal, xy_punts_a_retall);
        %imshow(imatge_primera_retallada)
        
        app.Image.ImageSource = imatge_primera_retallada;
                        

    end            
    
    
    app.ReturnLupa.Visible = 'on';


% END OF THE FUNCTION


end