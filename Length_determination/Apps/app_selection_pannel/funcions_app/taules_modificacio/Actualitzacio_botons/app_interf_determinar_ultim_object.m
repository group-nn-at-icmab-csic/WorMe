function app_interf_determinar_ultim_object(app, BB_values, tipus_det)

% Determina si l'ultim objecte és present, graficant aquest.

% INICI FUNCIÓ

% BB_values = appf_split_strindex(no_modified_object_modificada.Bounding)';

if isequal(tipus_det, "thick") || isequal(tipus_det, "cross")
    % Determinem ultim objecte

    [imatge_original, ~] = app_interf_obtain_original(app, str2double(app.img_contLabel.Text));
    img_original_cuted = imcrop(imatge_original, BB_values);
    app.Image2.ImageSource = img_original_cuted;
    app.Image2.Visible = 'on';
    app.Image3.Visible = 'on';
    app.LastmodifLabel.Visible = 'on';
    
    if isequal(tipus_det, "thick")
        app.Image3.ImageSource = "Apps\app_selection_pannel\Imatges_utilitat\greentick.png";
    else
        app.Image3.ImageSource = "Apps\app_selection_pannel\Imatges_utilitat\cross.png";        
    end
else
    app.Image2.Visible = 'off';
    app.Image3.Visible = 'off';    
    app.LastmodifLabel.Visible = 'off';
end

% FINAL FUNCIÓ

end