function [buttonpos, str_button_tot] = app_resize_obtenir_positions(h_determin_button)

% Obté les posicions d'una determinat objecte en la app.
%
% Variables
% h_determin_button : findobj d'un tipus de figura
%       exemple: h_determin_button = findobj(app.UIFigure,'Type','uibutton');
%


buttonpos = [];
for cada = 1:length(h_determin_button)
   boto_centered = h_determin_button(cada); % es defineix el botó
   %boto_centered.Position

   % guardem les posicions
    buttonpos = [buttonpos; boto_centered.Position];
end      
%buttonpos

% __Escriptura botons__

% From 
% buttonpos = [333    49    46    40; ...
%    198    49    46    40; ...
%     15   412   100    22]


[rows_but, ~] = size(buttonpos);

str_button_tot = [];
for cada_but = 1:rows_but
    buttonstring = strjoin(string(buttonpos(cada_but, :)), ";");

    % Describim en un sol string
    if isempty(str_button_tot)
        str_button_tot = buttonstring;        
    else
        str_button_tot = strcat(str_button_tot, "$", buttonstring);
    end
end


end


