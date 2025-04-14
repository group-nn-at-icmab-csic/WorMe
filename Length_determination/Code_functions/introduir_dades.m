function introduir_dades(arxiu_text_output, array_introduir, posicio_a_intro)

% Donat un arxiu de text, s'introdueix una fila al text en una posició determinada.
% Si es defineix la posició a introduïr com a "auto", aquesta posició serà
% la última del text.
% 
% Variables
% arxiu_text_output : directori de l'arxiu de text (ex: C:\Escritorio\Josep.txt)
% array_introduir   : array de dades a introduir, en forma de string (ex: [% "P1011629_skel_00003_01.JPG_02"    "112.7794"])
% posicio_a_intro   : Posicio del arxiu de text on s'introduïràn les dades.
%
% Paràmetres
% posicio_a_intro - "auto" : introdueix el text en la última fila.
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

[size_llargada, ~] = size(cell_crua_dades);


if ~isnumeric(posicio_a_intro)
    posicio_a_intro = size_llargada;
end


% Write

% Guardar l'arxiu output de dades

% Si l'arxiu no és vuit:
if size_llargada > 0
    fid = fopen(arxiu_text_output,'w');
    for var_out_dades = 1:size_llargada
        % Si la posicio del write és la que volem:
        if var_out_dades == (posicio_a_intro)

            % Copiem la linea a introduir
            fprintf(fid,'%s \n',strcat(string(array_introduir(1, 1)), ";", string(array_introduir(1, 2))));

            % Posteriorment la que pertoca
            fprintf(fid,'%s \n',strcat(cell_crua_dades{var_out_dades, 1}, ";", cell_crua_dades{var_out_dades, 2}));
        else
            fprintf(fid,'%s \n',strcat(cell_crua_dades{var_out_dades, 1}, ";", cell_crua_dades{var_out_dades, 2}));
        end

    end
    fclose(fid);

    drawnow; % Force display to update immediately.

% Si l'arxiu és vuit, fem write sense tenir en compte la llargada d'aquest.
% Simplement fem wirte del array.
else
    fid = fopen(arxiu_text_output,'w');
    fprintf(fid,'%s \n',strcat(string(array_introduir(1, 1)), ";", string(array_introduir(1, 2))));
    fclose(fid);

    drawnow; % Force display to update immediately.

end