function [theFiles] = read_imgs_folder_structure(myFolder)

% Given a folder, determined for example by uigetdir(), e.g. C/User/etc..., returns a structure of the files (dir function) in it.
% It is aimed at files being images.
%
%
% Image types '.gif' and '*.webp' are excluded.


% START FUNCTION


%GET A ALL IMAGE FILES LIST
% Get a list of all files in the folder with the desired file name pattern.


% _Different image formats_

% Obtain more than one image file (ex: jpg i png)
filePattern = fullfile(myFolder, {'*.jpg', '*.png', '*.jpeg', '*.tif', '*.tiff', '*.jfif', '*.bmp'}); %Excluded: '*.gif' i '*.webp'

% disp('filePattern')
% filePattern

% Each pattern (.jpg, .png, etc...) generates a different type of reading
% (filePattern). Then it checks if there are files of this type (dir), and if
% there are or not, they are added to theFiles.

% For every pattern
for n_filep = 1:length(filePattern)
        
    % Obtain the structure of the pattern
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
                % Structures are joined
                theFiles = cell2struct([struct2cell(theFiles),struct2cell(struct_fileP)],fieldnames(theFiles),1);

                
            end
    end
end

% Filter hidden elements:
[theFiles] = lecture_sift_hide_files(theFiles);

% END FUNCTION


end