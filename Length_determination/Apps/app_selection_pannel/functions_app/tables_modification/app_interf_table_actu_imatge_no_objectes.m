function app_interf_table_actu_imatge_no_objectes(app)

% Update the image and buttons if there is no objects.

    % START OF THE FUNCTION

    [imatge_original, ~] = app_interf_obtain_original(app, str2double(app.img_contLabel.Text)); %  imatge original
    app.Image.ImageSource = image_without_objects(imatge_original);

    % Update buttons
    app_interf_table_actu_botons_objectes(app, false)

    % FINAL OF THE FUNCTION

end