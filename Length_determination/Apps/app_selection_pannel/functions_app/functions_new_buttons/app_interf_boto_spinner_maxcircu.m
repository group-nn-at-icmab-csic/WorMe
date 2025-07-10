function app_interf_boto_spinner_maxcircu(app)

% Botó canviar valor textarea

% INICI FUNCIO

% Spinner Round Filter Value Change button
            
            value_roundText = app.SpinnerRound.Value; % 1, 2 , 3...
            
            % Si el valor és numèric
            if ~isempty(value_roundText)
                
                % Si el valor és superior a 1, asignem valor 1:
                if value_roundText > 1
                    value_roundText = 1;
                    
                % Si el valor és inferior a zero, posem valor igual a zero:
                elseif value_roundText < 0
                    value_roundText = 0;         
                    
                end                
                
            % Si el valor no és numèric, posem igual a zero.
            else
                value_roundText = 0;
                
            end
            
            app.SpinnerRound.Value = value_roundText;


            % Activem el botó
            app.MaxCircularityButton.Value = true;           
            
            
            
            % ÇÇÇÇ Aplicació filtres sense avançament. (sols modifica la GUI?)
            
            % Actualitzem
            app_interf_actualitzacio_graficacio(app, true)

            % Actualitzem figura per capacitar shortkey
            figure(app.UIFigure)   

% FINAL FUNCIO

end