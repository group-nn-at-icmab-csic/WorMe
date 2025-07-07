function app_proc_button_tutorial(app)

% In app_image_processing App, the button of tutorial.
%
% Shows the buttons of the tutorials.
%
% See also
% app_image_processment


% START OF THE FUNCTION

    value_tutorial = app.TutorialButton.Value;


    % COPIA de APP_NOVA_INTERFAZ


    if value_tutorial

        % __Activació/Desactivacio botons__
        % #Funcio activacio desactivacio botons
        app_proc_activardesactivar_botons_tutorial(app, 'on')

        % __Descripció del color de les figures de la App__
        % Agafem tots els objectes:
        obj_h = findobj(app.UIFigure);
        % Obtenim les propietats del botó.
        h_determin_button = findobj(app.UIFigure,'Type', 'figure');
        h_determin_button.Color = h_determin_button.Color - 0.2;
        % ÇÇ No canvia el color...


        % Cambi color botó tutorial:
        app.TutorialButton.BackgroundColor = [0.9290 0.6940 0.1250];
                % Normal: [0.9600    0.9600    0.9600]
                % Tronja fosc: [0.8500 0.3250 0.0980]
                % Tronja clar: [0.9290 0.6940 0.1250]


        % Correccio que no surti ultim frame
        %imshow("Apps\app_nova_interfaz_nova\Imatges_utilitat\imatge_background_fosc.png", 'Parent', app.UIAxes2);            


    % Si està activat el botó de Tutorial (sortir) = Com sempre
    else


        % _Activem/Desactivem botóns tutorial_
        app_proc_activardesactivar_botons_tutorial(app, 'off')


        % __Descripció del color de les figures de la App__
        % Agafem tots els objectes:
        obj_h = findobj(app.UIFigure);
        figure_objects_names_filtr = unique(get(obj_h,'Type'));

        % Si volem filtar els objectes:
        %figure_objects_names_filtr_BackgroundColor = unique(figure_objects_names_filtr(ismember(figure_objects_names_filtr, ["uibutton"])));
        figure_objects_names_filtr_Color = unique(figure_objects_names_filtr(ismember(figure_objects_names_filtr, ["figure"])));            
            
        % Per cada objecte:
        for n_figure_object = 1:length(figure_objects_names_filtr_Color)
            figure_object = figure_objects_names_filtr_Color{n_figure_object};

            % Obtenim les propietats del botó.
            h_determin_button = findobj(app.UIFigure,'Type', figure_object);
            h_determin_button.Color = [0.9400 0.9400 0.9400];

        end                       
        % [0.9400 0.9400 0.9400]


        % Cambi color botó tutorial:
        app.TutorialButton.BackgroundColor = [0.9600    0.9600    0.9600];
                % Normal: [0.9600    0.9600    0.9600]
                % Tronja fosc: [0.8500 0.3250 0.0980]
                % Tronja clar: [0.9290 0.6940 0.1250]                

    end



    % Actualitzem figura per capacitar shortkey
    figure(app.UIFigure)  

% END OF THE FUNCTION


end