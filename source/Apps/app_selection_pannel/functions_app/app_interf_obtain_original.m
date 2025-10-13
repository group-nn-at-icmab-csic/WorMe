function [imatge_original, nom_img_original] = app_interf_obtain_original(app, n_imatge)

% The original image is obtained from the selected ones (file theFiles) number 'n_imatge'.

% START FUNCTION

% _We take the image after the current one_
% IMAGE DEFINITION
% Folder of the images
carpeta_imatges = app.dir_imgs_orig;

% READING .jpg and .png IMAGES from the folder:
% [theFiles] = read_imgs_folder_structure(carpeta_imatges);
theFiles = app.theFiles_arxiu;

% Obtaining the image
baseFileName = theFiles(n_imatge).name;
fullFileName = fullfile(theFiles(n_imatge).folder, baseFileName);
% Image to be processed
imatge_original = imread_ifgrey(fullFileName);

% Name of the output image
nom_img_original = baseFileName;

% END FUNCTION



end
