function app_interf_boto_dreta(app)

% Right Button

% START OF FUNCTION

    % ___Right modification___
    n_imatge = str2num(app.img_contLabel.Text);
    
    % We increment counters
    app.img_contLabel.Text = string(n_imatge +1);
    % _image name_
    [~ , nom_img_original] = app_interf_obtain_original(app, n_imatge+1);        % Obtain image name
    app.img_original_nomLabel.Text = nom_img_original;         % Update image name

    
    
    % __Update and Plotting__ %
    app.imcrop_value = [];
    app_interf_actualitzacio_graficacio(app, false)
    
    % Previous image
    app_interf_determinar_ultim_object(app, false, "no_res")
    
    % We refresh figure to enable shortkey
    figure(app.UIFigure)  


% END OF FUNCTION


end