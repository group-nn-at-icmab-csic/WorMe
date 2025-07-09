function [llist_BW_identif, BW_bwselect_igual_punts, imatge_montatge_sortida] = identify_pump_previous_new(im_compare_ini, im_pharx_ant, im_croped_graf, test_ext_si_no, test_directori_sortida)
% Given a binary image, it checks which objects fit into a binary image
% superimposed on it.
%
% Differences compared to version 1:
% Mainly, version 2 was made because the program execution was
% very slow, mainly due to the execution of the bwselect function for
% each pixel.
% The variable 'im_compare_ini' has the object
% value 1, not value 0 as before, that is, the binarized image is
% inverted.
%
%
% Variables
% Input
% -----
% im_compare_ini - from the current frame, the binarized image. The object has value 1.
% im_pharx_ant - singular binary object to compare with the frame that theoretically follows (im_compare_ini). The object also has value 1.
% im_croped_graf - from the current frame, the colored image.
%
% Function operation (explanation):
% --
% x_find_pharx and y_find_pharx are obtained, which are the points where
% the binary image of the singular object (im_pharx_ant) coincides
% with the binary image of the current frame (im_compare_ini). This way,
% the coincident points are identified.
% --
%
%  [x_find_pharx, y_find_pharx] - x and y points of the previous binary image.
%                                 These serve to see which image
%                                 coincides with the following one, and if it has
%                                 more than one binary object.
%
% BW_pharx_post - For each point of the previous binary image, a
%                 bwselect is done where the binary object of the point is selected.
%                 From here, it is checked if this is the same along
%                 the different points of the first binary image, or
%                 if different binary objects appear at different points
%                 (BW_pharynx_post).
%
% BW_pharx_post_noc - Binary image with the detected object at the
%                     coincident point between the binary image of frame 1 (only pharynx),
%                     with the unfiltered binary image of frame 2.
%
% test_ext_si_no - (1 = yes, 0 = no) (optional) if graphical test extension is done. If so, the folder must be specified.
%
% test_directori_sortida - main directory of the file.
%
% Tracking several equal objects
% BW_bwselect_igual - stores the coincident binary image, as well as the images of the different coincident objects.
% BW_bwselect_igual_punts - same but with points.
%
%
% % MATLAB Live test
% % Example test variables used in the program
%
% % _Initial frame images_
% im_croped_graf = I1;
% im_compare_ini = ~I1greyAdj_nouBW;
%
% % combination in imoverlay
% im_combi_overlay_primer = imoverlay(im_croped_graf, im_compare_ini, "y");
% imshow(im_combi_overlay_primer)
%
% % _Previous frame images_
% im_pharx_ant = BW_pharx_anterior;
% im_combi_overlay_posterior_preanalisis = imoverlay(im_combi_overlay_primer, im_pharx_ant, "r");
% imshow(im_combi_overlay_posterior_preanalisis)
%
% imshowpair(im_combi_overlay_primer, im_combi_overlay_posterior_preanalisis, "montage")



% START FUNCTION

% If it is not defined whether or not the graphical extension of the test is done, it is understood that it is not done.
if test_ext_si_no == 1 % ~exist('test_ext_si_no','var')
    test_ext_si_no = true;
else
    test_ext_si_no = false;
end



im_compare_ini_inv = ~im_compare_ini;

% To compare:
% imshow(im_pharx_ant)
% imshow(im_compare_ini_inv)

% Graph coincidents
suma_coincid = im_pharx_ant + ~im_compare_ini_inv;
% imshow(suma_coincid, [])
coincidencia_BW = suma_coincid==2;
% imshow(coincidencia_BW)


% Points of the pharynx pump BW initial
[x_find_pharx, y_find_pharx] = find(coincidencia_BW);
% El mateix valor però en coordenades:
try
    coordena_pharx = sub2ind(size(im_pharx_ant), y_find_pharx, x_find_pharx);
catch ME
    %disp("Catchete bueno")
    coordena_pharx = sub2ind(size(im_pharx_ant), x_find_pharx, y_find_pharx);
end

% __Binary image selection__
% We simply use bwselect with the coordinates where they coincide, and we split
% the binary objects using the function 'divide_imgs_binary', which
% is based simply on the built-in function 'bwlabel'.

% bwselect with not just one point but many
[BW_pharx_post_noc, punts_noc] = bwselect(~im_compare_ini_inv, y_find_pharx, x_find_pharx);

% Now we have separated the image and only the matching ones remain. 
% Let's apply the function 'divide_imgs_binary' to obtain
% a list of the binary objects.
llist_BW_identif = divide_imgs_binary(BW_pharx_post_noc);

% We obtain the points list
BW_bwselect_igual_punts = cell(1, length(llist_BW_identif));
for cada_obj_BW = 1:length(llist_BW_identif)
    BW_bwselect_igual_punts{cada_obj_BW} = find(llist_BW_identif{cada_obj_BW});
end

% __ ↓↓ Optional ↓↓ __ %

