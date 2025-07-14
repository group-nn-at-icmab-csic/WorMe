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

        % __Activation/Deactivation of buttons__
        app_interf_activdesactiv_botons_tutorial(app, 'on')


        % Activation/Deactivation of return button
        if app.ReturnButton.Visible == 'off'
            app.ReturnButton.Visible = 'on';
            app.ReturnButton.Enable = 'off';
        end


        % __Description of the color of the App figures__
        
        % We take all the objects:
        obj_h = findobj(app.UIFigure);
        figure_objects_names_filtr = unique(get(obj_h,'Type'));

        % If we want to filter the objects:
        %figure_objects_names_filtr_BackgroundColor = unique(figure_objects_names_filtr(ismember(figure_objects_names_filtr, ["uibutton"])));
        figure_objects_names_filtr_Color = unique(figure_objects_names_filtr(ismember(figure_objects_names_filtr, ["figure"])));            
        
        % For each object:
        for n_figure_object = 1:length(figure_objects_names_filtr_Color)
            figure_object = figure_objects_names_filtr_Color{n_figure_object};

            % We obtain the properties of the button.
            h_determin_button = findobj(app.UIFigure,'Type', figure_object);
            h_determin_button.Color = h_determin_button.Color - 0.2;
%                 [~, str_button_tot] = app_resize_obtenir_positions(h_determin_button);
%                 app.figures_savedpos{end+1} = str_button_tot;
        end 



        % Change tutorial button color:
        app.TutorialButton.BackgroundColor = [0.9290 0.6940 0.1250];
                % Normal: [0.9600    0.9600    0.9600]
                % Dark orange: [0.8500 0.3250 0.0980]
                % Light orange: [0.9290 0.6940 0.1250]


    % Test opening video in compiled version:
    % winopen("Imatges_logos_musica/Videos/Los Simpson - yogurlado (castellano).mp4");


        % Correction so the last frame does not appear
        imshow(fullfile('Apps', 'app_selection_pannel', 'images_useful', 'imatge_background_fosc.png'), 'Parent', app.UIAxes2);            


    % If the Tutorial button is activated (exit) = As usual
    else


        % __Description of the color of the App figures__
        % We take all the objects:
        obj_h = findobj(app.UIFigure);
        figure_objects_names_filtr = unique(get(obj_h,'Type'));

        % If we want to filter the objects:
        %figure_objects_names_filtr_BackgroundColor = unique(figure_objects_names_filtr(ismember(figure_objects_names_filtr, ["uibutton"])));
        figure_objects_names_filtr_Color = unique(figure_objects_names_filtr(ismember(figure_objects_names_filtr, ["figure"])));            
        
        % For each object:
        for n_figure_object = 1:length(figure_objects_names_filtr_Color)
            figure_object = figure_objects_names_filtr_Color{n_figure_object};

            % We obtain the properties of the button.
            h_determin_button = findobj(app.UIFigure,'Type', figure_object);
            h_determin_button.Color = [0.9400 0.9400 0.9400];

        end                       
        % [0.9400 0.9400 0.9400]


        % __Activation/Deactivation of buttons__
        app_interf_activdesactiv_botons_tutorial(app, 'off')


        % Activation/Deactivation of return button
        if app.ReturnButton.Visible == 'on' && app.ReturnButton.Enable == 'off'
            %app.ReturnButton.Visible = 'off';
            %app.ReturnButton.Enable = 'off';
        end                

        % Change tutorial button color:
        app.TutorialButton.BackgroundColor = [0.9600    0.9600    0.9600];
                % Normal: [0.9600    0.9600    0.9600]
                % Dark orange: [0.8500 0.3250 0.0980]
                % Light orange: [0.9290 0.6940 0.1250]                


        % Correction so the last frame does not appear
        imshow(fullfile('Apps', 'app_selection_pannel', 'images_useful', 'imatge_background_clar.png'), 'Parent', app.UIAxes2);


    end



%             app.ReturnButton.Visible = 'on';

    % Update figure to enable shortkey
    figure(app.UIFigure)       

% FINAL OF THE FUNCTION



end
 