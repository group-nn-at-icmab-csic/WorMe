function appini_open_close_buttons(app, button_val)

% Aqui va la descripció
%
%
% Variables
%   input
%       app - app
%       button_val - 'on' o 'off' dels botóns
%
%
% See also
%


% INICI FUNCIÓ

app.DeterminescaleButton.Visible = button_val;
app.ScaleLabel.Visible = button_val;
app.EditField.Visible = button_val;
app.ModificacionsListBox.Visible = button_val;
app.ImageprocessmentconfigurationButton.Visible = button_val;
app.SavedprocessmentsLabel.Visible = button_val;


% FINAL FUNCIÓ


end