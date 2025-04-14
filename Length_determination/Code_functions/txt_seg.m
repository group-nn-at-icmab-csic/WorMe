function txt_seg(arxiu_output, proces_desenvolupat, delimitador_text, creacio_arxiu, en_blanc)

% Donat el nom d'un arxiu amb dades en dues columnes, es llegeix o es crea aquest, i se li afegeix contingut.

% Exemple:
%   txt_seg(field_set, "Im2gray", ";;")
%               En aquest cas, si no hi ha la carpeta en el directori
%               indicat (field_set), se'n crea una de nova, i si sí que
%               existeix s'escriu en una línea nova de l'arxiu.


% Paràmetres:
%               delimitador_text - Delimitador de text.
%
%                                   Si no s'especifica, aquest es defineix
%                                   com ";".
%                           "nou" : nomès es fa lectura, no es fica nou
%                           contingut.
%
%               creacio_arxiu - Determina si es crea o no un arxiu, tot i haventhi un d'existent.
%                               Si no es defineix la variable, no es crea
%                               un arxiu nou si n'hi ha un d'existent.
%
%                          "nou" : es crea un arxiu nou, tot i que hi hagi
%                          un d'existent.
%
%               en_blanc - si l'arxiu nou serà en blanc o no.
%                           "blanc" : l'arxiu nou creat serà en blanc.
%

% INICI FUNCIÓ

% Si no es defineix la variable 'delimitador_text'
if ~exist('delimitador_text','var')
    delimitador_text = ";";
end

if ~exist('creacio_arxiu','var')
    creacio_arxiu = "no_definit_nou";
end

if ~exist('en_blanc','var')
    en_blanc = "no_en_blanc";
end



% Si l'arxiu existeix, o bé si s'ha indicat que no se'n vol fer un de nou ( o no s'ha indicat res),
% es llegeix l'arxiu existent.
% Del contrari si no existeix l'arxiu, o si s'especifica que se'n vol fer un de 
% nou, es crea un arxiu nou.
if isfile(arxiu_output) && creacio_arxiu ~= "nou"
    % Si existeix l'arxiu de dades
    
    % Funció --- llegir_text_delimitadors.m ---
    array_processos = llegir_text_delimitadors(arxiu_output, delimitador_text);

    
    [files_text, columnes_text] = size(array_processos);
    %array_processos
    

else
    % Si no existeix l'arxiu de dades

    % Crea nou arxiu amb l'encapçalament 'arrat_processos_nou'
    array_processos_nou = {"Ordre proces" , "Tipus proces"};
    fid = fopen(arxiu_output,'w');
    separador_text = strcat("%s", delimitador_text);
    b = [sprintf(separador_text,array_processos_nou{1:end-1}),array_processos_nou{end}];
    fprintf(fid, strjoin(b,""));
    fclose(fid);
    files_text = 1;
    
end

% Fins aqui hem llegit l'arxiu 'proba_settings.txt', o bé l'hem creat.
% Com a distintiu inicial, 'proba_settings.txt' té l'encapçalament.

% Ara el que es vol és ficar contingut en l'arxiu.

% Nota que realment no es vol llegir l'arxiu complert, pel moment, sino
% sols insertar-hi comandaments.

%Afegim contingut, si 
if en_blanc ~= "blanc"

    % Nom Ordre proces nou
    num_fila_nova = string(files_text);
    
    % Afegim contingut (tipus cell amb stirngs), a l'arxiu:
    afegir_config = {num_fila_nova , proces_desenvolupat};
    fid = fopen(arxiu_output,'a+');
    separador_text = strcat("\n", "%s", delimitador_text);
    b = [sprintf(separador_text,afegir_config{1:end-1}),afegir_config{end}];
    % b = [sprintf('\n%s;',afegir_config{1:end-1}),afegir_config{end}]; %<-Antic
    fprintf(fid, strjoin(b,""));
    fclose(fid);
    
    % Ens basem en:
    % fid = fopen(arxiu_output,'a+');
    % fprintf(fid, "\nPUESBIEN;AQUIESTAMOS");
    % fclose(fid);

end

% FINAL FUNCIÓ

end