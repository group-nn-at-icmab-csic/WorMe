function [BW_final] = app_interf_process_img(app, imatge_original)

% Based on the selected modification data, the image processing is returned.

% START FUNCTION

% Read file and display in Label Modificacions
dir_output = app.appv_dir_output;
filestxt = read_txt_folder_structure(fullfile(dir_output, "Processment_parameters"));
text_config_parameters = filestxt.name;
% Get processing array from this:
[array_processaments] = obtain_array_processments(fullfile(dir_output, "Processment_parameters", text_config_parameters)); 



% We modify the original image and display it:
[BW_final, ~] = processment_img_list(imatge_original, array_processaments); 

% END FUNCTION


end