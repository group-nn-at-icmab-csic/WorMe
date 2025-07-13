function [buttonpos, str_button_tot] = app_resize_obtenir_positions(h_determin_button)

% Gets the positions of a given set of objects (buttons) in the app.
%
% Variables
% h_determin_button : findobj result of a certain type of figure element
%       example: h_determin_button = findobj(app.UIFigure,'Type','uibutton');
%

% START OF THE FUNCTION

buttonpos = [];
for cada = 1:length(h_determin_button)
   boto_centered = h_determin_button(cada); % define the button
   % boto_centered.Position

   % store the positions
    buttonpos = [buttonpos; boto_centered.Position];
end      
% buttonpos

% __Writing buttons__

% Example format of buttonpos: 
% buttonpos = [333    49    46    40; ...
%              198    49    46    40; ...
%               15   412   100    22]

[rows_but, ~] = size(buttonpos);

str_button_tot = [];
for cada_but = 1:rows_but
    buttonstring = strjoin(string(buttonpos(cada_but, :)), ";");

    % Describe all positions in a single string
    if isempty(str_button_tot)
        str_button_tot = buttonstring;        
    else
        str_button_tot = strcat(str_button_tot, "$", buttonstring);
    end
end

% END OF THE FUNCTION

end


