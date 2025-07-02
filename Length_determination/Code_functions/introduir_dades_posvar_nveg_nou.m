function introduir_dades_posvar_nveg_nou(arxiu_text_output, array_introduir, nom_posicio_a_intro, n_vegades)
% Given a text file, a row is inserted into the text at the position following the position with the specified name.
%
% Variables
% arxiu_text_output : directory of the text file (e.g., C:\Escritorio\Josep.txt)
% array_introduir   : array of data to insert, in string form (e.g., [% "P1011629_skel_00003_01.JPG_02"    "112.7794"])
% nom_posicio_a_intro   : Name from which the data insertion will be made.
% n_vegades             : (optional) In case the print is desired in reverse order compared to what is generated if the function is executed multiple times.
%
% % Function example
% % Data files
% arxiu_text_output = "C:\Users\Josep TOSHIBA\Desktop\Length determination v2_4\Results_out\20220305_1312_Input_images_Amanda_moltes\Filtered\dades_output.txt";
% var_out_dades = 3
% array_introduir = ["Worm_1" string(69)];
% introduir_dades(arxiu_text_output, array_introduir, 2)
% llegir_text_delimitadors(arxiu_text_output, ";")
%
% See also
% copia_dades
% llegir_text_delimitadors
% introduir_dades



% File read
cell_crua_dades = llegir_text_delimitadors(arxiu_text_output, ";");

% Write

[size_llargada, ~] = size(cell_crua_dades);

% Name search position:
fila_on_introduir = false;
for cada_fila = 1:length(cell_crua_dades)
    % If coincide
    if strcmp(cell_crua_dades{cada_fila, 1}, nom_posicio_a_intro)
        % Save the row
        fila_on_introduir = cada_fila;
    end
end

% Possible error value no coincidence
if ~isnumeric(fila_on_introduir)
    msgbox('No coincidència string', 'Error','error');
    error("en f'introduir_dades_posvar_nveg': No coincidència string")
end

% Clau
clau_nval = false;
% count val
n_vegades_cont = 0;


% _Variables_
% var_out_dades   : row number of total rows.

% Save the data output file
fid = fopen(arxiu_text_output,'w');
n_tot_print = 0;
for var_out_dades = 1:size_llargada
    % If the write position is what we want:
    if var_out_dades == fila_on_introduir        
        % Copy the relevant row
        fprintf(fid,'%s \n',strcat(cell_crua_dades{var_out_dades, 1}, ";", cell_crua_dades{var_out_dades, 2}));
        clau_nval = true;
        
        n_tot_print = var_out_dades + n_vegades - 1;
        
        % If it is the last value in the text file.
        if n_tot_print == var_out_dades
        %if n_vegades == 1 && var_out_dades == size_llargada
            
                fprintf(fid,'%s \n',strcat(string(array_introduir(1, 1)), ";", string(array_introduir(1, 2))));

        end
    else
        % True is stored if it matches. Then, a counter is added for
        % each time it is passed, which if it matches the position of
        % n_vegades, it prints in addition to the normal line, the line in question.
        if n_tot_print == var_out_dades

            fprintf(fid,'%s \n',strcat(cell_crua_dades{var_out_dades, 1}, ";", cell_crua_dades{var_out_dades, 2}));

            fprintf(fid,'%s \n',strcat(string(array_introduir(1, 1)), ";", string(array_introduir(1, 2))));


        else
            fprintf(fid,'%s \n',strcat(cell_crua_dades{var_out_dades, 1}, ";", cell_crua_dades{var_out_dades, 2}));
        end
    end

end
fclose(fid);

drawnow; % Force display to update immediately.



end