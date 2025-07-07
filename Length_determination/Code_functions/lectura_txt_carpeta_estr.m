function [theFiles] = lectura_txt_carpeta_estr(myFolder)

% Given a folder, determined for example in uigetdir(), ex: C/User/etc..., a structure of the files (dir function) of it is returned.
% It is oriented so that the files are text.
%
% See also
% lectura_imatges_carpeta_estr

% START FUNCTION

%GET A ALL IMAGE FILES LIST
% Get a list of all files in the folder with the desired file name pattern.


% _Different image format files_

% Obtain mor than one image file (ex: jpg i png)
filePattern = fullfile(myFolder, {'*.txt'});

% Each pattern (.jpg, .png, etc...) generates a different type of reading
% (filePattern). Then it checks if there are files of this type (dir), and if
% there are any, they are added to theFiles.


% For every pattern
for n_filep = 1:length(filePattern)
        
    % Obtain the pattern structure
    filePattern_tot = filePattern{n_filep};
    %filePattern_tot
    struct_fileP = dir(filePattern_tot);

    
    if n_filep == 1
        theFiles = struct_fileP;
    else
            if isempty(theFiles)
                % If theFiles file is eight (no previous images of this type were obtained).
                theFiles = struct_fileP;
            else
                % Structure joining
                theFiles = cell2struct([struct2cell(theFiles),struct2cell(struct_fileP)],fieldnames(theFiles),1);

                
            end
    end
end
   

% % _One format d'imatge_
% filePattern = fullfile(myFolder, '*.jpg'); % Change to whatever pattern you need.
% theFiles = dir(filePattern);

% FINAL OF THE FUNCTION



end