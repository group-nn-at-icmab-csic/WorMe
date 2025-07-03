function [BW_final, imatge_original, nom_img_original] = app_interf_actual_img(app)


% INICI FUNCIO

% Obtenció de la imatge última i modificació a binària (sigui una imatge nova o no)
    % _Obtenció imatge original_
n_imatge = str2num(app.img_contLabel.Text);
[imatge_original, nom_img_original] = app_interf_obtain_original(app, n_imatge);
% imatge_original = imread(strcat(dir_img_originals, "\", nom_img_origin));


% _Processament de la imatge original_ 
[BW_final] = app_interf_process_img(app, imatge_original);

% FINAL FUNCIÓ


end