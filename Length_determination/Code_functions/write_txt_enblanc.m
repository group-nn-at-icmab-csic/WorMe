function write_txt_enblanc(arxiu_text_output)

% Crea arxiu de text en blanc. Elimina si hi ha existent.
%
%
% Variables
%   input
%       arxiu_text_output : arxiu de text
%
%
% See also


% INICI FUNCIÓ

% arxiu_text_output = "Proba.txt"
fid = fopen(arxiu_text_output,'w');
fclose(fid);


% FINAL FUNCIÓ

end