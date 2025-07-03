function app_interf_boto_textarea_minlength(app)

% Botó canviar valor textarea

% INICI FUNCIO

            %value = app.MinLengthTextArea.Value;
            
            % Si es canvia el valor, automàticament s'executa el botó.            
            if ~app.MinLengthStateButton.Value
                app.MinLengthStateButton.Value = true;                
            end       
            
            % Actualitzem
            app_interf_actualitzacio_graficacio(app, true)

            % Actualitzem figura per capacitar shortkey
            figure(app.UIFigure)     

% FINAL FUNCIO

end