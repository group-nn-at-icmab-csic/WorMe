function app_interf_taula_actu_return(app)

% Updates the return button if it is in the first position,
% according to conditions.

% START OF THE FUNCTION


if isequal(str2num(app.img_contLabel.Text), 1)
    if isempty(app.table_main_sel)
        app.ReturnButton.Visible = 'off';
    elseif isequal(height(app.table_main_sel(app.table_main_sel.Image == string(app.img_original_nomLabel.Text), :)), 1) 
        app.ReturnButton.Visible = 'off';
    elseif isequal(height(app.table_main_sel(app.table_main_sel.Image == string(app.img_original_nomLabel.Text), :)), 0)
        app.ReturnButton.Visible = 'off';        
    else
        app.ReturnButton.Visible = 'on';
    end
end

% END OF THE FUNCTION


end