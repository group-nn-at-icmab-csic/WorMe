function borrar_dades(arxiu_text_output, posicio_a_borrar)

% Donat un arxiu de text, s'elimina una fila determinada d'aquest.
%
%
% Variables
% arxiu_text_output : directori de l'arxiu de text (ex: C:\Escritorio\Josep.txt)
% posicio_a_borrar   : Posicio del arxiu de text on es borrarà la fila de dades.
%
%
% % Exemple ús funció
% carpeta_borr = "C:\Users\Josep TOSHIBA\Desktop\Length determination v2_4\Results_out\20220309_1209_Input_images_Amanda_poques\Filtered\dades_output.txt";
% linia_bor = 2
% 
% borrar_dades(carpeta_borr, linia_bor)
%
% See also
% copia_dades
% llegir_text_delimitadors


% Lectura arxiu
cell_crua_dades = llegir_text_delimitadors(arxiu_text_output, ";");

% Write

[size_llargada, ~] = size(cell_crua_dades);

% Guardar l'arxiu output de dades
fid = fopen(arxiu_text_output,'w');
for var_out_dades = 1:size_llargada
    % Si la posicio del write és la que volem:
    if var_out_dades == (posicio_a_borrar)
        % No copiem la línea.
    else
        fprintf(fid,'%s \n',strcat(cell_crua_dades{var_out_dades, 1}, ";", cell_crua_dades{var_out_dades, 2}));
    end

end
fclose(fid);

drawnow; % Force display to update immediately.



end