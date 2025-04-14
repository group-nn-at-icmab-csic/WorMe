function resta_dades(arxiu_text_output_manually, n_vegades_add)

% Funció per a la app, del botó return.
% Lectura dades existents, i restem una línia.
% Si no hi ha hagut cambis, no es resta cap. Es resta en funció al
% comptador d'imatges guardades, proporcional al nombre de files+1 (primer
% és encapçalament).
%
% Variables
% n_vegades_add  : Vegades que s'ha afegit l'arxiu. Discriminador de 0 vegades.
% numeric_val : contador d'imatges que hi ha. Ex: imatge 1, 2, 3... etc.
%
%
% Variable cell de mostra
%      asdf = [{'imatge'                }    {'llargada '};
%     {'P1011629_skel_00003_01'}    {'261.4721 '};
%     {'P1011630_skel_00004_01'}    {'319.8656 '}]


if n_vegades_add == 0
    % No hi ha dades
    % No fem res. No restem (no es pot)
else
    % Hi ha dades.
    % Restem la última línia

    % Lectura dades existents
    cell_dades_mfilt = llegir_text_delimitadors(arxiu_text_output_manually, ";");

    cell_dades_mfilt_nou = cell_dades_mfilt(1 : end-1, :);
    
    [size_llargada, ~] = size(cell_dades_mfilt_nou);
    % Write
    % Guardar l'arxiu output de dades
    fid = fopen(arxiu_text_output_manually,'w');
    for var_out_dades = 1:size_llargada
      fprintf(fid,'%s \n',strcat(cell_dades_mfilt_nou{var_out_dades, 1}, ";", cell_dades_mfilt_nou{var_out_dades, 2}));
    end
    fclose(fid);

    drawnow; % Force display to update immediately.

end





end