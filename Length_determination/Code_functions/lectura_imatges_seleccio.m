function [theFiles] = lectura_imatges_seleccio()

% Es realitza la funció manual d'una o varies imatges, i s'obté l'arxiu
% d'estructura d'aquestes (theFiles) per a la seva possible operació.

% INICI FUNCIÓ

[filename, pathname] = uigetfile({['*.jpg;*.png;*.jpeg;*.tif;*.tiff;*.jfif;*.bmp']; '*.jpg'; '*.png'; '*.jpeg'; '*.tif'; '*.tiff'; '*.jfif'; '*.bmp'; '*.*'}, 'MultiSelect','on');


arxius_directoris = strcat(pathname, filename);
% Per cada patró
for n_filep = 1:length(arxius_directoris)
        
    % Obtenció estructura del patró
    struct_fileP = dir(arxius_directoris{n_filep});

    
    if n_filep == 1
        theFiles = struct_fileP;
    else
            if isempty(theFiles)
                % Si és vuit l'arxiu theFiles (no s'ha obtingut imatges d'aquest tipus anteriors).
                theFiles = struct_fileP;
            else
                % S'uneixen les estructures
                theFiles = cell2struct([struct2cell(theFiles),struct2cell(struct_fileP)],fieldnames(theFiles),1);

                
            end
        
    end

end

% FINAL FUNCIÓ


end