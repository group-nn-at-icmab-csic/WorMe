function introduce_data(arxiu_text_output, array_introduir, posicio_a_intro)

% Given a text file, a row is inserted into the text at a specified position.
% If the position to insert is defined as "auto", this position will be
% the last line of the text.
%
% Variables
% arxiu_text_output : directory of the text file (e.g., C:\Escritorio\Josep.txt)
% array_introduir   : array of data to insert, in string form (e.g., [% "P1011629_skel_00003_01.JPG_02"    "112.7794"])
% posicio_a_intro   : Position in the text file where the data will be inserted.
%
% Parameters
% posicio_a_intro - "auto" : inserts the text in the last line.
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





% File read
cell_crua_dades = read_text_delimiters(arxiu_text_output, ";");

[size_llargada, ~] = size(cell_crua_dades);


if ~isnumeric(posicio_a_intro)
    posicio_a_intro = size_llargada;
end


% Write

% Save file output data

% If the file is not empty:
if size_llargada > 0
    fid = fopen(arxiu_text_output,'w');
    for var_out_dades = 1:size_llargada
        % If the position of write is the one we want :
        if var_out_dades == (posicio_a_intro)

            % Copy the line to introduce
            fprintf(fid,'%s \n',strcat(string(array_introduir(1, 1)), ";", string(array_introduir(1, 2))));

            % After that, the one that require:
            fprintf(fid,'%s \n',strcat(cell_crua_dades{var_out_dades, 1}, ";", cell_crua_dades{var_out_dades, 2}));
        else
            fprintf(fid,'%s \n',strcat(cell_crua_dades{var_out_dades, 1}, ";", cell_crua_dades{var_out_dades, 2}));
        end

    end
    fclose(fid);

    drawnow; % Force display to update immediately.

% If the file is empty, we write without taking into account its length.
% We simply write the array.
else
    fid = fopen(arxiu_text_output,'w');
    fprintf(fid,'%s \n',strcat(string(array_introduir(1, 1)), ";", string(array_introduir(1, 2))));
    fclose(fid);

    drawnow; % Force display to update immediately.

end