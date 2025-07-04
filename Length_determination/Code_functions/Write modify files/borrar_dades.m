function borrar_dades(arxiu_text_output, posicio_a_borrar)

% Given a text file, a specific row is deleted from it.
%
%
% Variables
% arxiu_text_output : directori of the text file (ex: C:\Escritorio\Josep.txt)
% posicio_a_borrar   : Position of the text file where the row is going to be deleted. 
%
%
% % Example function
% carpeta_borr = "C:\Users\Josep TOSHIBA\Desktop\Length determination v2_4\Results_out\20220309_1209_Input_images_Amanda_poques\Filtered\dades_output.txt";
% linia_bor = 2
% 
% borrar_dades(carpeta_borr, linia_bor)
%
% See also
% copia_dades
% llegir_text_delimitadors


% Read of the file
cell_crua_dades = llegir_text_delimitadors(arxiu_text_output, ";");

% Write

[size_llargada, ~] = size(cell_crua_dades);

% Save the output file of data
fid = fopen(arxiu_text_output,'w');
for var_out_dades = 1:size_llargada
    % If the write position is the one we want:
    if var_out_dades == (posicio_a_borrar)
        % We don't copy the line.
    else
        fprintf(fid,'%s \n',strcat(cell_crua_dades{var_out_dades, 1}, ";", cell_crua_dades{var_out_dades, 2}));
    end

end
fclose(fid);

drawnow; % Force display to update immediately.



end