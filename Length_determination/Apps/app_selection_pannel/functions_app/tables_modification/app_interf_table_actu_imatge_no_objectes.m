function app_interf_table_actu_imatge_no_objectes(app)

% Actualitza la imatge i botons si no te objectes.



    [imatge_original, ~] = app_interf_obtain_original(app, str2double(app.img_contLabel.Text)); %  imatge original
    app.Image.ImageSource = image_without_objects(imatge_original);

    % Actu botons
    app_interf_table_actu_botons_objectes(app, false)
    
end