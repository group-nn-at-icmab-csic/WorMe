function center_the_app_GUI(app)

% Centers the app in the middle of the screen
%
% 
% See also:
% centered_GUI_screen


% FUNCTION START

    UIFigure_position = app.UIFigure.Position;  %   100    100   602    389
                                                %   start  end   width  length
    screensize_position = get(0, 'ScreenSize'); %   1      1     1920   1080
    [UIFigure_position_new] = centered_GUI_screen(UIFigure_position, screensize_position);
    app.UIFigure.Position = UIFigure_position_new;


% FUNCTION END

end