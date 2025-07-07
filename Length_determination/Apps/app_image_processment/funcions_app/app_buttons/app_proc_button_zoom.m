function app_proc_button_zoom(app)

% In app_image_processing App, the button of zoom.
%
%
% See also
% app_image_processment


% START OF THE FUNCTION

    imatge_principal = app.Image.ImageSource;
    
    % Retallem la imatge en fer zoom
    [~, xy_punts_a_retall] = imcrop(imatge_principal);
    
    %Si s'ha realitzat una selecció
    if ~isempty(xy_punts_a_retall)
        close
        xy_punts_a_retall = floor(xy_punts_a_retall);
        
        [imatge_primera_retallada] = retallar_imatges_punts(imatge_principal, xy_punts_a_retall);
        %imshow(imatge_primera_retallada)
        
        app.Image.ImageSource = imatge_primera_retallada;
                        
        
        % _Mostrar la imatge en un UIAxes_
        % ÇÇÇ AUGMENTA MOLT LA QUALITAT, ÉS LO SEU.
        % imshow("PNG_BW.png", 'Parent', app.UIAxes); 
        
        % Fem visible el botó de return de la imatge:
        %app.LupaButton_return.Visible = 'on';
    end            
    
    
    app.ReturnLupa.Visible = 'on';


% END OF THE FUNCTION


end