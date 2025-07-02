function write_text_josep(arxiu_text_output, dades_write, separador)

% Write in a text file the data described in an array.
%
% Variables:
% arxiu_text_output : name and path of the ".txt" file where the data is saved.
% dades_write       : dades to be written to the file.
%
% Examples
% arxiu_text_output = strcat(pwd, "\", "dades_output.txt");
%
% Example data
% dades_write = [
%     "image"                     "length";
%     "P1011624_skel_00001_01"    "610.1569";
%     "P1011629_skel_00003_01"    "261.4721";
%     "P1011630_skel_00004_01"    "319.8656";
%     "P1011655_skel_00005_01"    "208.8975";
%     "P1011655_skel_00005_03"    "205.9703"]
% 
% % Create the text, with f'write_text_josep': 
% write_text_josep("asdf.txt", dades_write, ";")
% 
% % Read the created text, with  f'llegir_text_delimitadors'
% [cell_text, string_total] = llegir_text_delimitadors("asdf.txt", ";")
%
% Example 2: with llegir_text_delimitadors
% % Create text
% arxiu_text_output = "C:\Users\Josep TOSHIBA\Desktop\Length determination v2_8\Results_out\_Internal_code_files\escale_line.txt";
% escala_write = ["escala", "654.23"];
% write_text_josep(arxiu_text_output, escala_write, ";")
% 
% % Read text
% [array_text, string_total] = llegir_text_delimitadors(arxiu_text_output, ";");
%
% See also:
% llegir_text_delimitadors

% START FUNCTION

if ~exist('separador','var')
    separador = ";";
end

[llarg_dades_write, ~] = size(dades_write);

fid = fopen(arxiu_text_output,'w');
for var_out_dades = 1:llarg_dades_write
  fprintf(fid,'%s\n',strcat(dades_write{var_out_dades, 1}, separador, dades_write{var_out_dades, 2}));
end
fclose(fid);


% END FUNCTION


end


