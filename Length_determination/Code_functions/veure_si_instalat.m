function veure_si_instalat(string_installator, nom_instalador)

% Retorna un message box si no està instalat el paquet determinat.
%
% Variables
% string_installator    :   nom del paquet segons https://es.mathworks.com/matlabcentral/answers/377731-how-do-features-from-license-correspond-to-names-from-ver
% nom_instalador : nom del paquet

toolbox_vision = ver(string_installator);
if isempty(toolbox_vision)
    waitfor(msgbox([strcat("You need to install the ", nom_instalador, " toolbox."), " ", "You can install it going on:  ' Home -> Add-Ons ' and seraching for it.",  " " , "You can use the command ' ver ' to see MATLAB packages installed on you computer.",], "Note", 'help'))
end