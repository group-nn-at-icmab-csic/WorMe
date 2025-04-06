function [string_sortida] = llegir_text_delimitadors_normal(arxiu_output)

% Llegir text de string normal.
%
%
% string_total - retorna el string del text.
%
%
% Exemple
% string_josep = "asdfas dfasd fasdf asdf asdf asd" + "asdf asdf asdf asdfasdf " + newline + "adfasdfa" + newline + "ASDASDAD" + newline
% string_josep = "josep writting a book"
% write_normal_unicstr_josep("notes_analysis.txt", string_josep)
% [string_sortida] = llegir_text_delimitadors_normal(arxiu_output)
%
%
%
%
% See also:
% write_normal_unicstr_josep

% INICI FUNCIO

% Llegim l'arxiu
fileID = fopen(arxiu_output,'r');
txt = textscan(fileID,'%s','delimiter','\n');
fclose(fileID);

% size(txt{1})

len_txt = length(txt{1});
if  len_txt > 1
    
    string_sortida = string(txt{1}{1});

    for cada_line = 2:len_txt
        
        string_sortida = string_sortida + newline +  string(txt{1}{cada_line});
    end
else

    string_sortida = string(txt{1}{1});

end


% FINAL FUNCIÓ

end