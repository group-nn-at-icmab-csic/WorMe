function [proc_BW, new_img, num, BW_final_object, BW_final_noproc, imatge_original] = app_interf_select_obj_bin(app, number_BW, BW_final_noproc, dir_output, imatge_original)

% Selects the binary objects from the image and returns them if they exist,
% otherwise returns the newly processed image.
% Function from the app 'app_selection_pannel'.
%
%
%
% Variables
% number_BW : number of binary objects (from BW objects not processed 'BW_final_noproc')

% START FUNCTION

% If there is any binary object
if number_BW > 0
    % Obtain the binary object
    [L_variable, num] = bwlabel(BW_final_noproc);
    BW_final_object = L_variable == 1;
    % imshow(BW_final_object)

    proc_BW = true; % Flag indicating the end has not been reached    

    new_img = false; % Flag for new image

% If there is no binary object:
else
    % _Continue with the next image_

    % Define image counter
    n_imatge = str2double(app.img_contLabel.Text) + 1;

    app.img_contLabel.Text = string(n_imatge);

    % If the number of images does not exceed the total:
    if n_imatge <= str2double(app.img_tot_nLabel.Text)
        % _Take the image following the current one_
        % DEFINE THE IMAGE
        % Folder containing the images
        carpeta_imatges = app.dir_imgs_orig;

        % READ .jpg and .png images from the folder:
        [theFiles] = read_imgs_folder_structure(carpeta_imatges);

        % Get image
        baseFileName = theFiles(n_imatge).name;
        app.img_original_nomLabel.Text = baseFileName;
        fullFileName = fullfile(theFiles(n_imatge).folder, baseFileName);
        % Image to process
        imatge_original = imread(fullFileName);

        % UPDATE IMAGE PATH
        app.vapp_ruta_img_origin = fullFileName;

        % _Process the image_            
        % Read file and display in Label Modifications
        [array_processaments] = obtain_array_processments(strcat("Apps\app_image_processment\Internal code files\Image processing settings\", string(app.ModificacionsguardadesListBox.Value)));

        % Modify the original image and display it: 
         [BW_final, ~] = processment_img_list(imatge_original, array_processaments); 
         % Save the image in PNG:
         imwrite(BW_final, strcat(dir_output, "\imgBWtemp.png"));

        % Apply deletion of indices (not entirely
        % necessary)
        [L_variable, num] = bwlabel(BW_final);
        BW_final_object = L_variable == 1;

        % Define BW image with unprocessed objects:
        BW_final_noproc = BW_final;
        BW_final_noproc(BW_final_object) = false;             

        % Mark counter as new image
        new_img = true;

        proc_BW = true; % Flag indicating the end has not been reached
        
        % Define that this is not the last image
        app.finalitzat_contLabel = "true";
        
    else
        % Image limit exceeded: show Finished sign
        app.Image.ImageSource = imread("Apps\app_selection_pannel\images_useful\Finished_WM.png");
        app.Image2.ImageSource = imread("Apps\app_selection_pannel\images_useful\Logo_WorMe_blanc.png");

        % Disable buttons
        app.Thick_Button.Visible = 'off';
        app.Cross_Button.Visible = 'off';

        % app.DoneButton.Visible = 'on';

        app.Hyperlink.Visible = 'on';
        app.CitationLabel.Visible = 'on';

        app.finalitzat_contLabel.Text = "true";
        
        proc_BW = false; % Flag indicating the end has been reached                    
    end

end


% END FUNCTION



end