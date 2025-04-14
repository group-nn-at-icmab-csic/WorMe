function app_interf_boto_exit()

    % Botó app.ExitButton
    % Tanca la app

    % INICI FUNCIÓ
        [answer_msgebox] = quadre_decisio_modif("Do you really you want to exit?", "Exit box", "No", "Yes");
        % Note: result (true/false) is flipped.

        if ~answer_msgebox
            close all force
        end
                    
    % FINAL FUNCIÓ

end