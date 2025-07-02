function txt_seg(arxiu_output, proces_desenvolupat, delimitador_text, creacio_arxiu, en_blanc)

% Given the name of a file with data in two columns, it is read or created, and content is added to it.

% Example:
%   txt_seg(field_set, "Im2gray", ";;")
%       In this case, if the folder does not exist in the indicated
%       folder (field_set), a new one is created, and if it does
%       exist, it is written on a new line of the file.

% Parameters:
% delimitador_text - Text delimiter.
%                    If not specified, this is defined
%                    as ";".
%           "nou": only reading is done, no new
%                   content is inserted.
%
% creacio_arxiu -    Determines whether or not a file is created, even if one already exists.
%                    If the variable is not defined, a new file is not created
%                    if one already exists.
%
%           "nou" : a new file is created, even if there is
%                   an existing one.
%
% en_blanc -         whether the new file will be blank or not.
%           "blanc" : the newly created file will be blank.
%

% START FUNCTION 

% If the variable 'delimitador_text' is not defined
if ~exist('delimitador_text','var')
    delimitador_text = ";";
end

if ~exist('creacio_arxiu','var')
    creacio_arxiu = "no_definit_nou";
end

if ~exist('en_blanc','var')
    en_blanc = "no_en_blanc";
end



% If the file exists, or if it is stated that a new file is not needed
% (or nothing was stated), the existing file is read.
% Otherwise, if the file does not exist, or if it is stated that a new
% file is needed, a new file is created.
if isfile(arxiu_output) && creacio_arxiu ~= "nou"
    % If the data file exists
    
    % Function --- llegir_text_delimitadors.m ---
    array_processos = llegir_text_delimitadors(arxiu_output, delimitador_text);

    
    [files_text, columnes_text] = size(array_processos);
    %array_processos
    

else
    % If the data file does not exist

    % Creates a new file with the header 'array_processos_nou'
    array_processos_nou = {"Ordre proces" , "Tipus proces"};
    fid = fopen(arxiu_output,'w');
    separador_text = strcat("%s", delimitador_text);
    b = [sprintf(separador_text,array_processos_nou{1:end-1}),array_processos_nou{end}];
    fprintf(fid, strjoin(b,""));
    fclose(fid);
    files_text = 1;
    
end

% So far we have read the file 'proba_settings.txt', or we have created it.
% As an initial identifier, 'proba_settings.txt' has the header 'array_processos_nou'.

% Now what we want is to put content in the file.

% Note that we don't really want to read the entire file, for now, but
% just insert commands into it.

% We add content if
if en_blanc ~= "blanc"

    % Name a new Ordre proces
    num_fila_nova = string(files_text);
    
    % Add content (type cell with strings), to the file:
    afegir_config = {num_fila_nova , proces_desenvolupat};
    fid = fopen(arxiu_output,'a+');
    separador_text = strcat("\n", "%s", delimitador_text);
    b = [sprintf(separador_text,afegir_config{1:end-1}),afegir_config{end}];
    % b = [sprintf('\n%s;',afegir_config{1:end-1}),afegir_config{end}]; %<-Antic
    fprintf(fid, strjoin(b,""));
    fclose(fid);
    
    % Based in:
    % fid = fopen(arxiu_output,'a+');
    % fprintf(fid, "\nPUESBIEN;AQUIESTAMOS");
    % fclose(fid);

end

% END FUNCTION

end