function copia_dades(n_vegades_add, numeric_val, arxiu_text_output, arxiu_text_output_manually)

% Donats dos arxius de text, copia un valor de la fila de l'arxiu
% d'entrada, a la fila última del arxiu de sortida.

% Variables
% n_vegades_add  : Vegades que s'ha afegit l'arxiu. Discriminador de 0 vegades.
% numeric_val : contador d'imatges que hi ha. Ex: imatge 1, 2, 3... etc.
%
%


% Lectura arxiu
cell_crua_dades = llegir_text_delimitadors(arxiu_text_output, ";");

if n_vegades_add == 0
    % Si es el primer valor que s'afegeix, es fiquen els encapçalaments.
    cell_dades_mfilt = ["imatge", "llargada"; cell_crua_dades(numeric_val+1, :)];
    

    % % Suma contador vegades copiat
    %n_vegades_add = n_vegades_add + 1;

else
    % Lectura dades existents
    cell_dades_mfilt = llegir_text_delimitadors(arxiu_text_output_manually, ";");

    % Afegeix a 
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