function [nom_im_carpeta_coincident] = compara_en_carpeta_nom_BW_coincident(BW_aillar, nom_BW_modif, carpeta_imatges_BW_totes)
% Function to read folders by name. In this case, it compares binary 
% objects to find the name of the matching file.
%
%
% Objective: read from Conjunt_BW_totes, a folder that stores binary 
% objects. Then, the name of the matching image is obtained in order to 
% later retrieve the colored bounding box (BB) of the image and change its color.
%
%
% Variables
% input
% BW_aillar : binary image to compare
% nom_BW_modif : original name of the binary image. This will be the filter 
%                to compare those images that match the name.
% carpeta_imatges_BW_totes : folder containing the images to compare
% 
% output
% nom_im_carpeta_coincident : name of the matching file.
%                             note: if no object is found, an empty object 
%                             is returned [].
%
% % Example variables
% % Original name of the image to compare.
% nom_BW_modif = "P1011629";
% % Folder reading binary images with only one object.
% carpeta_imatges_BW_totes = "C:\Users\Josep TOSHIBA\Desktop\Length determination v2_6\Results_out\20220318_1335_Input_images_Amanda_poques\Processades\Conjunt_BW_totes";
% % Image to compare
% BW_aillar = imread("C:\Users\Josep TOSHIBA\Desktop\Length determination v2_6\Results_out\20220318_1335_Input_images_Amanda_poques\Processades\Conjunt_BW_totes\P1011629_skel_00003_02.JPG");
% BW_aillar = imbinarize(BW_aillar);
%
% See also
% lectura_imatges_carpeta_estr
% compara_BW_objecte_coincident


% START FUNCTION

% control of the coincident images number.
cont_contrl_im_coincid = 0;

% Variables to save
nom_im_carpeta_coincident = [];

[theFiles_carpetaBB] = lectura_imatges_carpeta_estr(carpeta_imatges_BW_totes);


for cada_imatge = 1:length(theFiles_carpetaBB)
    
    % We obtain the file name
    nom_carpeta_files = theFiles_carpetaBB(cada_imatge).name;
    nom_carpeta_files_t = strsplit(nom_carpeta_files, "_skel");
    nom_carpeta_files_original = string(nom_carpeta_files_t(1));
    
    
    % We compare if it is as our image
    if strcmp(nom_BW_modif, nom_carpeta_files_original)
        % If the name is the same as the original, we proceed to compare the image with
        % ours.
        
        % We obtain the binary image
        imatge_a_llegir = imread(strcat(theFiles_carpetaBB(cada_imatge).folder, "\", theFiles_carpetaBB(cada_imatge).name));
        
        % Binaritze ( o no)
        if length(unique(imatge_a_llegir(:))) > 2
            imatge_a_llegir = imbinarize(imatge_a_llegir);
        else
            imatge_a_llegir = imatge_a_llegir;
        end


        % _Comparison between binary images_
        [llist_BW_identif, BW_bwselect_igual_punts, imatge_montatge_sortida] = compara_BW_objecte_coincident(imatge_a_llegir, BW_aillar);

        % Variables
        % BW_conjuntes_comparar  : image to compare
        % BW_aillar_skel         : image with a single object to compare with the other.
        

        % Now we check if it is empty. If it is, it means there is no image,
        % but if it is not, it means a matching image is found.
        if ~isempty(llist_BW_identif)
            % There is image
            
            % We save the name of the coincident image.
            nom_im_carpeta_coincident = nom_carpeta_files;
            
            % We save the control
            cont_contrl_im_coincid = cont_contrl_im_coincid+1;
            
        end
        
    end
    
end


% Control
if isempty(cont_contrl_im_coincid)
    % There is no coincident image
    f = msgbox("No compared object", 'Error','error');
    
else
    if cont_contrl_im_coincid > 1
        % If there is image, but more than one:
        f = msgbox("More than a compared object", 'Error','error');
        error("f'compara_en_carpeta_nom_BW_coincident': More than a compared object")
    end
end
   

% FINAL of the function


end