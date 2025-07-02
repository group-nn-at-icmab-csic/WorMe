function borrar_dades_posvar(arxiu_text_output, nom_posicio_a_intro)

% Given a text file, deletes the row whose first column matches the specified name.
%
%
% Variables
% arxiu_text_output     : directory of the text file (e.g.: C:\Escritorio\Josep.txt)
% nom_posicio_a_intro   : Name of the position whose row you want to delete.
%
%
% % Exemple ús funció
% carpeta_borr = "C:\Users\Josep TOSHIBA\Desktop\Length determination v2_4\Results_out\20220309_1209_Input_images_Amanda_poques\Filtered\dades_output.txt";
% linia_bor = "P1011655_skel_00005_03.JPG"
% 
% borrar_dades(carpeta_borr, linia_bor)
%
% See also
% copia_dades
% llegir_text_delimitadors


% Read of the file
cell_crua_dades = llegir_text_delimitadors(arxiu_text_output, ";");

[size_llargada, ~] = size(cell_crua_dades);

% We search the name position:
fila_on_introduir = false;
for cada_fila = 1:size_llargada
    % If coincide:
    if strcmp(cell_crua_dades{cada_fila, 1}, nom_posicio_a_intro)
        % Save the row:
        fila_on_introduir = cada_fila;
    end
end

% Possible error in no coincidence of the value:
if ~isnumeric(fila_on_introduir)
    f = msgbox('No coincidència string', 'Error','error');
    error("en f'borrar_dades_posvar': No coincidència string")
    %return
end


% Save the output data file
fid = fopen(arxiu_text_output,'w');
for var_out_dades = 1:size_llargada
    % If the position of write is the one we want: 
    if var_out_dades == fila_on_introduir
        % Don't copy the line.
    else
        fprintf(fid,'%s \n',strcat(cell_crua_dades{var_out_dades, 1}, ";", cell_crua_dades{var_out_dades, 2}));
    end

end
fclose(fid);

%drawnow; % Force display to update immediately.



end