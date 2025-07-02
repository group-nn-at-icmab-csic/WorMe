function write_str_txt(file_txt, str_write)

% Escriu a string to a txt.
% If the file does not exist, it creates a new one, otherwise, write a line skip
%
% Variables
% file_txt - .txt file path.   example: "proba.txt"
% str_write - string to write.   example: "imatges_68_69"
% 
% See also


% START FUNCTION

if ~isfile(file_txt)

    fid = fopen(file_txt,'w');
    fprintf(fid,'%s', str_write);
    fclose(fid);

else

    fid = fopen(file_txt,'a+');    
    fprintf(fid,'\n%s', strcat(str_write));
    fclose(fid);
end


% % Check
% !notepad proba.txt


% END FUNCTION

end