function copia_dades(n_vegades_add, numeric_val, arxiu_text_output, arxiu_text_output_manually)

% Given two text files, copy a value from the row of the input file
% to the last row of the output file.

% Variables
% n_vegades_add : Times the file has been added. Discriminator of 0 times.
% numeric_val : counter of images present. Ex: image 1, 2, 3... etc.
%
%

% fILE READ
cell_crua_dades = llegir_text_delimitadors(arxiu_text_output, ";");

if n_vegades_add == 0
    %If it is the first value added, the headings are inserted.
    cell_dades_mfilt = ["imatge", "llargada"; cell_crua_dades(numeric_val+1, :)];
    

    % Sume times copy
    %n_vegades_add = n_vegades_add + 1;

else
    % Reading of existent data
    cell_dades_mfilt = llegir_text_delimitadors(arxiu_text_output_manually, ";");

    % Add to 
    cell_dades_mfilt = [cell_dades_mfilt; cell_crua_dades(numeric_val+1, :)];
    
end

% Write

[size_llargada, ~] = size(cell_dades_mfilt);

% Guardar l'arxiu output de dades
fid = fopen(arxiu_text_output_manually,'w');
for var_out_dades = 1:size_llargada
  fprintf(fid,'%s \n',strcat(cell_dades_mfilt{var_out_dades, 1}, ";", cell_dades_mfilt{var_out_dades, 2}));
end
fclose(fid);

drawnow; % Force display to update immediately.



end