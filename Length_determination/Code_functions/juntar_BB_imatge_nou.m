function juntar_BB_imatge_nou(carpeta_input, carpeta_BB_BW_color, carpeta_BB_merge_original, array_noms_im)

% Merge the BB with the original image
% Based on the function 'suma_semiBW_norm_millorat'
%
% We look at the folders of the BB BW color images, and the originals.
% From the array of original names we have, we check if the
% images match. On one hand, we get the original image and on the other all the BB
% BW color images that match the name, and we merge them together.
%
% Folders:
% carpeta_input             : original images folder
% carpeta_BB_BW_color       : BB BW color folder
% carpeta_BB_merge_original : folder of combined original and BB color images.
%
% Variables
% carpeta_input             : input folder for original images
%                               e.g., 'C:\Users\Josep TOSHIBA\Desktop\Length determination v2_5\_Extern\Imatges exemple\Input_images_Amanda_poques'
% carpeta_BB_BW_color       : input folder for Bounding Box color images.
%                               e.g., ' "C:\Users\Josep TOSHIBA\Desktop\Length determination v2_5\Results_out\20220318_0958_Input_images_Amanda_poques\Processades\Conjunt_BB_BW_color"'
%
% carpeta_BB_merge_original : folder where processed images are saved
%                               e.g., "C:\Users\Josep TOSHIBA\Desktop\Length determination v2_5\Results_out\20220318_0958_Input_images_Amanda_poques\Processades\Conjunt_BB_aplicat"
%
% array_noms_im             : array with the names of the images to be obtained.
%                               e.g., "P1011624"    "P1011625"    "P1011629"    "P1011630"    "P1011655"
%
% Internal variables
% im_BB_rel_original : original image corresponding to the BB image name
% im_BB_BW_color     : selected BB color image corresponding to the name
%
% FUNCTION START


[theFiles_imresult_original] = lectura_imatges_carpeta_estr(carpeta_input); % Lectura imatges
llargada_theFiles_original = length(theFiles_imresult_original);

[theFiles_imresult_BB_BW_color] = lectura_imatges_carpeta_estr(carpeta_BB_BW_color); % Lectura imatges
llargada_theFiles_BB_BW_color = length(theFiles_imresult_BB_BW_color);


% For imatge original of BB BW in color
for cada_nom_array = array_noms_im
    
    % Whoe percentage of the process
    [~ , posicio_nomarray] = ismember(cada_nom_array, array_noms_im', 'rows');
    disp(strcat("Processing: ", string(posicio_nomarray), "/", string(length(array_noms_im)), " images"))
    
    % Obtain original image
    for cada_n_original = 1:llargada_theFiles_original
        nom_ex = theFiles_imresult_original(cada_n_original).name;
        strsplit(nom_ex, "_skel")
        
        [nom_im_orig_unic, file_im_original] = separar_puntfile(nom_ex);
        if strcmp(cada_nom_array, nom_im_orig_unic)
            baseFileName_origin = theFiles_imresult_original(cada_n_original).name;
            split_nom = split(baseFileName_origin, "_skel");
            if length(split_nom) == 1
                baseFileName_origin = split_nom;
            else
                baseFileName_origin = split_nom(1);
            end
        
            fullFileName_origin = fullfile(theFiles_imresult_original(cada_n_original).folder, baseFileName_origin);

            % Obtain original image
            im_BB_rel_original = imread(fullFileName_origin); % Imatge inicial
            
            % Obtain name of the original image
            nom_im_orig_unic_bo = nom_im_orig_unic;
            file_im_original_bo = file_im_original;
        end
    end
        % _Add BB_
    % For each BB BW color image that matches the name, we add
    % the BB BW
    
    % We make a copy of the original image. 'im_BB_rel_original_BBcol' will be
    % the one that keeps storing the BBs.

    im_BB_rel_original_BBcol = im_BB_rel_original; 
    
    for cada_n_BB = 1:llargada_theFiles_BB_BW_color
        % Obtenim nom original
        nom_ex_temp = theFiles_imresult_BB_BW_color(cada_n_BB).name;
        split_nom = split(nom_ex_temp, "_skel");
        if length(split_nom) == 1
            nom_ex = split_nom;
        else
            nom_ex = split_nom(1);
        end

        % If the name of the BB we are viewing (nom_orign_imBB) matches the
        % name of the BB BW color image being read (nom_orign_imBB), it is the image
        % we are interested in.

        if strcmp(nom_orign_imBB, cada_nom_array)
            baseFileName_BB = theFiles_imresult_BB_BW_color(cada_n_BB).name;
            fullFileName_BB = fullfile(theFiles_imresult_BB_BW_color(cada_n_BB).folder, baseFileName_BB);

            % Obtenim la imatge BW BB en color
            im_BB_BW_color = imread(fullFileName_BB); % Imatge inicial
            
            % _Sumar BB col a original_
            % Procedim a sumar aquesta a la original
            im_BB_rel_original_BBcol = suma_semiBW_norm_millorat(im_BB_rel_original_BBcol, im_BB_BW_color);
            

            
        end
        
        % SAVE LA IMATGE
        % Definim el name
        nom_BB_merge_original = strcat(nom_im_orig_unic_bo, file_im_original_bo);         
        write_josep(im_BB_rel_original_BBcol, carpeta_BB_merge_original, 1, nom_BB_merge_original);
        %imshow(im_BB_rel_original_BBcol)


    end

end

% FINAL FUNCtion

end