if test_ext_si_no
    % We take the objects that detect each point.
    
    
    % Create folders:
    if ~isfolder(strcat(test_directori_sortida, "\output_images\tests")) 
    mkdir(strcat(test_directori_sortida, "\output_images\tests")); end 
    
    if ~isfolder(strcat(test_directori_sortida, "\output_images\tests\1_identifica_pum_anterior")) 
    mkdir(strcat(test_directori_sortida, "\output_images\tests\1_identifica_pum_anterior")); 
    
        if ~isfolder(strcat(test_directori_sortida, "\output_images\tests\1_identifica_pum_anterior\pixels_imatge_1_1")) 
        mkdir(strcat(test_directori_sortida, "\output_images\tests\1_identifica_pum_anterior\pixels_imatge_1_1")); end 

        if ~isfolder(strcat(test_directori_sortida, "\output_images\tests\1_identifica_pum_anterior\pixels_imatge_1_2")) 
        mkdir(strcat(test_directori_sortida, "\output_images\tests\1_identifica_pum_anterior\pixels_imatge_1_2")); end 

        if ~isfolder(strcat(test_directori_sortida, "\output_images\tests\1_identifica_pum_anterior\pixels_imatge_1_3")) 
        mkdir(strcat(test_directori_sortida, "\output_images\tests\1_identifica_pum_anterior\pixels_imatge_1_3")); end 
    
    end 

    
    for punt_BW_phar = 1:length(x_find_pharx)
            
    
        % Graphication
        zeros_graficar = zeros(size(im_compare_ini_inv));
        zeros_graficar(x_find_pharx(punt_BW_phar), y_find_pharx(punt_BW_phar)) = 1;
        imshow_write = imshowpair(imoverlay(im_pharx_ant, zeros_graficar, "r"), ...
            imoverlay(im_compare_ini_inv, zeros_graficar, "r"), "montage");
    
        imwrite(imoverlay(im_pharx_ant, zeros_graficar, "r"), ...
            strcat(test_directori_sortida, "\output_images\tests\1_identifica_pum_anterior\pixels_imatge_1_1\", return_zeros_five(punt_BW_phar), "_pixels_imatge_1.jpg"))
    
        imwrite(imoverlay(im_compare_ini_inv, zeros_graficar, "r"), ...
            strcat(test_directori_sortida, "\output_images\tests\1_identifica_pum_anterior\pixels_imatge_1_2\", return_zeros_five(punt_BW_phar), "_pixels_imatge_1.jpg"))
    
        imwrite(imshow_write.CData, ...
            strcat(test_directori_sortida, "\output_images\tests\1_identifica_pum_anterior\pixels_imatge_1_3\", return_zeros_five(punt_BW_phar), "_montage1.jpg"))
    
    
                
            % MAKE AN IF OF IF THE POINTS MATCH, IF THEY MATCH DO BWSELECT
        % AND COMPARE THE RESULT BETWEEN ONE BINARY IMAGE AND ANOTHER
        
        % _ If the value of each point in both images is the same, that is,
        % if both frames share a binary image at the same point, then we operate.
        % We do this filter because it may be, surely, in the points of the binary image
        % of the first frame do not match with the second, so that when doing bwselect
        % an image of zeros is given. When they match, we define which objects these are and if
        % they are different from each other._
        
        % We create folders
        if ~isfolder(strcat(test_directori_sortida, "\output_images\tests\1_identifica_pum_anterior\pixels_imatge_1_4")) 
        mkdir(strcat(test_directori_sortida, "\output_images\tests\1_identifica_pum_anterior\pixels_imatge_1_4")); end 
    
        if ~isfolder(strcat(test_directori_sortida, "\output_images\tests\1_identifica_pum_anterior\pixels_imatge_1_5")) 
        mkdir(strcat(test_directori_sortida, "\output_images\tests\1_identifica_pum_anterior\pixels_imatge_1_5")); end 
    
        % Graphication
        zeros_graficar = zeros(size(im_pharx_ant));
        punt_x_noc = x_find_pharx(punt_BW_phar);
        punt_y_noc = y_find_pharx(punt_BW_phar);
        zeros_graficar(punt_x_noc, punt_y_noc) = 1;
        imshow_write_2 = imshowpair(imoverlay(im_pharx_ant, zeros_graficar, "r"), ...
        imoverlay(im_compare_ini_inv, zeros_graficar, "r"), "montage");
        
        % Write
        imwrite(imshow_write_2.CData, ...
            strcat(test_directori_sortida, "\output_images\tests\1_identifica_pum_anterior\pixels_imatge_1_4\", return_zeros_five(punt_BW_phar), "_montage2.jpg"))
        imwrite(imoverlay(im_pharx_ant, zeros_graficar, "r"), ...
            strcat(test_directori_sortida, "\output_images\tests\1_identifica_pum_anterior\pixels_imatge_1_4\", return_zeros_five(punt_BW_phar), "_pixels_imatge", ".jpg"))
      
      
    end

end


if isempty(punts_noc)
    %msgbox("ERROR: NO DETECTED BINARY OBJECT!", 'Error','error');
    imatge_montatge_sortida = false;
else
    imatge_montatge_sortida = BW_pharx_post_noc; %
    %imatge_montatge_sortida = imoverlay(im_croped_graf, BW_pharx_post_noc, "g");
%     imshow(imatge_montatge_sortida)
end    



% FINAL OF THE FUNCTION

end