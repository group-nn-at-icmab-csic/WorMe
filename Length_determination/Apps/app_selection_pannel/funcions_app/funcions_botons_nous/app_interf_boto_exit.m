function app_interf_boto_exit()

    % Botó app.ExitButton
    % Tanca la app

    % START OF THE FUNCTION

        [answer_msgebox] = decision_box_modif("Do you really you want to exit?", "Exit box", "No", "Yes");
        % Note: result (true/false) is flipped.

        if ~answer_msgebox
            close all force
        end
                    
    % FINAL OF THE FUNCTION

end