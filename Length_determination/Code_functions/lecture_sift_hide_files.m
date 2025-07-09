function [theFiles_2] = lecture_sift_hide_files(theFiles)

% It does the screening of a file structure (obtained from the 'dir' function)
% of those hidden elements.
%
% Difference between Windows and Mac
% 
% Temps de processament: 
% Elapsed time: 0.00298 seconds ; 50 iterations in 4.1Gb of RAM memory used
%
% See also
% read_imgs_folder_structure
% 
% 

% START FUNCTION

find_ocult = repelem(false, length(theFiles));

for n_elem = 1:length(theFiles)
    % theFiles(n_elem).name

    % En Windows:
    if ispc
        [~,stats] = fileattrib(fullfile(theFiles(n_elem).folder, theFiles(n_elem).name));
        if stats.hidden
            find_ocult(n_elem) = true;
        end

    elseif ismac
        % En MAC (OSX), els elements ocults comencen per ".":
        if strcmp(theFiles(n_elem).name(1),'.')
            find_ocult(n_elem) = true;
        end

    % elseif isunix

    end
end

theFiles_2 = theFiles(~find_ocult);

% END FUNCTION

end