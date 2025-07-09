function determine_packages()

% Determina si els paquets descrits són instalats en el software MATALB de
% l'ordinador. Si no s'alerta que han de ser instalats
%
% Quan es fa servir el programa en MATLAB, aquet requereix tenir instal·lat alguns toolboxes.
%
% See also
% look_if_installed

% START FUNCTION

    % Determinació per Image Processing Toolbox
    %look_if_installed("vision", "Computer Vision Toolbox")
    look_if_installed("stats", "Statistics and Machine Learning Toolbox")
    look_if_installed('images', 'Image Processing Toolbox')

% END FUNCTION

end