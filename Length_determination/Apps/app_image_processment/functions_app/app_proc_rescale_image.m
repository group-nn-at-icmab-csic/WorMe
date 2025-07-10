function app_proc_rescale_image(app)

% Re-scale the image
%
%
% See also
% app_image_processment



% START OF THE FUNCTION

% __Figure and image positions__
    % Get initial positions and store them
    pos_fig = app.UIFigure.Position;
    pos_img =  app.Image.Position;
    
    % Positions for image 2 and 3
    pos_img_3_1 = app.Image3.Position;     
    
    % Position for hourglass image
    pos_rellotge = app.Image2.Position;
                
    
    % __Object positions__

    % Positions of objects in Left Panel
    %h_determin = findobj(app.LeftPanel,'Type','uibutton');
    h_determin = findall(app.LeftPanel);
    array_positions_buttons = [];
    for cada = 1:length(h_determin)
       boto = h_determin(cada); % define the button
       % store positions
       if isempty(array_positions_buttons)
           array_positions_buttons = [boto.Position];
       else
           array_positions_buttons = [array_positions_buttons; boto.Position];
       end
    end
    
    % Positions of objects in Center Panel
    h_determin_button = findobj(app.CenterPanel,'Type','uibutton');
    array_positions_buttons_centered = [];
    for cada = 1:length(h_determin_button)
       boto_centered = h_determin_button(cada); % define the button
       % store positions
       if isempty(array_positions_buttons_centered)
           array_positions_buttons_centered = [boto_centered.Position];
       else
           array_positions_buttons_centered = [array_positions_buttons_centered; boto_centered.Position];
       end
    end
    

    % Positions of state buttons in Center Panel
    h_determin_buttonstate = findobj(app.CenterPanel,'Type','uistatebutton');
    array_positions_buttonsstate_centered = [];
    for cada = 1:length(h_determin_buttonstate)
       boto_centered = h_determin_buttonstate(cada); % define the button
       % store positions
       if isempty(array_positions_buttonsstate_centered)
           array_positions_buttonsstate_centered = [boto_centered.Position];
       else
           array_positions_buttonsstate_centered = [array_positions_buttonsstate_centered; boto_centered.Position];
       end
    end            


    % _Window state and counters_
    % Get the window state as a string
    string_wind = string(app.UIFigure.WindowState);
    
    % Definition of input/output counters
    has_maximized = false;
    has_normaled = false;
    
    % _Loop entry_
    while_cond = true;
    while while_cond %app.close_stateLabel.Text ~= "close" % From UIFigureCloseRequest callback
        pause(0.001) % Necessary pause
        
        % Define window state
        string_wind = string(app.UIFigure.WindowState);
        
        % If maximized
        if string_wind == 'maximized' && ~has_maximized
            pause(1) % Necessary pause to allow window to open and get correct size
            
            % For the current image:
            
            % Get new figure size
            pos_fig2 = app.UIFigure.Position;

            % Define new scale using
            % rescale_values_img_app
            pos_img2 = rescale_values_img_app(pos_fig, pos_img, pos_fig2);
            
            % AUTOREFLOW modification:
            % We don't want to adjust to the full size of the figure,
            % but rather to the full width of the central panel.
            % With autoreflow, the panel sizes shift,
            % so aesthetic positions differ from the initial.
            % Therefore, adjusting the image to the WIDTH of the center panel
            % yields the correct image scale:
            pos_centrp = app.CenterPanel.Position;
            pos_img2(3) = pos_centrp(3);
            app.Image.Position = round(pos_img2);
            drawnow()
            
            % Images 3_1 and 3_2
            % Define position based on the center of the app,
            % i.e. half the width, which is added or subtracted from x.
            pos_img_3_1_2 = rescale_values_img_app(pos_fig, pos_img_3_1, pos_fig2);
            llargada_centre = pos_fig2(3)/2;
            pos_img_3_1_2(1) = llargada_centre - pos_img_3_1_2(3)*2;

            app.Image3.Position = round(pos_img_3_1_2);

            drawnow()
             
            % Hourglass image
            pos_rellotge_max = pos_rellotge;
            pos_rellotge_max(1) = pos_fig2(3)/2;
            pos_rellotge_max(2) = pos_fig2(4)/2;
            app.Image2.Position = pos_rellotge_max;

            
            % Button adjustments
            array_positions_buttons_new = [];
            [n_botons, ~] = size(array_positions_buttons);
            for cada_boto = 1:n_botons
                pos_boto_old = array_positions_buttons(cada_boto,:);
                pos_boto_new = pos_boto_old;
                pos_boto_rescale = rescale_values_img_app(pos_fig, pos_boto_new, pos_fig2);
                pos_boto_new(2) = pos_boto_rescale(2);
                pos_boto_new(4) = pos_boto_rescale(4);

                % Store in array
                if isempty(array_positions_buttons_new)
                    array_positions_buttons_new = [pos_boto_new];
                else
                    array_positions_buttons_new = [array_positions_buttons_new; pos_boto_new];
                end
            end

            % Change button positions
            % based on defined array
            for cada = 1:length(h_determin)
               boto = h_determin(cada);
               boto.Position = array_positions_buttons_new(cada, :);
            end

            
            % Adjust buttons in Center Panel
            array_positions_buttons_new_central = [];
            [n_botons_central, ~] = size(array_positions_buttons_centered);
            for cada_boto = 1:n_botons_central
                pos_boto_old_central = array_positions_buttons_centered(cada_boto,:);
                pos_boto_new = pos_boto_old_central;
                pos_boto_rescale = rescale_values_img_app(pos_fig, pos_boto_new, pos_fig2);
                pos_boto_new(2) = pos_boto_rescale(2);
                pos_boto_new(4) = pos_boto_rescale(4);

                % Store in array
                if isempty(array_positions_buttons_new_central)
                    array_positions_buttons_new_central = [pos_boto_new];
                else
                    array_positions_buttons_new_central = [array_positions_buttons_new_central; pos_boto_new];
                end
            end
            % Change positions of buttons
            % based on defined array
            for cada = 1:length(h_determin_button)
               boto = h_determin_button(cada);
               boto.Position = array_positions_buttons_new_central(cada, :);
            end
            
            % Adjust state buttons in Center Panel
            array_positions_buttons_new_central_state = [];
            [n_botons_central, ~] = size(array_positions_buttonsstate_centered);
            for cada_boto = 1:n_botons_central
                pos_boto_old_central = array_positions_buttonsstate_centered(cada_boto,:);
                pos_boto_new = pos_boto_old_central;
                pos_boto_rescale = rescale_values_img_app(pos_fig, pos_boto_new, pos_fig2);
                pos_boto_new(2) = pos_boto_rescale(2);
                pos_boto_new(4) = pos_boto_rescale(4);

                % Store in array
                if isempty(array_positions_buttons_new_central_state)
                    array_positions_buttons_new_central_state = [pos_boto_new];
                else
                    array_positions_buttons_new_central_state = [array_positions_buttons_new_central_state; pos_boto_new];
                end
            end
            % Change positions of state buttons
            % based on defined array
            for cada = 1:length(h_determin_buttonstate)
               boto = h_determin_buttonstate(cada);
               boto.Position = array_positions_buttons_new_central_state(cada, :);
            end

            
            % Update counters
            has_maximized = true;
            has_normaled = false;
            
        % If restored to normal
        elseif string_wind == 'normal' && ~has_normaled && has_maximized
            pause(1) % Necessary pause to close window and get correct size
                     % adjustable until length stops varying every 0.1 s.
                      
            % For the current image:
            % Reset image measurements to initial values.
            app.Image.Position = pos_img;
            drawnow()
            app.Image3.Position = pos_img_3_1;

            app.Image2.Position = pos_rellotge;

            % Change buttons
            % based on defined array
            for cada = 1:length(h_determin)
               boto = h_determin(cada);
               boto.Position = array_positions_buttons(cada, :);
            end
            
            % Change buttons in Center Panel
            for cada = 1:length(h_determin_button)
               boto = h_determin_button(cada);
               boto.Position = array_positions_buttons_centered(cada, :);
            end
            
            % Update counters
            has_normaled = true;
            has_maximized = false;
        end

        % Closing the loop:
        if isequal(app.vapp_tancament_loop, "tancar")
           while_cond = false; 
        end
        
    end

% END OF THE FUNCTION



end

