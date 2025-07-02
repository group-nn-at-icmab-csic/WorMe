function [theFiles] = lectura_imatges_seleccio()

% The manual function of one or several images is performed, and the file
% structure of these (theFiles) is obtained for their possible operation.

% START FUNCTION

[filename, pathname] = uigetfile({['*.jpg;*.png;*.jpeg;*.tif;*.tiff;*.jfif;*.bmp']; '*.jpg'; '*.png'; '*.jpeg'; '*.tif'; '*.tiff'; '*.jfif'; '*.bmp'; '*.*'}, 'MultiSelect','on');


arxius_directoris = strcat(pathname, filename);
% For every pattern
for n_filep = 1:length(arxius_directoris)
        
    % Obtain the pattern structure
    struct_fileP = dir(arxius_directoris{n_filep});

    
    if n_filep == 1
        theFiles = struct_fileP;
    else
            if isempty(theFiles)
                % If theFiles file is eight (no previous images of this type were obtained).
                theFiles = struct_fileP;
            else
                % Joining of the structures
                theFiles = cell2struct([struct2cell(theFiles),struct2cell(struct_fileP)],fieldnames(theFiles),1);

                
            end
        
    end

end

% FINAL OF THE FUNCTION


end