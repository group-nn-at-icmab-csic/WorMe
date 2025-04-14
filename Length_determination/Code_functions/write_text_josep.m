function write_text_josep(arxiu_text_output, dades_write, separador)

% Escriu en un arxiu de text determinat les dades descrites en un array.
%
% Variables:
% arxiu_text_output : nom i direcció del arxiu ".txt" on es guarden les dades.
% dades_write       : dades que es volen fer print.
%
% Exemples
% arxiu_text_output = strcat(pwd, "\", "dades_output.txt");
%
% Dades d'exemple
% dades_write = [
%     "imatge"                    "llargada";
%     "P1011624_skel_00001_01"    "610.1569";
%     "P1011629_skel_00003_01"    "261.4721";
%     "P1011630_skel_00004_01"    "319.8656";
%     "P1011655_skel_00005_01"    "208.8975";
%     "P1011655_skel_00005_03"    "205.9703"]
% 
% % Creació text, amb f'write_text_josep': 
% write_text_josep("asdf.txt", dades_write, ";")
% 
% % Lectura del text creat, amb la funció f'write_text_josep'
% [cell_text, string_total] = llegir_text_delimitadors("asdf.txt", ";")
%
% Exemple 2: amb llegir_text_delimitadors
% % Crear text
% arxiu_text_output = "C:\Users\Josep TOSHIBA\Desktop\Length determination v2_8\Results_out\_Internal_code_files\escale_line.txt";
% escala_write = ["escala", "654.23"];
% write_text_josep(arxiu_text_output, escala_write, ";")
% 
% % Llegir text
% [array_text, string_total] = llegir_text_delimitadors(arxiu_text_output, ";");
%
% See also:
% llegir_text_delimitadors

% INICI FUNCIO

if ~exist('separador','var')
    separador = ";";
end

[llarg_dades_write, ~] = size(dades_write);

fid = fopen(arxiu_text_output,'w');
for var_out_dades = 1:llarg_dades_write
  fprintf(fid,'%s\n',strcat(dades_write{var_out_dades, 1}, separador, dades_write{var_out_dades, 2}));
end
fclose(fid);


% FINAL FUNCIÓ


end


