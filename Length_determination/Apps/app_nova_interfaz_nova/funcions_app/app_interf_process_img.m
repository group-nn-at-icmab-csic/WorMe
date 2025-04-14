function [BW_final] = app_interf_process_img(app, imatge_original)

% A partir de la dada de la modificació seleccionada, es retorna el processament de la imatge.

% INICI FUNCIÓ

% Llegir arxiu i mostrar en Label Modificacions
% if ~isempty(app.ModificacionsguardadesListBox.Value)
%     [array_processaments] = obtenir_array_processaments(strcat("Results_out\Internal_code_files\Image_processing_settings\", string(app.ModificacionsguardadesListBox.Value)));
% elseif ~isempty(app.ModificacionstemporalsListBox.Value)
%     [array_processaments] = obtenir_array_processaments(strcat("Results_out\Internal_code_files\Image_processing_settings\", string(app.ModificacionstemporalsListBox.Value)));    
% else
%     error("Error in app_interf_process_img")
% end
dir_output = app.appv_dir_output;
filestxt = lectura_txt_carpeta_estr(strcat(dir_output, "\Processment_parameters"));
text_config_parameters = filestxt.name;
% Obtenció array processaments d'aquest:
[array_processaments] = obtenir_array_processaments(strcat(dir_output, "\Processment_parameters\", text_config_parameters)); 


% C:\Users\jllobet\Desktop\Length determination v2_11\Results_out\Internal_code_files\Image_processing_settings

% Modifiquem la imatge original i la mostrem: 
[BW_final, ~] = processament_imatge_llistat(imatge_original, array_processaments); 

% FINAL FUNCIÓ

end