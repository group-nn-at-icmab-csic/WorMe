function determine_packages()

% Determines whether the described packages are installed in MATLAB. 
% If not, it warns that they must be installed.
%
% When using the program in MATLAB, it requires some toolboxes to be installed.
%
% See also
% look_if_installed

% START FUNCTION

    % Check if installed
    %look_if_installed("vision", "Computer Vision Toolbox")
    look_if_installed("stats", "Statistics and Machine Learning Toolbox")
    look_if_installed('images', 'Image Processing Toolbox')

% END FUNCTION

end