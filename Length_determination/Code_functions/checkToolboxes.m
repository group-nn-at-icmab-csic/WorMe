function checkToolboxes()
    % Lista de toolboxes requeridas (nombres completos)
    requiredToolboxes = {'Computer Vision Toolbox', ...
                         'Image Processing Toolbox', ...
                         'Statistics and Machine Learning Toolbox', ...
                         'Image Acquisition Toolbox'};
    
    % Obtener la lista de toolboxes instaladas
    installedToolboxes = ver;
    installedToolboxNames = {installedToolboxes.Name};
    
    % Verificar si cada toolbox requerida está instalada
    missingToolboxes = {};
    for i = 1:length(requiredToolboxes)
        % Buscar el nombre de la toolbox en la lista de toolboxes instaladas
        if ~any(strcmp(requiredToolboxes{i}, installedToolboxNames))
            % Si la toolbox no está instalada, se añade a la lista de toolboxes faltantes
            missingToolboxes{end+1} = requiredToolboxes{i};
        end
    end
    
    % Si faltan toolboxes, mostrar un mensaje y abrir el Add-On Explorer
    if ~isempty(missingToolboxes)
        % Se crea un mensaje de error que lista las toolboxes faltantes
        errorMessage = sprintf('Los siguientes paquetes no están instalados:\n\n%s\n\n¿Desea abrir el Add-On Explorer para instalarlos?', ...
                               strjoin(missingToolboxes, '\n'));
        
        % Se muestra un cuadro de diálogo de pregunta con botones "Sí" y "No"
        userChoice = questdlg(errorMessage, 'Paquetes Faltantes', 'Sí', 'No', 'Sí');
        
        % Si el usuario elige "Sí", se abre el Add-On Explorer
        if strcmp(userChoice, 'Sí')
            % Abrir el Add-On Explorer de MATLAB
            matlab.addons.supportpackage.internal.explorer.show;
        end
        
        % Detener la ejecución del programa con un mensaje de error
        error('Faltan paquetes necesarios. Por favor, instálelos.');
    else
        % Si no faltan toolboxes, se muestra un mensaje en la consola indicando que todo está en orden
        disp('Todos los paquetes requeridos están instalados.');
    end
end