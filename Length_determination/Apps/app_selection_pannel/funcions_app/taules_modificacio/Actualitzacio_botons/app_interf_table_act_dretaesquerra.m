function app_interf_table_act_dretaesquerra(app)

% Determina els botons en funcio la posicio de les imatges (final, inici,
% etc.)

% INICI FUNCIO

    n_imatge = str2num(app.img_contLabel.Text);
    
    if n_imatge == str2double(app.img_tot_nLabel.Text)
        app.RightButton.Visible = 'off';
        app.LeftButton.Visible = 'on';        
    elseif isequal(n_imatge, 1)
        app.RightButton.Visible = 'on';
        app.LeftButton.Visible = 'off';
    else
        app.RightButton.Visible = 'on';
        app.LeftButton.Visible = 'on';
    end


% FINAL FUNCIO

end