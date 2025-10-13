function app_interf_boto_textarea_minwidth(app)

% Textarea value change button

% START OF FUNCTION

%value = app.MinWidthTextArea.Value;
           

    % If the value changes, the button is automatically executed.            
    if ~app.MinWidthStateButton.Value
        app.MinWidthStateButton.Value = true;                
    end       
    
    % Update
    app_interf_actualitzacio_graficacio(app, true)
    
    % Refresh figure to enable shortkey
    figure(app.UIFigure)    


% END OF FUNCTION

end