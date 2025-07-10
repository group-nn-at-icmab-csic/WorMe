function resta_dades(arxiu_text_output_manually, n_vegades_add)

% Function for the app, of the return button.
% Read existing data, and subtract one line.
% If there have been no changes, none are subtracted. 
% Subtracted based on the counter of saved images,
% proportional to the number of rows+1 (first is header).
%
% Variables
% n_vegades_add : Times the file has been added. Discriminator of 0 times.
% numeric_val : counter of images that exist. Ex: image 1, 2, 3... etc.
%
%
% Variable example cell
%      asdf = [{'imatge'                }    {'llargada '};
%     {'P1011629_skel_00003_01'}    {'261.4721 '};
%     {'P1011630_skel_00004_01'}    {'319.8656 '}]


if n_vegades_add == 0
  % No data
  % Do nothing. We do not subtract (cannot)
else
    % There is data.
    % Subtract the last line

    % Read existing data
    cell_dades_mfilt = read_text_delimiters(arxiu_text_output_manually, ";");

    cell_dades_mfilt_nou = cell_dades_mfilt(1 : end-1, :);
    
    [size_llargada, ~] = size(cell_dades_mfilt_nou);
    % Write
    % Save the data output file
    fid = fopen(arxiu_text_output_manually,'w');
    for var_out_dades = 1:size_llargada
      fprintf(fid,'%s \n',strcat(cell_dades_mfilt_nou{var_out_dades, 1}, ";", cell_dades_mfilt_nou{var_out_dades, 2}));
    end
    fclose(fid);

    drawnow; % Force display to update immediately.

end





end