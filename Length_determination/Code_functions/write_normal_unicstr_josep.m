function write_normal_unicstr_josep(arxiu_text_output, dades_write)

% Escriu en un arxiu de text determinat les dades descrites en un array.
%
% Variables:
% arxiu_text_output : nom i direcció del arxiu ".txt" on es guarden les dades.
% dades_write       : dades que es volen fer print.
%
% Exemple
% string_josep = "asdfas dfasd fasdf asdf asdf asd" + "asdf asdf asdf asdfasdf " + newline + "adfasdfa" + newline + "ASDASDAD" + newline
% string_josep = "josep writting a book"
% write_normal_unicstr_josep("notes_analysis.txt", string_josep)
% [string_sortida] = llegir_text_delimitadors_normal(arxiu_output)
%
%
%
% See also:
% llegir_text_delimitadors_normal

% START FUNCTION

fid = fopen(arxiu_text_output,'w');
fprintf(fid,'%s', dades_write);
fclose(fid);


% END FUNCTION


end


