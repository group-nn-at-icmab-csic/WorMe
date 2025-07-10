function [field_set] = app_proc_obten_fieldset(app)

% The field_set is obtained: path of the txt file of the modification.

% START OF FUNCTION


% Get the text selected from the ListBox, depending on the type of modification selected (temporary or saved)
if ~isempty(app.ModificacionstemporalsListBox.Value)
    value_listbox = app.ModificacionstemporalsListBox.Value;
    field_set = strcat("Results_out\Internal_code_files\Image_processing_settings\temporals\", string(value_listbox));
% If it is pre-selected in saved modifications
elseif ~isempty(app.ModificacionsguardadesListBox.Value)
    value_listbox = app.ModificacionsguardadesListBox.Value;
    % Read file and display in Label Modificacions
    field_set = strcat("Results_out\Internal_code_files\Image_processing_settings\", string(value_listbox));
end

% END OF FUNCTION

end