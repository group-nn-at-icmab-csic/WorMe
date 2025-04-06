function pkg_install(pkgPath)
    % "Install" a package of MATLAB code by appending its search path addition to startup.m.
    %
    %
    % MATLAB's behavior on startup includes execution of a `startup.m` file located at the
    % userpath, should one be found. Appending `addpath` statements aimed at the directories
    % of MATLAB code a user wishes to "install" with their MATLAB installation allows
    % functions and scripts to be globally available on the MATLAB searchpath upon each
    % subsequent startup of MATLAB, allowing useful tools and functionality to be readily
    % available.
    %
    % This code is fairly simple to use, but it is recommended to use it on itself to add it
    % to the search path to enable its use elsewhere. A script is included to perform this
    % operation.
    %
    % Usage
    % -----
    % pkg_install(PATH_TO_PACKAGE)
    % --------------------------------------------------------------------------------------

    % deal with Windows filesep incompatibilities
    process_path = @(oldPath) strrep(oldPath, '\', '/');
    
    % build the installation expression and translate it to regexp for checking
    installCommand = "\n" + "addpath('" + process_path(pkgPath) + "');";
    installCommandRegExp = regexptranslate('escape', installCommand);
    startupFilePath = process_path(fullfile(userpath, "startup.m"));

    % open the startup file or create if one doesn't exist
    fileID = fopen(startupFilePath, 'a');
    
    % determine if the startup.m file already contains an `addpath` for the package
    startupFileText = fileread(startupFilePath);
    matches = regexp(startupFileText, installCommandRegExp, 'match');
    
    % add the new search path to startup.m if no command exists for the package or throw an
    % exception if the command already exists
    if isempty(matches)
        fprintf(fileID, installCommand);
        fprintf("Installing " + process_path(pkgPath) + " to MATLAB's search path.\n");
        fprintf("To remove the package, see " + startupFilePath + ".\n");
    else
        fclose(fileID);
        error("The package already appears to be added to the search path upon " + ...
              "startup. Check your startup.m file.");    
    end

    fclose(fileID);
end

