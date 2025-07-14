function app_interf_processat_posterior_imatge(app)

% All the internal component of Thick, after the selection of the data in
% the main.
%
% Once the components of the GUI have been described in S_text_scan,
% it proceeds to the new selection and definition of the components
% of the new binary image in the GUI, if any.


% START FUNCTION


% ___ Processing next object/image___
% We subtract processed objects. If there are objects, we operate
% on the image; otherwise, the next image is used.

% #1: We check if there are more binary objects, to select the
% same image, the next image, or the final one.
% #2: Image processing and data description.
% #3: Plotting the image with the obtained data.

% OPTIMIZABLE: if a counter is stored indicating that it is the last
% binary object, there’s no need to repeat the entire process.
% Example would be from 'bwconncomp' if equal to 1.

dir_output = app.appv_dir_output;

% __Reading the data__
% ÇÇÇ This command should be executed every time an image is read, in order to apply
% the indices of the binary object, primarily.

% _Read the file_

% Upgrade_table:
% Read table.
% If it’s the first time, it’s read; otherwise, it’s not.
% _Definition of initial variables_
[S_textscan_table] = app_interf_lectura_Stable(app);

% _Filter by image name_
nom_img_origin = app.img_original_nomLabel.Text;
S_textscan_table_filtred = S_textscan_table(S_textscan_table.NomWorm == nom_img_origin, :);
% Once the data of the object present in the GUI
% is saved in the main, the filtered data of the same object
% and the previous ones are described.

% ___Definition of filter values based on selection____
app_interf_definicio_mean_width(app, S_textscan_table);


% Upgrade_table: UPGRADE: Instead of reading the table,
% obtain it from the app’s semi-global variable.
% Two functions are involved: app_interf_descriure_dades, app_interf_guardar_main_dades,
% and app_interf_llegir_main_dades.
% These describe the GUI data into a cell array (app_interf_descriure_dades),
% save the cell into the main data (app_interf_guardar_main_dades),
% and read the entire text file again (app_interf_llegir_main_dades),
% thereby obtaining the complete table.
% We need to: read the cell, write the cell to the main file,
% but only read the table at the beginning if it’s empty, and add
% the cell values to the already stored table.



% _Obtaining the previously modified binary image_
% We modify the original image and display it:
imatge_original = imread(strcat(app.dir_imgs_orig, "\", app.img_original_nomLabel.Text));
BW_final = imread(strcat(dir_output, "\imgBWtemp.png"));


% __Delete already processed objects__

% _Describe the data of the binary object indices_
[indx_BW_filtred] = appf_split_strindex(S_textscan_table_filtred.Indx_BW); % Elapsed time is 0.015221 seconds.

% Apply deletion of the indices
BW_final_noproc = BW_final;
% Delete already determined objects:

BW_final_noproc(indx_BW_filtred) = false;



% ___Application of Filters___
% Obtaining the indices
[indx_filtre_tot, indx_filtre_pos] = app_interf_filtres(app, BW_final_noproc);

% _Application of negative filter indices_
if ~isempty(indx_filtre_tot)
    BW_final_noproc(indx_filtre_tot) = false;
end    

% _Application of positive filter indices_
if ~isempty(indx_filtre_pos)
    BW_final_noproc(indx_filtre_pos) = true;
end    



% __Obtain the number of binary objects__
% Objects in the binary image
number_BW = getfield(bwconncomp(BW_final_noproc, 8), 'NumObjects');

% _Obtain number of draw objects_
% We obtain the data of the non-processed 'draws', and add them
[~, taula_dibuix_filted_nonproc] = app_interf_select_drawline(app); % Elapsed time is 0.001039 seconds.

number_BW = number_BW + height(taula_dibuix_filted_nonproc);



% _Select binary objects_
% The object in the image is determined, or the image proceeds,
% or if it’s the final one, it ends.
%[proc_BW, new_img, num, BW_final_object, BW_final_noproc, imatge_original] = app_interf_select_obj_bin_forward(app, number_BW, BW_final_noproc, dir_output, imatge_original);

% _Modif_draw_ %
[proc_BW, new_img, num, BW_final_object, BW_final_noproc, imatge_original, isdrawline] = app_interf_select_obj_bin_forward_new(app, number_BW, BW_final_noproc, dir_output, imatge_original);


% From here we have the binary image without the previous objects.
% Now it will be processed by skeletonizing it, plotting it,
% and temporarily saving its data for the next decision (thick/cross).



% If there are no objects in the next image:
if proc_BW && num==0
    % Display the image, but only allow the buttons to be used.
    % There should be no thick or cross.

    app.RightButton.Visible = 'on';
    [nonobj_imageArray_ambtext] = image_without_objects(imatge_original);
    app.Image.ImageSource = nonobj_imageArray_ambtext;

    % The content of the next object is neither saved nor displayed;
    % this will happen once the next image arrives.
    % Only the image is shown. The loading of content will
    % occur in the next image; if there are objects, then,
    % if there are objects, they will be displayed, and thick/cross
    % can be performed to save them.

% If it’s not the final image:
elseif proc_BW
    % Variables:
    % BW_final_object : binary image with the object to analyze
    % S_textscan_table_filtred : table with filtered data
    % indx_BW_filtred : indices of the previously processed objects
    % BW_final_noproc : image with non-processed objects,
    % including the current object
    % num  : total number of objects
    % RGB_to_color_new : RGB image like the original
    % that will be continuously modified.


    % ___Processing and Description of the current object's data for its subsequent processing___
    % The object is processed, and the data are described in the GUI and its txt file.
    [BW_skel, BW_skel_crop, imageArray_crop, proporcio_img, indx_BWskel, indx_BWobj] = app_interf_processar_descriure_img_new(app, dir_output, imatge_original, BW_final_object, BW_final, isdrawline);

    % ____Processing for image plotting____
    % Now we already have the BW and skel, both cropped and full size,
    % as well as the data. Let’s plot it.
    RGB_to_color_new = imatge_original;

    % Plotting
    app_interf_graficar_img(app, RGB_to_color_new, imageArray_crop, BW_skel_crop, num, proporcio_img, BW_final, BW_skel, indx_BWskel, new_img, S_textscan_table_filtred, BW_final_noproc, indx_BWobj, isdrawline);
    % Processing time: With app: 0.0173; without app: 0.0183


    % _Enable/Disable Buttons_
    if ~str2num(app.finalitzat_contLabel)
        app_interf_enable_thickcrosret_buttons(app, 'on')
    end
end


% END FUNCTION




end