function write_str_txt(file_txt, str_write)

% Escriu un string a un txt.
% Si no existeix l'arxiu crea un de nou, sino escriu en un salt de línea
%
% Variables
% file_txt - .txt file rute.   ex: "proba.txt"
% str_write - string to write.   ex: "imatges_68_69"
% 
% See also


% INICI FUNCIÓ

if ~isfile(file_txt)

    fid = fopen(file_txt,'w');
    fprintf(fid,'%s', str_write);
    fclose(fid);

else

    fid = fopen(file_txt,'a+');    
    fprintf(fid,'\n%s', strcat(str_write));
    fclose(fid);
end


% % Comprovació
% !notepad proba.txt


% FINAL FUNCIÓ

end