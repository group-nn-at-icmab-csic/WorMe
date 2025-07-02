function write_txt_enblanc(arxiu_text_output)

% Creates a blank text file. Delete if it exists.
%
%
% Variables
%   input
%       arxiu_text_output : text file
%
%
% See also


% START FUNCTION

% arxiu_text_output = "Proba.txt"
fid = fopen(arxiu_text_output,'w');
fclose(fid);


% END FUNCTION

end