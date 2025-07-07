function app_proc_button_tutorial(app)

% In app_image_processing App, the button of tutorial.
%
% Shows the buttons of the tutorials.
%
% See also
% app_image_processment


% START OF THE FUNCTION

    value_tutorial = app.TutorialButton.Value;

    % COPY of APP_NOVA_INTERFAZ


    if value_tutorial

        % __Activation/Deactivation of buttons__
        % #Function to activate/deactivate buttons
        app_proc_activardesactivar_botons_tutorial(app, 'on')

        % __Description of the color of the App figures__
        % Get all objects:
        obj_h = findobj(app.UIFigure);
        % Get the properties of the button.
        h_determin_button = findobj(app.UIFigure,'Type', 'figure');
        h_determin_button.Color = h_determin_button.Color - 0.2;
        % Does not change the color...


        % Change tutorial button color:
        app.TutorialButton.BackgroundColor = [0.9290 0.6940 0.1250];
                % Normal: [0.9600    0.9600    0.9600]
                % Dark orange: [0.8500 0.3250 0.0980]
                % Light orange: [0.9290 0.6940 0.1250]


        % Correction to avoid showing the last frame
        %imshow("Apps\app_nova_interfaz_nova\Imatges_utilitat\imatge_background_fosc.png", 'Parent', app.UIAxes2);            


    % If the Tutorial button is activated (exit) = As usual
    else


        % _Activate/Deactivate tutorial buttons_
        app_proc_activardesactivar_botons_tutorial(app, 'off')


        % __Description of the color of the App figures__
        % Get all objects:
        obj_h = findobj(app.UIFigure);
        figure_objects_names_filtr = unique(get(obj_h,'Type'));

        % If we want to filter the objects:
        %figure_objects_names_filtr_BackgroundColor = unique(figure_objects_names_filtr(ismember(figure_objects_names_filtr, ["uibutton"])));
        figure_objects_names_filtr_Color = unique(figure_objects_names_filtr(ismember(figure_objects_names_filtr, ["figure"])));            
            
        % For each object:
        for n_figure_object = 1:length(figure_objects_names_filtr_Color)
            figure_object = figure_objects_names_filtr_Color{n_figure_object};

            % Get the properties of the button.
            h_determin_button = findobj(app.UIFigure,'Type', figure_object);
            h_determin_button.Color = [0.9400 0.9400 0.9400];

        end                       
        % [0.9400 0.9400 0.9400]


        % Change tutorial button color:
        app.TutorialButton.BackgroundColor = [0.9600    0.9600    0.9600];
                % Normal: [0.9600    0.9600    0.9600]
                % Dark orange: [0.8500 0.3250 0.0980]
                % Light orange: [0.9290 0.6940 0.1250]                

    end



    % Update figure to enable shortkey
    figure(app.UIFigure)  

% END OF THE FUNCTION


end