function [imatge_original, nom_img_original] = app_interf_obtain_original(app, n_imatge)

% S'obté la imatge original de les seleccionades (arxiu theFiles) numero 'n_imatge'.


% INICI FUNCIÓ

% _Agafem la imatge posterior a l'actual_
% DEFINICIÓ DE LA IMATGE
% Carpeta de les imatges
carpeta_imatges = app.dir_imgs_orig;

% LECTURA IMATGES .jpg i .png de la carpeta:
% [theFiles] = read_imgs_folder_structure(carpeta_imatges);
theFiles = app.theFiles_arxiu;

% Obtencio imatge
baseFileName = theFiles(n_imatge).name;
fullFileName = fullfile(theFiles(n_imatge).folder, baseFileName);
% Imatge a processar
imatge_original = imread_ifgrey(fullFileName);

% Nom img sortida
nom_img_original = baseFileName;

% FINAL FUNCIÓ


end
