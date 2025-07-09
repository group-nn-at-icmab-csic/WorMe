function introduce_data_posvar(arxiu_text_output, array_introduir, nom_posicio_a_intro)
% Given a text file, a row is inserted into the text at the position following the position with the specified name.
%
% Variables
% arxiu_text_output : directory of the text file (e.g., C:\Escritorio\Josep.txt)
% array_introduir   : array of data to insert, in string form (e.g., [% "P1011629_skel_00003_01.JPG_02"    "112.7794"])
% nom_posicio_a_intro   : Name from which the data insertion will be made.
% n_vegades             : (optional) In case the print is wanted in reverse order compared to the one generated if the function is executed multiple times.
%
% % Function example
% % Data files
% arxiu_text_output = "C:\Users\Josep TOSHIBA\Desktop\Length determination v2_4\Results_out\20220305_1312_Input_images_Amanda_moltes\Filtered\dades_output.txt";
% var_out_dades = 3
% array_introduir = ["Worm_1" string(69)];
% introduce_data(arxiu_text_output, array_introduir, 2)
% read_text_delimiters(arxiu_text_output, ";")
%
% See also
% data_copy_own
% read_text_delimiters


% File reading

cell_crua_dades = read_text_delimiters(arxiu_text_output, ";");

% Write

[size_llargada, ~] = size(cell_crua_dades);

% Search position of name:
fila_on_introduir = false;
for cada_fila = 1:length(cell_crua_dades)
    % If coincide
    if strcmp(cell_crua_dades{cada_fila, 1}, nom_posicio_a_intro)
        % Save the raw 
        fila_on_introduir = cada_fila;
    end
end

% Possible error
if ~isnumeric(fila_on_introduir)
    msgbox('No coincidència string', 'Error','error');
    error("en f'introduce_data_posvar': No coincidència string")

end


% Save output de dades
fid = fopen(arxiu_text_output,'w');
for var_out_dades = 1:size_llargada
    % Si la posicio del write és la que volem:
    if var_out_dades == fila_on_introduir        
        % Copiy raw corresponent
        fprintf(fid,'%s \n',strcat(cell_crua_dades{var_out_dades, 1}, ";", cell_crua_dades{var_out_dades, 2}));
        
        % After, the raw to introduce
        fprintf(fid,'%s \n',strcat(string(array_introduir(1, 1)), ";", string(array_introduir(1, 2))));
    else
        fprintf(fid,'%s \n',strcat(cell_crua_dades{var_out_dades, 1}, ";", cell_crua_dades{var_out_dades, 2}));
    end

end
fclose(fid);

drawnow; % Force display to update immediately.



end