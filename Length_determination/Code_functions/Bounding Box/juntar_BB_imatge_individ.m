function [im_BB_rel_original_BBcol] = juntar_BB_imatge_individ(imatge_input_original,  nom_imatge_original, carpeta_BB_BW_color)

% Merge the BB with the original image, applied only to one image.
% Based on the function 'suma_semiBW_norm_millorat'
%
% We look at the images in the BB BW color folder.
% From the image name, we add to the image those BBs that contain the same original name.
%
% Variables
% imatge_input_original        : image to add the BBs to
% nom_imatge_original          : name of the image
% carpeta_BB_BW_color          : folder with the BB color images
%
% Internal variables
% im_BB_rel_original : original image corresponding to the BB image name
% im_BB_BW_color     : selected BB color image corresponding to the name
% 
% See also
% suma_semiBW_norm_millorat
% juntar_BB_imatge_nou3


% FUNCTION START


[theFiles_imresult_BB_BW_color] = lectura_imatges_carpeta_estr(carpeta_BB_BW_color); % Lectura imatges
llargada_theFiles_BB_BW_color = length(theFiles_imresult_BB_BW_color);
% each loop was: cada_nom_array

% Assuming we provide the original image


% _Add BB_
% For each BB BW color image that matches the name, we add
% the BB BW

% We make a copy of the original image. 'im_BB_rel_original_BBcol' will be
% the one that keeps storing the BBs.

im_BB_rel_original_BBcol = imatge_input_original;

for cada_n_BB = 1:llargada_theFiles_BB_BW_color
    % Obtenim nom original
    nom_ex = theFiles_imresult_BB_BW_color(cada_n_BB).name;
    split_nom = split(nom_ex, "_skel");
    nom_orign_imBB = split_nom(1);
    % If the name of the BB we are looking at (nom_orign_imBB) matches the
    % name of the BB BW color image being read (nom_orign_imBB), it is the image
    % we are interested in.
    
    % We normalize the names of the input images, to select and
    % copy all those BB color images that match them.

    split_nom = split(nom_imatge_original, "_skel");
    if length(split_nom) == 1
        cada_nom_array_splited = split_nom;
    else
        cada_nom_array_splited = split_nom(1);
    end

    if strcmp(nom_orign_imBB, cada_nom_array_splited)
        baseFileName_BB = theFiles_imresult_BB_BW_color(cada_n_BB).name;
        fullFileName_BB = fullfile(theFiles_imresult_BB_BW_color(cada_n_BB).folder, baseFileName_BB);

        % Obtenim la imatge BW BB en color
        im_BB_BW_color = imread(fullFileName_BB); % Imatge inicial

        % _Sum BB col a original_
        % sum this to original
        im_BB_rel_original_BBcol = suma_semiBW_norm_millorat(im_BB_rel_original_BBcol, im_BB_BW_color);


    end



end


% FINAL OF THE FUNCTION

end