function introduir_dades_posvar(arxiu_text_output, array_introduir, nom_posicio_a_intro)

% Donat un arxiu de text, s'introdueix una fila al text en la posició següent a la posició amb el nom descrit.
%
% Variables
% arxiu_text_output : directori de l'arxiu de text (ex: C:\Escritorio\Josep.txt)
% array_introduir   : array de dades a introduir, en forma de string (ex: [% "P1011629_skel_00003_01.JPG_02"    "112.7794"])
% nom_posicio_a_intro   : Nom a partir des d'on es farà la introducció de les dades.
% n_vegades             : (opcional) Per si es vol fer el print de manera reversa a la que es genera si s'executa la funció varies vegades.
%
% % Exemple funció
% % Arxius dades
% arxiu_text_output = "C:\Users\Josep TOSHIBA\Desktop\Length determination v2_4\Results_out\20220305_1312_Input_images_Amanda_moltes\Filtered\dades_output.txt";
% var_out_dades = 3
% array_introduir = ["Worm_1" string(69)];
% introduir_dades(arxiu_text_output, array_introduir, 2)
% llegir_text_delimitadors(arxiu_text_output, ";")
%
% See also
% copia_dades
% llegir_text_delimitadors


% Lectura arxiu
cell_crua_dades = llegir_text_delimitadors(arxiu_text_output, ";");

% Write

[size_llargada, ~] = size(cell_crua_dades);

% Busquem la posició del nom:
fila_on_introduir = false;
for cada_fila = 1:length(cell_crua_dades)
    % Si coincideixen
    if strcmp(cell_crua_dades{cada_fila, 1}, nom_posicio_a_intro)
        % Guardem la fila
        fila_on_introduir = cada_fila;
    end
end

% Possible error no coincidència valor
if ~isnumeric(fila_on_introduir)
    msgbox('No coincidència string', 'Error','error');
    error("en f'introduir_dades_posvar': No coincidència string")

end


% Guardar l'arxiu output de dades
fid = fopen(arxiu_text_output,'w');
for var_out_dades = 1:size_llargada
    % Si la posicio del write és la que volem:
    if var_out_dades == fila_on_introduir        
        % Copiem la fila que pertoca
        fprintf(fid,'%s \n',strcat(cell_crua_dades{var_out_dades, 1}, ";", cell_crua_dades{var_out_dades, 2}));
        
        % Posteriorment la fila a introduir
        fprintf(fid,'%s \n',strcat(string(array_introduir(1, 1)), ";", string(array_introduir(1, 2))));
    else
        fprintf(fid,'%s \n',strcat(cell_crua_dades{var_out_dades, 1}, ";", cell_crua_dades{var_out_dades, 2}));
    end

end
fclose(fid);

drawnow; % Force display to update immediately.



end