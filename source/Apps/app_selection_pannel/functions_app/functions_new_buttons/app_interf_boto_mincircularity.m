function app_interf_boto_mincircularity(app)

% Minimum circularity button


% true: pressed
% false: released

% Note: this button will determine the value of the filters.

% Spinner:
% app.SpinnerRound.Value

% START OF FUNCTION

    % value_buttonstate_round = app.MaxCircularityButton.Value;

    % __Update and Plotting__ %
    app_interf_actualitzacio_graficacio(app, true)


    % Refresh figure to enable shortkey
    figure(app.UIFigure)       

% END OF FUNCTION

end