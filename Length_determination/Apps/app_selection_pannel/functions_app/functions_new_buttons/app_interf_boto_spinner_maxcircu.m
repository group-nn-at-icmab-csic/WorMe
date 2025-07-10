function app_interf_boto_spinner_maxcircu(app)

% Textarea value change button

% START OF FUNCTION

% Spinner Round Filter Value Change button
            
            value_roundText = app.SpinnerRound.Value; % 1, 2 , 3...
            
            % If the value is numeric
            if ~isempty(value_roundText)
                
                % If the value is greater than 1, assign value 1:
                if value_roundText > 1
                    value_roundText = 1;
                    
                % If the value is less than zero, set value to zero:
                elseif value_roundText < 0
                    value_roundText = 0;         
                    
                end                
                
            % If the value is not numeric, set it to zero.
            else
                value_roundText = 0;
                
            end
            
            app.SpinnerRound.Value = value_roundText;


            % Activate the button
            app.MaxCircularityButton.Value = true;           
            
            
            % Update
            app_interf_actualitzacio_graficacio(app, true)

            % Refresh figure to enable shortkey
            figure(app.UIFigure)   

% END OF FUNCTION


end