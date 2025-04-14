function [UIFigure_position_new] = centered_GUI_screen(UIFigure_position, screensize_position)

% Donada la posició de la GUI i de la pantalla, es retorna la posició de la
% GUI de manera que aquesta quedi en la meitat de la pantalla.
%
%
% Les posicions es poden obtenir de la següent forma:
%
% Per a obtenir la posició de la figura:
% UIFigure_position = app.UIFigure.Position; %100   100   602      389
%                                             inici final amplada  llargada
%
% Per a obtenir la posició de la pantalla:
% screensize_position = get(0, 'ScreenSize'); %         1           1        1920        1080

amplada_new = ceil(screensize_position(3)/2 - UIFigure_position(3)/2);

llargada_new = ceil(screensize_position(4)/2 - UIFigure_position(4)/2);

UIFigure_position_new = [amplada_new, llargada_new, UIFigure_position(3), UIFigure_position(4)];

end
            
            