function borrar_dades_posvar(arxiu_text_output, nom_posicio_a_intro)

% Donat un arxiu de text, s'elimina la fila que la primera columna de la qual coincideix amb el nom descrit.
%
%
% Variables
% arxiu_text_output     : directori de l'arxiu de text (ex: C:\Escritorio\Josep.txt)
% nom_posicio_a_intro   : Nom de la posicio de la qual es vol borrar la fila.
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


% Lectura arxiu
cell_crua_dades = llegir_text_delimitadors(arxiu_text_output, ";");

[size_llargada, ~] = size(cell_crua_dades);

% Busquem la posició del nom:
fila_on_introduir = false;
for cada_fila = 1:size_llargada
    % Si coincideixen
    if strcmp(cell_crua_dades{cada_fila, 1}, nom_posicio_a_intro)
        % Guardem la fila
        fila_on_introduir = cada_fila;
    end
end

% Possible error no coincidència valor
if ~isnumeric(fila_on_introduir)
    f = msgbox('No coincidència string', 'Error','error');
    error("en f'borrar_dades_posvar': No coincidència string")
    %return
end


% Guardar l'arxiu output de dades
fid = fopen(arxiu_text_output,'w');
for var_out_dades = 1:size_llargada
    % Si la posicio del write és la que volem:
    if var_out_dades == fila_on_introduir
        % No copiem la línea.
    else
        fprintf(fid,'%s \n',strcat(cell_crua_dades{var_out_dades, 1}, ";", cell_crua_dades{var_out_dades, 2}));
    end

end
fclose(fid);

%drawnow; % Force display to update immediately.



end