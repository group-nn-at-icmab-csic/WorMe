function checkToolboxes()
    % List of required toolboxes (full names)
    requiredToolboxes = {'Computer Vision Toolbox', ...
                         'Image Processing Toolbox', ...
                         'Statistics and Machine Learning Toolbox', ...
                         'Image Acquisition Toolbox'};
    
    % Get the list of installed toolboxes
    installedToolboxes = ver;
    installedToolboxNames = {installedToolboxes.Name};
    
   % Check if each required toolbox is installed
    missingToolboxes = {};
    for i = 1:length(requiredToolboxes)
        % Search for the toolbox name in the list of installed toolboxes
        if ~any(strcmp(requiredToolboxes{i}, installedToolboxNames))
             % If the toolbox is not installed, add it to the list of missing toolboxes
            missingToolboxes{end+1} = requiredToolboxes{i};
        end
    end
    
     % If there are missing toolboxes, display a message and open the Add-On Explorer
    if ~isempty(missingToolboxes)
       % Create an error message listing the missing toolboxes
        errorMessage = sprintf('Los siguientes paquetes no están instalados:\n\n%s\n\n¿Desea abrir el Add-On Explorer para instalarlos?', ...
                               strjoin(missingToolboxes, '\n'));
        
        % Show a question dialog box with "Yes" and "No" buttons
        userChoice = questdlg(errorMessage, 'Paquetes Faltantes', 'Sí', 'No', 'Sí');
        
        % If the user chooses "Sí", open the Add-On Explorer
        if strcmp(userChoice, 'Sí')
            % Open the MATLAB Add-On Explorer
            matlab.addons.supportpackage.internal.explorer.show;
        end
        
        % Stop the execution of the program with an error message
        error('Faltan paquetes necesarios. Por favor, instálelos.');
    else
        % If no toolboxes are missing, display a message in the console indicating everything is fine
        disp('Todos los paquetes requeridos están instalados.');
    end
end