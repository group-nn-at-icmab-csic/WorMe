function [BW_final] = app_interf_process_img(app, imatge_original)

% Based on the selected modification data, the image processing is returned.

% START FUNCTION

% Read file and display in Label Modificacions
dir_output = app.appv_dir_output;
filestxt = read_txt_folder_structure(strcat(dir_output, "\Processment_parameters"));
text_config_parameters = filestxt.name;
% Get processing array from this:
[array_processaments] = obtain_array_processments(strcat(dir_output, "\Processment_parameters\", text_config_parameters)); 


% C:\Users\jllobet\Desktop\Length determination v2_11\Results_out\Internal_code_files\Image_processing_settings

% We modify the original image and display it:
[BW_final, ~] = processment_img_list(imatge_original, array_processaments); 

% END FUNCTION


end