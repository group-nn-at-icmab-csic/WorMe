function [UIFigure_position_new] = centered_GUI_screen(UIFigure_position, screensize_position)

% Given the position of the GUI and the screen, returns the position of the
% GUI so that it is in the middle of the screen.
%
% The positions can be obtained in the following way:
%
% To obtain the position of the GUI:
% UIFigure_position = app.UIFigure.Position; 
% 100       100     602     389
% start     end     width   length
%
% To obtain the position of the screen:
% screensize_position = get(0, 'ScreenSize'); % 1 1 1920 1080

amplada_new = ceil(screensize_position(3)/2 - UIFigure_position(3)/2);

llargada_new = ceil(screensize_position(4)/2 - UIFigure_position(4)/2);

UIFigure_position_new = [amplada_new, llargada_new, UIFigure_position(3), UIFigure_position(4)];

end
            
            