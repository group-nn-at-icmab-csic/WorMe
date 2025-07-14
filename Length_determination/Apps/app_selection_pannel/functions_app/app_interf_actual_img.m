function [BW_final, imatge_original, nom_img_original] = app_interf_actual_img(app)


% FUNCTION START

% Obtaining the latest image and converting to binary (whether it is a new image or not)
    % _Obtaining original image_
n_imatge = str2num(app.img_contLabel.Text);
[imatge_original, nom_img_original] = app_interf_obtain_original(app, n_imatge);


% _Processing the original image_ 
[BW_final] = app_interf_process_img(app, imatge_original);

% FUNCTION END


end