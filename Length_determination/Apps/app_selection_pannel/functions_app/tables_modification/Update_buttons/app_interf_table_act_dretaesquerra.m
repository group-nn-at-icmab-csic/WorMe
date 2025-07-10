function app_interf_table_act_dretaesquerra(app)

% Determines the buttons depending on the position of the images (end, start,
% etc.)

% START OF THE FUNCTION

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


% END OF THE FUNCTION


end