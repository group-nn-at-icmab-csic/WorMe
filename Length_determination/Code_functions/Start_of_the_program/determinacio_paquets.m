function determinacio_paquets()

% Determina si els paquets descrits són instalats en el software MATALB de
% l'ordinador. Si no s'alerta que han de ser instalats
%
% Quan es fa servir el programa en MATLAB, aquet requereix tenir instal·lat alguns toolboxes.
%
% See also
% veure_si_instalat

% START FUNCTION

    % Determinació per Image Processing Toolbox
    %veure_si_instalat("vision", "Computer Vision Toolbox")
    veure_si_instalat("stats", "Statistics and Machine Learning Toolbox")
    veure_si_instalat('images', 'Image Processing Toolbox')

% END FUNCTION

end