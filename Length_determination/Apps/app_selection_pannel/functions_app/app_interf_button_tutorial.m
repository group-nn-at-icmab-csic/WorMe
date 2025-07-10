function app_interf_button_tutorial(app)

% Tutorial button of app_selection_pannel App.
%
% Shows the tutorial shortkeys and information buttons.
%
% See also
% app_selection_pannel


% START OF THE FUNCTION   


    value_tutorial = app.TutorialButton.Value;
    

    if value_tutorial

        % __Activació/Desactivacio botons__
        app_interf_activdesactiv_botons_tutorial(app, 'on')


        % Activacio/Desactivacio boto return
        if app.ReturnButton.Visible == 'off'
            app.ReturnButton.Visible = 'on';
            app.ReturnButton.Enable = 'off';
        end


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
            h_determin_button.Color = h_determin_button.Color - 0.2;
%                 [~, str_button_tot] = app_resize_obtenir_positions(h_determin_button);
%                 app.figures_savedpos{end+1} = str_button_tot;
        end 



        % Cambi color botó tutorial:
        app.TutorialButton.BackgroundColor = [0.9290 0.6940 0.1250];
                % Normal: [0.9600    0.9600    0.9600]
                % Tronja fosc: [0.8500 0.3250 0.0980]
                % Tronja clar: [0.9290 0.6940 0.1250]


    % Proba obrir video en compilat:
    % winopen("Imatges_logos_musica\Videos\Los Simpson - yogurlado (castellano).mp4");


        % Correccio que no surti ultim frame
        imshow("Apps\app_selection_pannel\images_useful\imatge_background_fosc.png", 'Parent', app.UIAxes2);            


    % Si està activat el botó de Tutorial (sortir) = Com sempre
    else


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


        % __Activació/Desactivacio botons__
        app_interf_activdesactiv_botons_tutorial(app, 'off')


        % Activacio/Desactivacio boto return
        if app.ReturnButton.Visible == 'on' && app.ReturnButton.Enable == 'off'
            %app.ReturnButton.Visible = 'off';
            %app.ReturnButton.Enable = 'off';
        end                

        % Cambi color botó tutorial:
        app.TutorialButton.BackgroundColor = [0.9600    0.9600    0.9600];
                % Normal: [0.9600    0.9600    0.9600]
                % Tronja fosc: [0.8500 0.3250 0.0980]
                % Tronja clar: [0.9290 0.6940 0.1250]                


        % Correccio que no surti ultim frame
        imshow("Apps\app_selection_pannel\images_useful\imatge_background_clar.png", 'Parent', app.UIAxes2);


    end





%             app.ReturnButton.Visible = 'on';

    % Actualitzem figura per capacitar shortkey
    figure(app.UIFigure)       

% FINAL OF THE FUNCTION


end
 