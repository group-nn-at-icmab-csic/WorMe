function veure_si_instalat(string_installator, nom_instalador)

% Returns a message box if the package is not installed.
%
% Variables
% string_installator    :   name of the package according to https://es.mathworks.com/matlabcentral/answers/377731-how-do-features-from-license-correspond-to-names-from-ver
% nom_instalador : name of the package

toolbox_vision = ver(string_installator);
if isempty(toolbox_vision)
    waitfor(msgbox([strcat("You need to install the ", nom_instalador, " toolbox."), " ", "You can install it going on:  ' Home -> Add-Ons ' and seraching for it.",  " " , "You can use the command ' ver ' to see MATLAB packages installed on you computer.",], "Note", 'help'))
end