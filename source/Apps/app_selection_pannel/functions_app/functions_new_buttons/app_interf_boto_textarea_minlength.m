function app_interf_boto_textarea_minlength(app)

% Textarea value change button

% START OF FUNCTION

            %value = app.MinLengthTextArea.Value;
            
            % If the value changes, the button is automatically executed.
            if ~app.MinLengthStateButton.Value
                app.MinLengthStateButton.Value = true;                
            end       
            
            % Update
            app_interf_actualitzacio_graficacio(app, true)

            % Refresh figure to enable shortkey
            figure(app.UIFigure)     

% END OF FUNCTION

end